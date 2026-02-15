import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/visual.dart';
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

class _PoemListSheet extends StatelessWidget {
  final List<Poem> poems;
  final int currentPoemIndex;
  final void Function(int index) onPoemSelected;

  const _PoemListSheet({
    required this.poems,
    required this.currentPoemIndex,
    required this.onPoemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

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
                'Seznam básní',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 22,
                  color: Colors.white.withValues(alpha: 0.6),
                  letterSpacing: 1,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Poem list
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              itemCount: poems.length,
              itemBuilder: (context, index) {
                final poem = poems[index];
                final isCurrent = index == currentPoemIndex;
                final title = poem.title.isNotEmpty
                    ? poem.title
                    : 'Báseň ${index + 1}';
                final stanzaCount = poem.stanzas.length;

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onPoemSelected(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.spectral(
                            fontSize: 18,
                            color: Colors.white.withValues(
                              alpha: isCurrent ? 0.9 : 0.6,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
