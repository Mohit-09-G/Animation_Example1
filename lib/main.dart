import 'package:animation_appp/flip_card_with_front_and_back_sides.dart';
import 'package:animation_appp/orbit_rotaion.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: OrbitingAnimationPage(),
    );
  }
}
