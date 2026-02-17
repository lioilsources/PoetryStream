import 'dart:async';
import 'dart:math';
import '../core/constants/visual.dart';
import '../models/verse_style.dart';
import '../models/verse_state.dart';
import '../models/display_mode.dart';
import '../core/utils/stanza_parser.dart';

class VerseEngineConfig {
  final Duration fadeInDuration;
  final Duration displayDuration;
  final Duration fadeOutDuration;
  final DisplayMode mode;

  const VerseEngineConfig({
    this.fadeInDuration = const Duration(milliseconds: 2800),
    this.displayDuration = const Duration(milliseconds: 8000),
    this.fadeOutDuration = const Duration(milliseconds: 700),
    this.mode = DisplayMode.stream,
  });

  Duration get cycleDuration =>
      fadeInDuration + displayDuration + fadeOutDuration;
}

class VerseEngine {
  final Random _random = Random();

  VerseEngineConfig _config;

  // Poem data
  List<String> _allStanzas = [];
  List<String> _poemTitles = [];

  // Stream mode (random shuffle) — tracks which poem each stanza belongs to
  List<_StanzaRef> _shuffledRefs = [];
  int _shuffleIndex = 0;

  // Čtení mode (random poem, sequential stanzas)
  int _seqPoemIndex = 0;
  int _seqStanzaIndex = 0;
  List<List<String>> _poemStanzas = [];
  List<int> _poemOrder = []; // random order of poem indices

  // Style tracking (avoid repeats)
  int _lastFontIdx = -1;
  int _lastPaletteIdx = -1;
  int _lastSizeIdx = -1;

  // Timer state
  Timer? _timer;
  bool _isPlaying = false;

  // Callback
  final void Function(VerseState state) onStateChanged;

  VerseEngine({
    required this.onStateChanged,
    VerseEngineConfig? config,
  }) : _config = config ?? const VerseEngineConfig();

  bool get isPlaying => _isPlaying;
  int get stanzaCount => _allStanzas.length;
  int get poemCount => _poemStanzas.length;

  void setPoems(List<String> poems, List<String> titles) {
    _allStanzas = poems.expand((p) => splitIntoStanzas(p)).toList();
    _poemStanzas = poems.map((p) => splitIntoStanzas(p)).toList();
    _poemTitles = titles;

    // Reset state
    _shuffledRefs = [];
    _shuffleIndex = 0;
    _seqPoemIndex = 0;
    _seqStanzaIndex = 0;
    _poemOrder = [];

    if (_isPlaying) {
      _restartCycle();
    }
  }

  void updateConfig(VerseEngineConfig config) {
    final modeChanged = _config.mode != config.mode;
    _config = config;

    if (modeChanged) {
      _seqPoemIndex = 0;
      _seqStanzaIndex = 0;
      _shuffleIndex = 0;
      _poemOrder = [];
    }

    if (_isPlaying) {
      _restartCycle();
    }
  }

  void play() {
    if (_isPlaying) return;
    _isPlaying = true;
    _showNext();
  }

  void pause() {
    if (!_isPlaying) return;
    _isPlaying = false;
    _timer?.cancel();
    _timer = null;
  }

  void toggle() {
    _isPlaying ? pause() : play();
  }

  /// Jump to the first stanza of the given poem index and restart playback.
  void jumpToPoem(int poemIndex) {
    if (_poemStanzas.isEmpty) return;
    final clamped = poemIndex.clamp(0, _poemStanzas.length - 1);
    // For Čtení, rebuild order starting with the selected poem
    _poemOrder = [clamped, ...List.generate(_poemStanzas.length, (i) => i)..shuffle(_random)];
    _poemOrder.removeAt(_poemOrder.lastIndexOf(clamped)); // remove duplicate
    _seqPoemIndex = 0;
    _seqStanzaIndex = 0;
    _restartCycle();
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }

  // -- Private --

  void _restartCycle() {
    _timer?.cancel();
    _timer = null;
    if (_isPlaying) {
      _showNext();
    }
  }

  void _showNext() {
    if (!_isPlaying || _allStanzas.isEmpty) return;

    final ref = _config.mode == DisplayMode.stream
        ? _nextRandom()
        : _nextSequential();

    if (ref == null) return;

    final style = _generateStyle();
    final title = ref.title;
    final stanzaIdx = ref.stanzaIndex;

    // Phase: fadeIn
    onStateChanged(VerseState(
      text: ref.text,
      style: style,
      phase: VersePhase.fadeIn,
      isPlaying: true,
      poemTitle: title,
      stanzaIndex: stanzaIdx,
    ));

    // Phase: display (after fadeIn completes)
    _timer = Timer(_config.fadeInDuration, () {
      onStateChanged(VerseState(
        text: ref.text,
        style: style,
        phase: VersePhase.display,
        isPlaying: true,
        poemTitle: title,
        stanzaIndex: stanzaIdx,
      ));

      // Phase: fadeOut (after display duration)
      _timer = Timer(_config.displayDuration, () {
        onStateChanged(VerseState(
          text: ref.text,
          style: style,
          phase: VersePhase.fadeOut,
          isPlaying: true,
          poemTitle: title,
          stanzaIndex: stanzaIdx,
        ));

        // Next verse (after fadeOut completes)
        _timer = Timer(_config.fadeOutDuration, () {
          _showNext();
        });
      });
    });
  }

  _StanzaRef? _nextRandom() {
    if (_allStanzas.isEmpty) return null;
    if (_shuffledRefs.isEmpty || _shuffleIndex >= _shuffledRefs.length) {
      // Build refs for all stanzas across all poems
      _shuffledRefs = [];
      for (int p = 0; p < _poemStanzas.length; p++) {
        final title = _poemTitle(p);
        for (int s = 0; s < _poemStanzas[p].length; s++) {
          _shuffledRefs.add(_StanzaRef(
            text: _poemStanzas[p][s],
            title: title,
            stanzaIndex: s,
          ));
        }
      }
      _shuffledRefs.shuffle(_random);
      _shuffleIndex = 0;
    }
    return _shuffledRefs[_shuffleIndex++];
  }

  _StanzaRef? _nextSequential() {
    if (_poemStanzas.isEmpty) return null;

    // Build random poem order if needed
    if (_poemOrder.isEmpty) {
      _poemOrder = List.generate(_poemStanzas.length, (i) => i)..shuffle(_random);
      _seqPoemIndex = 0;
      _seqStanzaIndex = 0;
    }

    // Skip empty poems
    int attempts = 0;
    while (_poemStanzas[_poemOrder[_seqPoemIndex]].isEmpty) {
      _seqPoemIndex = (_seqPoemIndex + 1) % _poemOrder.length;
      attempts++;
      if (attempts >= _poemOrder.length) return null;
    }

    final poemIdx = _poemOrder[_seqPoemIndex];
    final stanzas = _poemStanzas[poemIdx];
    final text = stanzas[_seqStanzaIndex];
    final title = _poemTitle(poemIdx);

    final ref = _StanzaRef(text: text, title: title, stanzaIndex: _seqStanzaIndex);

    _seqStanzaIndex++;
    if (_seqStanzaIndex >= stanzas.length) {
      _seqStanzaIndex = 0;
      _seqPoemIndex = (_seqPoemIndex + 1) % _poemOrder.length;
      // Reshuffle when we've gone through all poems
      if (_seqPoemIndex == 0) {
        _poemOrder.shuffle(_random);
      }
    }

    return ref;
  }

  VerseStyle _generateStyle() {
    final fontIdx = _pickDifferentIndex(VisualConstants.fonts.length, _lastFontIdx);
    final paletteIdx =
        _pickDifferentIndex(VisualConstants.palettes.length, _lastPaletteIdx);
    final sizeIdx =
        _pickDifferentIndex(VisualConstants.sizes.length, _lastSizeIdx);
    final isItalic = _random.nextDouble() < VisualConstants.italicChance;

    _lastFontIdx = fontIdx;
    _lastPaletteIdx = paletteIdx;
    _lastSizeIdx = sizeIdx;

    final font = VisualConstants.fonts[fontIdx];
    final palette = VisualConstants.palettes[paletteIdx];
    final size = VisualConstants.sizes[sizeIdx];

    return VerseStyle(
      fontFamily: font.family,
      fontWeight: font.weight,
      textColor: palette.text,
      glowColor: palette.glow,
      fontSize: size,
      isItalic: isItalic,
    );
  }

  String _poemTitle(int poemIndex) {
    final raw = poemIndex < _poemTitles.length ? _poemTitles[poemIndex] : '';
    return raw.isNotEmpty ? raw : 'Báseň ${poemIndex + 1}';
  }

  int _pickDifferentIndex(int length, int lastIndex) {
    if (length <= 1) return 0;
    int idx;
    do {
      idx = _random.nextInt(length);
    } while (idx == lastIndex);
    return idx;
  }
}

class _StanzaRef {
  final String text;
  final String title;
  final int stanzaIndex;

  const _StanzaRef({
    required this.text,
    required this.title,
    required this.stanzaIndex,
  });
}
