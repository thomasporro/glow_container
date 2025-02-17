import 'package:example/widgets/tabs/animation_tab.dart';
import 'package:example/widgets/tabs/border_tab.dart';
import 'package:example/widgets/tabs/container_tab.dart';
import 'package:example/widgets/tabs/general_tab.dart';
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
  double _borderRadius = 8;
  double _glowRadius = 4;
  Duration _rotationDuration = const Duration(milliseconds: 2000);
  Duration _transitionDuration = const Duration(milliseconds: 300);
  int _numberOfColors = 3;
  GlowLocation _glowLocation = GlowLocation.both;

  // Container options
  double? _width = 200;
  double? _height = 50;
  AlignmentGeometry? _alignment = Alignment.center;
  Color? _backgroundColor;
  BoxConstraints? _constraints;

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
            Container(
              height: 200,
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
                        glowLocation: _glowLocation,
                        containerOptions: ContainerOptions(
                          borderRadius: _borderRadius,
                          alignment: _alignment,
                          backgroundColor: _backgroundColor,
                          constraints: _constraints,
                          width: _width,
                          height: _height,
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
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(text: 'General'),
                        Tab(text: 'Border'),
                        Tab(text: 'Container'),
                        Tab(text: 'Animation'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          GeneralTab(
                            showGlowingBorder: _showGlowingBorder,
                            onShowGlowingBorderChanged: (value) {
                              setState(() {
                                _showGlowingBorder = value;
                              });
                            },
                            glowLocation: _glowLocation,
                            onGlowLocationChanged: (value) {
                              setState(() {
                                _glowLocation = value;
                              });
                            },
                            numberOfColors: _numberOfColors,
                            onNumberOfColorsChanged: (value) {
                              setState(() {
                                _numberOfColors = value;
                              });
                            },
                            glowRadius: _glowRadius,
                            onGlowRadiusChanged: (value) {
                              setState(() {
                                _glowRadius = value;
                              });
                            },
                          ),
                          BorderTab(
                            borderWidth: _borderWidth,
                            onBorderWidthChanged: (value) {
                              setState(() {
                                _borderWidth = value;
                              });
                            },
                            borderRadius: _borderRadius,
                            onBorderRadiusChanged: (value) {
                              setState(() {
                                _borderRadius = value;
                              });
                            },
                          ),
                          ContainerTab(
                            width: _width,
                            height: _height,
                            onWidthChanged: (value) {
                              setState(() {
                                _width = value;
                              });
                            },
                            onHeightChanged: (value) {
                              setState(() {
                                _height = value;
                              });
                            },
                            alignment: _alignment,
                            onAlignmentChanged: (value) {
                              setState(() {
                                _alignment = value;
                              });
                            },
                            backgroundColor: _backgroundColor,
                            onBackgroundColorChanged: (value) {
                              setState(() {
                                _backgroundColor = value;
                              });
                            },
                            constraints: _constraints,
                            onConstraintsChanged: (value) {
                              setState(() {
                                _constraints = value;
                              });
                            },
                          ),
                          AnimationTab(
                            rotationDuration: _rotationDuration,
                            onRotationDurationChanged: (value) {
                              setState(() {
                                _rotationDuration = value;
                              });
                            },
                            transitionDuration: _transitionDuration,
                            onTransitionDurationChanged: (value) {
                              setState(() {
                                _transitionDuration = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
