# Glow Container


<p align="center">
    <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
</p>

A Flutter package that offers a highly customizable container widget with a captivating, dynamic glowing effect. This package enhances the visual appeal of your app's UI rectangular containers by adding an animated, luminous border to containers. Perfect for creating eye-catching buttons, cards, or any widget that needs an extra touch of elegance and interactivity.

<div align="center">
  <img src="example/screenshots/glow_container.gif" alt="Glow Container Example">
</div>

## Features

- Customizable glow colors
- Adjustable glow radius and spread
- Support for rectangular container shapes
- Animated glow effect with controllable duration
- Easy integration with existing Flutter widgets
- Support for gradient glow effects
- Customizable border properties (width, color, radius)

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  glow_container: ^0.0.1
```

## Usage

In this package you can create a glow container, here is an example of a page with the widget:

```dart
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
```

The following code is contained in the [ExampleWidget](./example/lib/example_widget.dart) file.

## Contributing

Contributions are welcome! If you'd like to contribute to this project, please feel free to submit a pull request or open an issue.
