import 'package:flutter/material.dart';
import 'package:glow_container/glow_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '[DEMO] Glow Container',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showGlowingBorder = true;
  double _borderWidth = 1;
  double _borderRadius = 0;
  double _glowRadius = 4;
  Duration _rotationDuration = const Duration(milliseconds: 2000);
  Duration _transitionDuration = const Duration(milliseconds: 300);
  int _numberOfColors = 3;

  static const _glowColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GlowContainer(
                          containerOptions: ContainerOptions(
                            borderRadius: _borderRadius,
                            padding: const EdgeInsets.all(8.0),
                            borderSide: BorderSide(
                              color: Color(0xFF000000),
                              width: _borderWidth,
                            ),
                          ),
                          gradientColors:
                              _glowColors.take(_numberOfColors).toList(),
                          glowRadius: _glowRadius,
                          showAnimatedBorder: _showGlowingBorder,
                          rotationDuration: _rotationDuration,
                          transitionDuration: _transitionDuration,
                          child: Text(
                            'Glow Container',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          // child: SizedBox.square(
                          //   dimension: 50,
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Glow Colors",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Enable glowing border",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 18),
                            ),
                            Spacer(),
                            Switch(
                              value: _showGlowingBorder,
                              onChanged: (value) {
                                setState(() {
                                  _showGlowingBorder = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "N. colors",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Slider(
                                value: _numberOfColors.toDouble(),
                                min: 1,
                                max: 10,
                                onChanged: (value) {
                                  setState(() {
                                    _numberOfColors = value.toInt();
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                _numberOfColors.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Transition speed (ms)",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Slider(
                                value: _transitionDuration.inMilliseconds
                                    .toDouble(),
                                min: 100,
                                max: 2000,
                                onChanged: (value) {
                                  setState(() {
                                    _transitionDuration =
                                        Duration(milliseconds: value.toInt());
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                _transitionDuration.inMilliseconds.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Border Options",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Width",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Slider(
                                value: _borderWidth,
                                min: 1,
                                max: 20,
                                onChanged: (value) {
                                  setState(() {
                                    _borderWidth = value;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                _borderWidth.toStringAsFixed(1),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Radius",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Slider(
                                value: _borderRadius,
                                min: 0,
                                max: 40,
                                onChanged: (value) {
                                  setState(() {
                                    _borderRadius = value;
                                  });
                                },
                                label: 'Border Width',
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                _borderRadius.toStringAsFixed(1),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Glow Options",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Radius",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Slider(
                                value: _glowRadius,
                                min: 0,
                                max: 40,
                                onChanged: (value) {
                                  setState(() {
                                    _glowRadius = value;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                _glowRadius.toStringAsFixed(1),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Rotation speed (ms)",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Slider(
                                value:
                                    _rotationDuration.inMilliseconds.toDouble(),
                                min: 100,
                                max: 5000,
                                onChanged: (value) {
                                  setState(() {
                                    _rotationDuration =
                                        Duration(milliseconds: value.toInt());
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                _rotationDuration.inMilliseconds.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
