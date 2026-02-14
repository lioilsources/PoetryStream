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

  // Stream mode (random shuffle)
  List<String> _shuffledStanzas = [];
  int _shuffleIndex = 0;

  // Čtení mode (sequential)
  int _seqPoemIndex = 0;
  int _seqStanzaIndex = 0;
  List<List<String>> _poemStanzas = [];

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

  void setPoems(List<String> poems) {
    _allStanzas = poems.expand((p) => splitIntoStanzas(p)).toList();
    _poemStanzas = poems.map((p) => splitIntoStanzas(p)).toList();

    // Reset state
    _shuffledStanzas = [];
    _shuffleIndex = 0;
    _seqPoemIndex = 0;
    _seqStanzaIndex = 0;

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

    final text = _config.mode == DisplayMode.stream
        ? _nextRandom()
        : _nextSequential();

    if (text == null) return;

    final style = _generateStyle();

    // Phase: fadeIn
    onStateChanged(VerseState(
      text: text,
      style: style,
      phase: VersePhase.fadeIn,
      isPlaying: true,
    ));

    // Phase: display (after fadeIn completes)
    _timer = Timer(_config.fadeInDuration, () {
      onStateChanged(VerseState(
        text: text,
        style: style,
        phase: VersePhase.display,
        isPlaying: true,
      ));

      // Phase: fadeOut (after display duration)
      _timer = Timer(_config.displayDuration, () {
        onStateChanged(VerseState(
          text: text,
          style: style,
          phase: VersePhase.fadeOut,
          isPlaying: true,
        ));

        // Next verse (after fadeOut completes)
        _timer = Timer(_config.fadeOutDuration, () {
          _showNext();
        });
      });
    });
  }

  String? _nextRandom() {
    if (_allStanzas.isEmpty) return null;
    if (_shuffledStanzas.isEmpty || _shuffleIndex >= _shuffledStanzas.length) {
      _shuffledStanzas = List.of(_allStanzas)..shuffle(_random);
      _shuffleIndex = 0;
    }
    return _shuffledStanzas[_shuffleIndex++];
  }

  String? _nextSequential() {
    if (_poemStanzas.isEmpty) return null;

    // Skip empty poems
    int attempts = 0;
    while (_poemStanzas[_seqPoemIndex].isEmpty) {
      _seqPoemIndex = (_seqPoemIndex + 1) % _poemStanzas.length;
      attempts++;
      if (attempts >= _poemStanzas.length) return null;
    }

    final stanzas = _poemStanzas[_seqPoemIndex];
    final text = stanzas[_seqStanzaIndex];

    _seqStanzaIndex++;
    if (_seqStanzaIndex >= stanzas.length) {
      _seqStanzaIndex = 0;
      _seqPoemIndex = (_seqPoemIndex + 1) % _poemStanzas.length;
    }

    return text;
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

  int _pickDifferentIndex(int length, int lastIndex) {
    if (length <= 1) return 0;
    int idx;
    do {
      idx = _random.nextInt(length);
    } while (idx == lastIndex);
    return idx;
  }
}
