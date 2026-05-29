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

  // Hold-to-pause bookkeeping for the currently scheduled phase timer. Tracking
  // the remaining time lets the user long-press to freeze the current verse and
  // resume it exactly where it left off.
  Duration? _pendingRemaining;
  DateTime? _pendingStartedAt;
  void Function()? _pendingCallback;
  bool _isHeld = false;

  // Callback
  final void Function(VerseState state) onStateChanged;

  VerseEngine({
    required this.onStateChanged,
    VerseEngineConfig? config,
  }) : _config = config ?? const VerseEngineConfig();

  bool get isPlaying => _isPlaying;
  bool get isHeld => _isHeld;
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
    _cancelPending();
  }

  void toggle() {
    _isPlaying ? pause() : play();
  }

  /// Temporarily suspends the verse cycle while the user holds (long-press) to
  /// keep reading. The remaining time of the active phase is preserved so
  /// [release] can resume exactly where it left off.
  void hold() {
    if (!_isPlaying || _isHeld) return;
    _isHeld = true;
    if (_pendingStartedAt != null && _pendingRemaining != null) {
      final elapsed = DateTime.now().difference(_pendingStartedAt!);
      var remaining = _pendingRemaining! - elapsed;
      if (remaining < Duration.zero) remaining = Duration.zero;
      _pendingRemaining = remaining;
      _pendingStartedAt = null;
    }
    _timer?.cancel();
    _timer = null;
  }

  /// Resumes the cycle suspended by [hold].
  void release() {
    if (!_isHeld) return;
    _isHeld = false;
    if (!_isPlaying) return;
    final cb = _pendingCallback;
    final remaining = _pendingRemaining;
    if (cb != null && remaining != null) {
      _pendingStartedAt = DateTime.now();
      _timer?.cancel();
      _timer = Timer(remaining, cb);
    }
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

  void _cancelPending() {
    _timer?.cancel();
    _timer = null;
    _pendingStartedAt = null;
    _pendingRemaining = null;
    _pendingCallback = null;
    _isHeld = false;
  }

  /// Schedules [cb] after [d], recording enough to pause/resume it via
  /// [hold]/[release]. While held, the timer is not started but its remaining
  /// time is banked for [release].
  void _schedule(Duration d, void Function() cb) {
    _timer?.cancel();
    _pendingRemaining = d;
    _pendingCallback = cb;
    if (_isHeld) {
      _pendingStartedAt = null;
      return;
    }
    _pendingStartedAt = DateTime.now();
    _timer = Timer(d, cb);
  }

  void _restartCycle() {
    _cancelPending();
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
    _schedule(_config.fadeInDuration, () {
      onStateChanged(VerseState(
        text: ref.text,
        style: style,
        phase: VersePhase.display,
        isPlaying: true,
        poemTitle: title,
        stanzaIndex: stanzaIdx,
      ));

      // Phase: fadeOut (after display duration)
      _schedule(_config.displayDuration, () {
        onStateChanged(VerseState(
          text: ref.text,
          style: style,
          phase: VersePhase.fadeOut,
          isPlaying: true,
          poemTitle: title,
          stanzaIndex: stanzaIdx,
        ));

        // Next verse (after fadeOut completes)
        _schedule(_config.fadeOutDuration, () {
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
