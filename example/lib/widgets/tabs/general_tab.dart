import 'package:flutter/material.dart';
import 'package:glow_container/glow_container.dart';

class GeneralTab extends StatelessWidget {
  final bool showGlowingBorder;
  final Function(bool) onShowGlowingBorderChanged;
  final GlowLocation glowLocation;
  final Function(GlowLocation) onGlowLocationChanged;
  final int numberOfColors;
  final Function(int) onNumberOfColorsChanged;
  final double glowRadius;
  final Function(double) onGlowRadiusChanged;

  const GeneralTab({
    super.key,
    required this.showGlowingBorder,
    required this.onShowGlowingBorderChanged,
    required this.glowLocation,
    required this.onGlowLocationChanged,
    required this.numberOfColors,
    required this.onNumberOfColorsChanged,
    required this.glowRadius,
    required this.onGlowRadiusChanged,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Glow Location",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  LayoutBuilder(builder: (context, constraints) {
                    return ToggleButtons(
                      onPressed: (int index) {
                        onGlowLocationChanged(GlowLocation.values[index]);
                      },
                      isSelected: GlowLocation.values
                          .map((e) => e == glowLocation)
                          .toList(),
                      constraints: BoxConstraints.expand(
                        width: (constraints.maxWidth -
                                (GlowLocation.values.length - 1) * 4) /
                            GlowLocation.values.length,
                        height: 40,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      selectedBorderColor: Theme.of(context).colorScheme.primary,
                      selectedColor: Theme.of(context).colorScheme.onPrimary,
                      fillColor: Theme.of(context).colorScheme.primary,
                      children: GlowLocation.values.map((location) {
                        return Text(
                          location.toString().split('.').last,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        );
                      }).toList(),
                    );
                  }),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    "Enable glowing border",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  Spacer(),
                  Switch(
                    value: showGlowingBorder,
                    onChanged: onShowGlowingBorderChanged,
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
                      value: numberOfColors.toDouble(),
                      min: 1,
                      max: 10,
                      onChanged: (value) {
                        onNumberOfColorsChanged(value.toInt());
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      numberOfColors.toString(),
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
                      "Glow radius",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Slider(
                      value: glowRadius,
                      min: 0,
                      max: 20,
                      onChanged: onGlowRadiusChanged,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      glowRadius.toStringAsFixed(1),
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
