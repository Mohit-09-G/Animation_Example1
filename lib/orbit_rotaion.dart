import 'dart:math';

import 'package:flutter/material.dart';

class OrbitingAnimationPage extends StatefulWidget {
  const OrbitingAnimationPage({super.key});

  @override
  State<OrbitingAnimationPage> createState() => _OrbitingAnimationPageState();
}

class _OrbitingAnimationPageState extends State<OrbitingAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final double orbitRadius = 120.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..repeat();
    _animation = Tween<double>(begin: 0, end: 2 * pi)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset getOrbitPosition(double angle, double radius) {
    return Offset(radius * cos(angle), radius * sin(angle));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                final angle = _animation.value;
                final moon1Pos = getOrbitPosition(angle, orbitRadius);
                final moon2Pos = getOrbitPosition(angle + pi / 2, orbitRadius);
                final moon3Pos = getOrbitPosition(angle + pi, orbitRadius);
                final moon4Pos =
                    getOrbitPosition(angle + 3 * pi / 2, orbitRadius);

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: angle,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF00FFF0), Color(0xFF9D00FF)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.cyanAccent.withOpacity(0.6),
                                blurRadius: 20,
                                spreadRadius: 4,
                              )
                            ]),
                      ),
                    ),
                    _buildMoon(moon1Pos, Colors.tealAccent),
                    _buildMoon(moon2Pos, Colors.deepPurpleAccent),
                    _buildMoon(moon3Pos, Colors.amberAccent),
                    _buildMoon(moon4Pos, Colors.pinkAccent),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget _buildMoon(Offset offset, Color color) {
    return Transform.translate(
        offset: offset,
        child: Container(
          width: 20,
          height: 20,
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.7),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ]),
        ));
  }
}
