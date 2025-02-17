import 'package:flutter/material.dart';

extension ColorExtension on Color {
  String toHexString() => '#${r.round().toRadixString(16).padLeft(2, '0')}${g.round().toRadixString(16).padLeft(2, '0')}${b.round().toRadixString(16).padLeft(2, '0')}'.toUpperCase();
}

class ContainerTab extends StatelessWidget {
  final double? width;
  final double? height;
  final Function(double?) onWidthChanged;
  final Function(double?) onHeightChanged;
  final AlignmentGeometry? alignment;
  final Function(AlignmentGeometry?) onAlignmentChanged;
  final Color? backgroundColor;
  final Function(Color?) onBackgroundColorChanged;
  final BoxConstraints? constraints;
  final Function(BoxConstraints?) onConstraintsChanged;

  const ContainerTab({
    super.key,
    required this.width,
    required this.height,
    required this.onWidthChanged,
    required this.onHeightChanged,
    required this.alignment,
    required this.onAlignmentChanged,
    required this.backgroundColor,
    required this.onBackgroundColorChanged,
    required this.constraints,
    required this.onConstraintsChanged,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Size",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 8),
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
                      value: width?.clamp(200, 500) ?? 200,
                      min: 200,
                      max: 500,
                      onChanged: (value) {
                        onWidthChanged(value);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      width?.toStringAsFixed(0) ?? "200",
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
                      "Height",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Slider(
                      value: height?.clamp(50, 500) ?? 50,
                      min: 50,
                      max: 500,
                      onChanged: (value) {
                        onHeightChanged(value);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      height?.toStringAsFixed(0) ?? "50",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "Appearance",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Alignment",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withValues(alpha: 128),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButton<AlignmentGeometry?>(
                        value: alignment,
                        isExpanded: true,
                        underline: SizedBox(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 204),
                        ),
                        onChanged: onAlignmentChanged,
                        items: [
                          DropdownMenuItem<AlignmentGeometry?>(
                            value: null,
                            child: Text(
                              'Default',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          ...{
                            'Top Left': Alignment.topLeft,
                            'Top Center': Alignment.topCenter,
                            'Top Right': Alignment.topRight,
                            'Center Left': Alignment.centerLeft,
                            'Center': Alignment.center,
                            'Center Right': Alignment.centerRight,
                            'Bottom Left': Alignment.bottomLeft,
                            'Bottom Center': Alignment.bottomCenter,
                            'Bottom Right': Alignment.bottomRight,
                          }.entries.map((entry) {
                            return DropdownMenuItem<AlignmentGeometry?>(
                              value: entry.value,
                              child: Text(
                                entry.key,
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Background",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withValues(alpha: 128),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: backgroundColor ?? Colors.transparent,
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(7)),
                              border: backgroundColor == null
                                  ? Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outline
                                          .withValues(alpha: 128),
                                    )
                                  : null,
                            ),
                            child: backgroundColor == null
                                ? Icon(
                                    Icons.format_color_fill,
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  )
                                : null,
                          ),
                          Container(
                            width: 1,
                            height: 32,
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withValues(alpha: 51),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Text(
                                    "#",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 204),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: TextField(
                                      controller: TextEditingController(
                                        text: backgroundColor != null
                                            ? backgroundColor!.toHexString().substring(1)
                                            : '',
                                      ),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'monospace',
                                        letterSpacing: 1,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'RRGGBB',
                                        hintStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withValues(alpha: 102),
                                          fontSize: 16,
                                          fontFamily: 'monospace',
                                          letterSpacing: 1,
                                        ),
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      onChanged: (value) {
                                        if (value.isEmpty) {
                                          onBackgroundColorChanged(null);
                                          return;
                                        }

                                        String hex = value.replaceAll('#', '');
                                        if (hex.length == 6) {
                                          hex = 'FF$hex';
                                        }

                                        if (hex.length == 8) {
                                          try {
                                            final color =
                                                Color(int.parse('0x$hex'));
                                            onBackgroundColorChanged(color);
                                          } catch (e) {
                                            // Invalid hex color
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (backgroundColor != null)
                            IconButton(
                              icon: Icon(
                                Icons.clear,
                                size: 20,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 102),
                              ),
                              onPressed: () => onBackgroundColorChanged(null),
                            ),
                        ],
                      ),
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
