import 'package:flutter/material.dart';

/// A thin progress line showing how long until the current verse fades out.
///
/// Rendered as a hairline along the bottom edge so it stays in the periphery
/// and never competes with the centered verse. The fill is tinted with the
/// active verse's glow colour for cohesion and is driven by an external
/// [progress] animation so it can be paused in lockstep with the engine (e.g.
/// while the reader long-presses to finish a verse).
class VerseProgressBar extends StatelessWidget {
  const VerseProgressBar({
    super.key,
    required this.progress,
    required this.color,
  });

  /// 0.0 → 1.0 as the verse elapses towards fade-out.
  final Animation<double> progress;

  /// Tint for the filled portion of the bar.
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 2,
      child: Stack(
        children: [
          // Faint track so the line's extent is hinted at, not stark.
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
          // Animated fill growing left → right.
          Positioned.fill(
            child: AnimatedBuilder(
              animation: progress,
              builder: (context, _) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress.value.clamp(0.0, 1.0).toDouble(),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(1),
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
