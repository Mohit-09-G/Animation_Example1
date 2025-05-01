import 'package:flutter/material.dart';
import 'dart:math';

class SmoothLiquidLoaderPage extends StatefulWidget {
  const SmoothLiquidLoaderPage({super.key});

  @override
  State<SmoothLiquidLoaderPage> createState() => _SmoothLiquidLoaderPageState();
}

class _SmoothLiquidLoaderPageState extends State<SmoothLiquidLoaderPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(); // Continuous flow to simulate the stream

    _animation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(
          parent: _controller, curve: Curves.easeInOut), // Smooth curve
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
      backgroundColor: Colors.white,
      body: Center(
        child: CustomPaint(
          size: Size(200, 400), // Container size
          painter: SmoothLiquidPainter(_animation),
        ),
      ),
    );
  }
}

class SmoothLiquidPainter extends CustomPainter {
  final Animation<double> animation;

  SmoothLiquidPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.blueAccent.withOpacity(0.8),
          Colors.cyan.withOpacity(0.6)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    Path path = Path();

    path.moveTo(0, size.height);

    // Simulate a very smooth continuous fluid flow using the animation value
    for (double x = 0.0; x <= size.width; x++) {
      double y = size.height -
          (sin((x + animation.value * 10) / 20) * 8 +
              40); // Smooth fluid wave with reduced frequency for gentleness
      path.lineTo(x, y);
    }

    // Close the path for the liquid shape
    path.lineTo(size.width, size.height);
    path.close();

    // Clip the path for the liquid within the container
    canvas.clipPath(path);

    // Draw the liquid using the shader
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
