import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/visual.dart';
import '../data/repositories/collection_repository.dart';
import '../models/poem.dart';

class PoemListButton extends StatelessWidget {
  final List<Poem> poems;
  final int currentPoemIndex;
  final void Function(int poemIndex) onPoemSelected;

  const PoemListButton({
    super.key,
    required this.poems,
    required this.currentPoemIndex,
    required this.onPoemSelected,
  });

  void _openSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _PoemListSheet(
        poems: poems,
        currentPoemIndex: currentPoemIndex,
        onPoemSelected: (index) {
          Navigator.of(context).pop();
          onPoemSelected(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'BÁSNĚ',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 14,
            letterSpacing: 2,
            color: Colors.white.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }
}

class _PoemListSheet extends StatefulWidget {
  final List<Poem> poems;
  final int currentPoemIndex;
  final void Function(int index) onPoemSelected;

  const _PoemListSheet({
    required this.poems,
    required this.currentPoemIndex,
    required this.onPoemSelected,
  });

  @override
  State<_PoemListSheet> createState() => _PoemListSheetState();
}

class _PoemListSheetState extends State<_PoemListSheet> {
  late Set<String> _expanded;

  @override
  void initState() {
    super.initState();
    // Všechny sbírky rozbaleny při otevření
    _expanded = widget.poems.map((p) => p.collectionId).toSet();
  }

  void _toggleCollection(String collectionId) {
    setState(() {
      if (_expanded.contains(collectionId)) {
        _expanded.remove(collectionId);
      } else {
        _expanded.add(collectionId);
      }
    });
  }

  /// Seskupí básně podle collectionId, zachová pořadí sbírek dle prvního výskytu.
  Map<String, List<MapEntry<int, Poem>>> _buildGroups() {
    final groups = <String, List<MapEntry<int, Poem>>>{};
    for (final entry in widget.poems.asMap().entries) {
      groups.putIfAbsent(entry.value.collectionId, () => []).add(entry);
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final groups = _buildGroups();

    // Sestavit plochý seznam položek pro ListView
    final items = <Widget>[];
    bool firstGroup = true;
    for (final collectionId in groups.keys) {
      final groupPoems = groups[collectionId]!;
      final isExpanded = _expanded.contains(collectionId);
      final title = collectionDisplayTitle(collectionId);

      if (!firstGroup) {
        items.add(Divider(
          color: Colors.white.withValues(alpha: 0.06),
          height: 24,
        ));
      }
      firstGroup = false;

      // Header sbírky
      items.add(
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _toggleCollection(collectionId),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text(
                  isExpanded ? '▾ ' : '› ',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.35),
                  ),
                ),
                Expanded(
                  child: Text(
                    title.toUpperCase(),
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 13,
                      letterSpacing: 2,
                      color: Colors.white.withValues(alpha: 0.4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '${groupPoems.length}',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 13,
                    letterSpacing: 1,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Básně sbírky (animovaně zobrazeny/skryty)
      items.add(
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: isExpanded
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: groupPoems.map((entry) {
                    final flatIndex = entry.key;
                    final poem = entry.value;
                    final isCurrent = flatIndex == widget.currentPoemIndex;
                    final poemTitle = poem.title.isNotEmpty
                        ? poem.title
                        : 'Báseň ${flatIndex + 1}';
                    final stanzaCount = poem.stanzas.length;

                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => widget.onPoemSelected(flatIndex),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 8,
                          bottom: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              poemTitle,
                              style: GoogleFonts.spectral(
                                fontSize: 17,
                                color: Colors.white.withValues(
                                  alpha: isCurrent ? 0.9 : 0.65,
                                ),
                                fontWeight: isCurrent
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$stanzaCount strof',
                              style: GoogleFonts.spectral(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.25),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )
              : const SizedBox.shrink(),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(top: topPadding + 40),
      decoration: BoxDecoration(
        color: VisualConstants.backgroundColor,
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 8),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sbírky',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 22,
                  color: Colors.white.withValues(alpha: 0.6),
                  letterSpacing: 1,
                ),
              ),
            ),
          ),

          const SizedBox(height: 4),

          // Grouped list
          Flexible(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              children: items,
            ),
          ),
        ],
      ),
    );
  }
}
