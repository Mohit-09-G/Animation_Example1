import 'package:flutter/material.dart';
import 'dart:math' show pi;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation = Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller);
    _controller.repeat();
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
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(_animation.value),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00FFF0), Color(0xFF9D00FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.cyanAccent.withOpacity(0.6),
                      blurRadius: 20,
                      spreadRadius: 4,
                      offset: const Offset(0, 0),
                    ),
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.purpleAccent.withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 10,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
