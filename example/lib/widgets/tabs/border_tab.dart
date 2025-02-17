import 'package:flutter/material.dart';

class BorderTab extends StatelessWidget {
  final double borderWidth;
  final Function(double) onBorderWidthChanged;
  final double borderRadius;
  final Function(double) onBorderRadiusChanged;

  const BorderTab({
    super.key,
    required this.borderWidth,
    required this.onBorderWidthChanged,
    required this.borderRadius,
    required this.onBorderRadiusChanged,
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
                      "Width",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Slider(
                      value: borderWidth,
                      min: 1,
                      max: 20,
                      onChanged: onBorderWidthChanged,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      borderWidth.toStringAsFixed(1),
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
                      value: borderRadius,
                      min: 0,
                      max: 40,
                      onChanged: onBorderRadiusChanged,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      borderRadius.toStringAsFixed(1),
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
