import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StanzaProgress extends StatelessWidget {
  final int current; // 1-based
  final int total;

  const StanzaProgress({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$current / $total',
      textAlign: TextAlign.center,
      style: GoogleFonts.spectral(
        fontSize: 12,
        color: Colors.white.withValues(alpha: 0.2),
        letterSpacing: 1,
      ),
    );
  }
}

class PoemTitleCard extends StatefulWidget {
  final String title;
  final VoidCallback? onDismissed;

  const PoemTitleCard({
    super.key,
    required this.title,
    this.onDismissed,
  });

  @override
  State<PoemTitleCard> createState() => _PoemTitleCardState();
}

class _PoemTitleCardState extends State<PoemTitleCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 30),
    ]).animate(_controller);

    _controller.forward().then((_) => widget.onDismissed?.call());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacity,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Text(
          widget.title,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.5),
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
