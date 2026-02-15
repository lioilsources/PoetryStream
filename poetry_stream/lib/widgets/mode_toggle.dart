import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/display_mode.dart';

class ModeToggle extends StatelessWidget {
  final DisplayMode currentMode;
  final ValueChanged<DisplayMode> onModeChanged;

  const ModeToggle({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption(DisplayMode.stream, 'Stream'),
          _buildOption(DisplayMode.reading, 'Čtení'),
          _buildOption(DisplayMode.browsing, 'Listování'),
        ],
      ),
    );
  }

  Widget _buildOption(DisplayMode mode, String label) {
    final isActive = currentMode == mode;
    return GestureDetector(
      onTap: () => onModeChanged(mode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          label,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 13,
            letterSpacing: 1,
            color: isActive
                ? Colors.white.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.25),
          ),
        ),
      ),
    );
  }
}
