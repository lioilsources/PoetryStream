import 'dart:math';
import 'package:flutter/material.dart';
import '../core/constants/visual.dart';
import '../core/utils/stanza_parser.dart';
import '../models/poem.dart';
import '../models/verse_style.dart';

class StanzaViewModel {
  final String text;
  final String poemTitle;
  final VerseStyle style;
  final bool isFirstInPoem;
  final bool isLastInPoem;
  final int stanzaIndexInPoem; // 0-based
  final int totalStanzasInPoem;

  const StanzaViewModel({
    required this.text,
    required this.poemTitle,
    required this.style,
    required this.isFirstInPoem,
    required this.isLastInPoem,
    required this.stanzaIndexInPoem,
    required this.totalStanzasInPoem,
  });
}

class ListovaniController {
  static const bufferSize = 15;
  static const bufferCenter = 7;
  static const bufferEdge = 2; // Trigger reload when this close to edge

  final Random _random = Random();

  List<Poem> _poems = [];
  List<List<String>> _poemStanzas = [];
  int _totalStanzas = 0;

  // Current position in corpus
  int _currentPoemIndex = 0;
  int _currentStanzaIndex = 0;

  // Style tracking
  int _lastFontIdx = -1;
  int _lastPaletteIdx = -1;
  int _lastSizeIdx = -1;

  // Buffer
  List<StanzaViewModel> buffer = [];
  late PageController pageController;

  // Callback for poem title changes
  void Function(String poemTitle)? onPoemChanged;

  void initialize(List<Poem> poems) {
    _poems = poems;
    _poemStanzas = poems.map((p) => splitIntoStanzas(p.fullText)).toList();
    _totalStanzas = _poemStanzas.fold(0, (sum, s) => sum + s.length);

    _currentPoemIndex = 0;
    _currentStanzaIndex = 0;

    _loadBuffer();
    pageController = PageController(initialPage: bufferCenter);
  }

  void dispose() {
    pageController.dispose();
  }

  void updatePoems(List<Poem> poems) {
    _poems = poems;
    _poemStanzas = poems.map((p) => splitIntoStanzas(p.fullText)).toList();
    _totalStanzas = _poemStanzas.fold(0, (sum, s) => sum + s.length);

    // Clamp current position
    if (_currentPoemIndex >= _poems.length) {
      _currentPoemIndex = 0;
      _currentStanzaIndex = 0;
    }

    _loadBuffer();
  }

  bool get hasContent => _totalStanzas > 0;

  void onPageChanged(int pageIndex) {
    // Calculate actual offset from center
    final offset = pageIndex - bufferCenter;
    if (offset == 0) return;

    // Move current position
    _advance(offset);

    // Check if we need to reload buffer
    if (pageIndex <= bufferEdge || pageIndex >= bufferSize - 1 - bufferEdge) {
      _loadBuffer();
      // Jump to center without animation
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (pageController.hasClients) {
          pageController.jumpToPage(bufferCenter);
        }
      });
    }

    // Notify poem change
    final currentItem = buffer[pageIndex];
    if (currentItem.isFirstInPoem || currentItem.isLastInPoem) {
      onPoemChanged?.call(currentItem.poemTitle);
    }
  }

  void _advance(int offset) {
    if (_poemStanzas.isEmpty) return;

    _currentStanzaIndex += offset;

    // Forward wrap
    while (_currentStanzaIndex >= _poemStanzas[_currentPoemIndex].length) {
      _currentStanzaIndex -= _poemStanzas[_currentPoemIndex].length;
      _currentPoemIndex = (_currentPoemIndex + 1) % _poems.length;
    }

    // Backward wrap
    while (_currentStanzaIndex < 0) {
      _currentPoemIndex =
          (_currentPoemIndex - 1 + _poems.length) % _poems.length;
      _currentStanzaIndex += _poemStanzas[_currentPoemIndex].length;
    }
  }

  void _loadBuffer() {
    buffer = [];
    if (_totalStanzas == 0) return;

    for (int i = -bufferCenter; i <= bufferCenter; i++) {
      buffer.add(_getStanzaAtOffset(i));
    }
  }

  StanzaViewModel _getStanzaAtOffset(int offset) {
    int poemIdx = _currentPoemIndex;
    int stanzaIdx = _currentStanzaIndex + offset;

    // Forward wrap
    while (stanzaIdx >= _poemStanzas[poemIdx].length) {
      stanzaIdx -= _poemStanzas[poemIdx].length;
      poemIdx = (poemIdx + 1) % _poems.length;
    }

    // Backward wrap
    while (stanzaIdx < 0) {
      poemIdx = (poemIdx - 1 + _poems.length) % _poems.length;
      stanzaIdx += _poemStanzas[poemIdx].length;
    }

    final stanzas = _poemStanzas[poemIdx];
    final poem = _poems[poemIdx];

    return StanzaViewModel(
      text: stanzas[stanzaIdx],
      poemTitle: poem.title.isNotEmpty ? poem.title : 'Báseň ${poemIdx + 1}',
      style: _generateStyle(),
      isFirstInPoem: stanzaIdx == 0,
      isLastInPoem: stanzaIdx == stanzas.length - 1,
      stanzaIndexInPoem: stanzaIdx,
      totalStanzasInPoem: stanzas.length,
    );
  }

  VerseStyle _generateStyle() {
    final fontIdx =
        _pickDifferentIndex(VisualConstants.fonts.length, _lastFontIdx);
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
