import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../core/constants/visual.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _BackgroundPainter(progress: _controller.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final double progress;

  _BackgroundPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // Base color
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = VisualConstants.backgroundColor,
    );

    final t = sin(progress * 2 * pi);

    // Warm gradient (moves from 30%,50% to 60%,40%)
    final warmX = _lerp(0.3, 0.6, (t + 1) / 2) * size.width;
    final warmY = _lerp(0.5, 0.4, (t + 1) / 2) * size.height;
    _drawRadialGlow(
      canvas,
      Offset(warmX, warmY),
      size.width * 0.7,
      const Color(0xE619120A), // rgba(25,18,10,0.9)
    );

    // Cool gradient (moves from 70%,30% to 30%,70%)
    final coolX = _lerp(0.7, 0.3, (t + 1) / 2) * size.width;
    final coolY = _lerp(0.3, 0.7, (t + 1) / 2) * size.height;
    _drawRadialGlow(
      canvas,
      Offset(coolX, coolY),
      size.width * 0.6,
      const Color(0x990C141C), // rgba(12,20,28,0.6)
    );
  }

  void _drawRadialGlow(Canvas canvas, Offset center, double radius, Color color) {
    final gradient = ui.Gradient.radial(
      center,
      radius,
      [color, color.withValues(alpha: 0)],
      [0.0, 1.0],
    );
    canvas.drawRect(
      Rect.fromLTWH(
        center.dx - radius,
        center.dy - radius,
        radius * 2,
        radius * 2,
      ),
      Paint()
        ..shader = gradient
        ..blendMode = BlendMode.screen,
    );
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;

  @override
  bool shouldRepaint(_BackgroundPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class GrainOverlay extends StatelessWidget {
  const GrainOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: 0.025,
        child: CustomPaint(
          painter: _GrainPainter(),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _GrainPainter extends CustomPainter {
  final Random _random = Random(42); // Fixed seed for consistent grain

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 1;
    const step = 4.0;

    for (double x = 0; x < size.width; x += step) {
      for (double y = 0; y < size.height; y += step) {
        final brightness = _random.nextInt(256);
        paint.color = Color.fromARGB(255, brightness, brightness, brightness);
        canvas.drawRect(Rect.fromLTWH(x, y, step, step), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
