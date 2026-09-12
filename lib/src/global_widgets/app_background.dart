import 'package:flutter/material.dart';
import 'package:multibook/src/core/theme/app_colors.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return ColoredBox(color: context.appPalette.background, child: child);
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: context.appPalette.backgroundGradient,
          ),
        ),
        ColoredBox(color: Colors.white.withValues(alpha: 0.6)),
        child,
      ],
    );
  }
}
