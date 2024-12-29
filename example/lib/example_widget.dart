import 'package:flutter/material.dart';
import 'package:glow_container/glow_container.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GlowContainer(
          glowRadius: 20,
          gradientColors: [Colors.blue, Colors.purple, Colors.pink],
          rotationDuration: Duration(seconds: 3),
          containerOptions: ContainerOptions(
            width: 200,
            height: 200,
            borderRadius: 15,
            backgroundColor: Colors.black,
          ),
          transitionDuration: Duration(milliseconds: 300),
          showAnimatedBorder: true,
          child: Center(
            child: Text(
              'Glowing Container',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
