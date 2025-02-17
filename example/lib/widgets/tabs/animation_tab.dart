import 'package:flutter/material.dart';

class AnimationTab extends StatelessWidget {
  final Duration rotationDuration;
  final Function(Duration) onRotationDurationChanged;
  final Duration transitionDuration;
  final Function(Duration) onTransitionDurationChanged;

  const AnimationTab({
    super.key,
    required this.rotationDuration,
    required this.onRotationDurationChanged,
    required this.transitionDuration,
    required this.onTransitionDurationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
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
              Row(
                children: [
                  Expanded(
                    flex: 3,
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
                      value: rotationDuration.inMilliseconds.toDouble(),
                      min: 500,
                      max: 5000,
                      onChanged: (value) {
                        onRotationDurationChanged(
                          Duration(milliseconds: value.toInt()),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      rotationDuration.inMilliseconds.toString(),
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
                    flex: 3,
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
                      value: transitionDuration.inMilliseconds.toDouble(),
                      min: 100,
                      max: 1000,
                      onChanged: (value) {
                        onTransitionDurationChanged(
                          Duration(milliseconds: value.toInt()),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      transitionDuration.inMilliseconds.toString(),
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
    );
  }
}
