import 'package:flutter/material.dart';
import '../core/utils/stanza_parser.dart';
import '../models/poem.dart';

/// A single poem prepared for display in continuous scroll.
class PoemViewModel {
  final int corpusIndex; // index within the original poem list
  final String title;
  final List<String> stanzas;

  const PoemViewModel({
    required this.corpusIndex,
    required this.title,
    required this.stanzas,
  });
}

/// Controller for Browsing mode — continuous Word-like scroll through poems.
///
/// Uses a 3× repeated corpus trick: the list is [poems, poems, poems] and
/// the user starts in the middle copy. When they scroll near either edge,
/// we silently jump back to the center copy, creating infinite scroll.
class BrowsingController {
  static const int _copies = 3;

  List<Poem> _poems = [];
  List<PoemViewModel> _displayPoems = []; // 3× corpus
  int _corpusLength = 0;

  late ScrollController scrollController;

  // Keys for each poem section — used to calculate scroll targets
  final Map<int, GlobalKey> sectionKeys = {};

  void initialize(List<Poem> poems) {
    _poems = poems;
    _corpusLength = poems.length;
    scrollController = ScrollController();

    _buildDisplayList();

    scrollController.addListener(_onScroll);
  }

  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
  }

  void updatePoems(List<Poem> poems) {
    _poems = poems;
    _corpusLength = poems.length;
    _buildDisplayList();
  }

  bool get hasContent => _poems.isNotEmpty;

  int get poemCount => _corpusLength;

  List<PoemViewModel> get displayPoems => _displayPoems;

  /// Total number of display items (3× corpus).
  int get totalDisplayPoems => _displayPoems.length;

  /// Scroll to a specific poem by its corpus index (0-based).
  void scrollToPoem(int poemIndex) {
    // Target the middle copy
    final displayIndex = _corpusLength + poemIndex;
    final key = sectionKeys[displayIndex];
    if (key == null || key.currentContext == null) return;

    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  /// Get the corpus index of the currently visible poem.
  int getCurrentPoemIndex() {
    if (!scrollController.hasClients || _corpusLength == 0) return 0;

    // Find which section key is closest to the current viewport top
    int bestIndex = 0;
    double bestDistance = double.infinity;

    for (final entry in sectionKeys.entries) {
      final key = entry.value;
      if (key.currentContext == null) continue;

      final box = key.currentContext!.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) continue;

      final position = box.localToGlobal(Offset.zero).dy;
      // Consider items near the top of viewport (with some offset for the status bar area)
      final distance = (position - 120).abs();
      if (distance < bestDistance) {
        bestDistance = distance;
        bestIndex = entry.key;
      }
    }

    return bestIndex % _corpusLength;
  }

  void _buildDisplayList() {
    _displayPoems = [];
    sectionKeys.clear();

    for (int copy = 0; copy < _copies; copy++) {
      for (int i = 0; i < _corpusLength; i++) {
        final poem = _poems[i];
        final displayIndex = copy * _corpusLength + i;
        _displayPoems.add(PoemViewModel(
          corpusIndex: i,
          title: poem.title.isNotEmpty ? poem.title : 'Báseň ${i + 1}',
          stanzas: splitIntoStanzas(poem.fullText),
        ));
        sectionKeys[displayIndex] = GlobalKey();
      }
    }
  }

  void _onScroll() {
    if (!scrollController.hasClients || _corpusLength == 0) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final offset = scrollController.offset;

    // When near the top edge, jump forward to middle copy
    if (offset < maxScroll * 0.1) {
      _recenterToMiddle();
    }
    // When near the bottom edge, jump back to middle copy
    else if (offset > maxScroll * 0.9) {
      _recenterToMiddle();
    }
  }

  void _recenterToMiddle() {
    if (!scrollController.hasClients || _corpusLength == 0) return;

    final currentPoemIdx = getCurrentPoemIndex();
    final targetDisplayIndex = _corpusLength + currentPoemIdx;
    final key = sectionKeys[targetDisplayIndex];
    if (key == null || key.currentContext == null) return;

    final box = key.currentContext!.findRenderObject() as RenderBox?;
    if (box == null) return;

    // Calculate the offset of this section in the scroll view
    final scrollPosition = scrollController.position;
    final currentOffset = scrollController.offset;
    final globalPosition = box.localToGlobal(Offset.zero).dy;
    // The section's scroll offset = currentOffset + (globalY - viewport top)
    final viewportTop = 0.0; // approximate
    final sectionScrollOffset =
        currentOffset + globalPosition - viewportTop - 120;

    scrollController.jumpTo(sectionScrollOffset.clamp(
      scrollPosition.minScrollExtent,
      scrollPosition.maxScrollExtent,
    ));
  }
}
