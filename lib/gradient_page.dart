import 'package:flutter/material.dart';
import 'dart:math';

class GradientPulsePage extends StatefulWidget {
  const GradientPulsePage({super.key});

  @override
  State<GradientPulsePage> createState() => _GradientPulsePageState();
}

class _GradientPulsePageState extends State<GradientPulsePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CustomPaint(
          size: Size(300, 300),
          painter: GradientPulsePainter(_animation),
        ),
      ),
    );
  }
}

class GradientPulsePainter extends CustomPainter {
  final Animation<double> animation;

  GradientPulsePainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = RadialGradient(
        colors: [
          Colors.blue.withOpacity(1.0),
          Colors.purple.withOpacity(0.5),
          Colors.red.withOpacity(0.0),
        ],
        stops: [
          0.0,
          animation.value,
          1.0,
        ],
        center: Alignment.center,
        radius: animation.value * 0.6 + 0.4,
      ).createShader(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2));

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
