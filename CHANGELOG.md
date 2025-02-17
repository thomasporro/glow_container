## 1.0.0

* [BREAKING CHANGE] Removed the `borderWidth` and `borderColor` parameters from the ContainerOptions class. Use the `borderSide` parameter instead.

* Added the `glowLocation` parameter to the GlowContainer widget to control where the effect is located on the container.

* Updated the example to demonstrate the usage of the new `glowLocation` parameter.


## 0.1.0

* Fixed an issue where the border of the glowing container wouldn't adapt correctly to its radius when the `radius` parameter was lower than `thickness / 2`.

* Added the `borderSide` parameter to the ContainerOptions class to control the border style of the glowing container.

* Deprecated the ContainerOptions' `borderWidth` and `borderColor` parameters. Use the `borderSide` parameter instead. These parameters will be removed in a future version.

* Updated the example to demonstrate the usage of the new ContainerOptions' `borderSide` parameter.


## 0.0.5

* Fixed behaviour that led the glowing border to be displayed in the wrong position when the widget was created using the `ContainerOptions`' margin.

* Optmized the widget's performance

## 0.0.4

* Fixed behaviour that showed the glow when the widget was created with `showAnimatedBorder: false`

## 0.0.3

* Add docs to AnimatedBorderPainter

* Add assert to AnimatedBorderPainter to ensure the validity of the parameters

## 0.0.2

* Update pubspec.yaml and README.md

## 0.0.1

* Initial release
