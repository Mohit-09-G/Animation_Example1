import 'package:flutter/material.dart';
import 'dart:math' show pi;

class FlipCardWithFrontAndBackSides extends StatefulWidget {
  const FlipCardWithFrontAndBackSides({super.key});

  @override
  State<FlipCardWithFrontAndBackSides> createState() => _HomePageState();
}

class _HomePageState extends State<FlipCardWithFrontAndBackSides>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = Tween<double>(begin: 0.0, end: pi).animate(_controller)
      ..addListener(() {
        setState(() {});
        if (_controller.value >= 0.5 && isFront) {
          isFront = false;
        } else if (_controller.value < 0.5 && !isFront) {
          isFront = true;
        }
      });
  }

  void flipCard() {
    if (_controller.isCompleted || _controller.velocity > 0) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double angle = _animation.value;
    bool isBackVisible = angle >= pi / 2;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F0C29), Color(0xFF302B63), Color(0xFF24243E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: GestureDetector(
            onTap: flipCard,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: isBackVisible
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(pi),
                        child: _buildCardSide("HACKED", Colors.pinkAccent),
                      )
                    : _buildCardSide("ENTER", Colors.cyanAccent),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardSide(String text, Color neonColor) {
    return Container(
      decoration: BoxDecoration(
        color: neonColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: neonColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: neonColor.withOpacity(0.8),
            blurRadius: 25,
            spreadRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: neonColor,
          letterSpacing: 2,
          shadows: [
            Shadow(
              blurRadius: 12,
              color: neonColor,
              offset: const Offset(0, 0),
            ),
          ],
        ),
      ),
    );
  }
}
