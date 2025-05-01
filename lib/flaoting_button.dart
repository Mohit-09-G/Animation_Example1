import 'package:flutter/material.dart';

class AnimatedFabExample extends StatefulWidget {
  @override
  _AnimatedFabExampleState createState() => _AnimatedFabExampleState();
}

class _AnimatedFabExampleState extends State<AnimatedFabExample>
    with TickerProviderStateMixin {
  bool _isAdd = true;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFab() {
    setState(() {
      _isAdd = !_isAdd;

      _controller.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animated FAB Example')),
      body: Center(child: Text('Press the FAB to toggle')),
      floatingActionButton: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedCrossFade(
          duration: Duration(milliseconds: 300),
          firstChild: FloatingActionButton(
            onPressed: _toggleFab,
            tooltip: 'Add',
            child: Icon(Icons.add),
          ),
          secondChild: FloatingActionButton(
            onPressed: _toggleFab,
            tooltip: 'Edit',
            child: Icon(Icons.edit),
          ),
          crossFadeState:
              _isAdd ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ),
    );
  }
}
