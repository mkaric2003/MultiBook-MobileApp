import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:multibook/src/core/theme/app_colors.dart';

class SkeletonShimmer extends HookWidget {
  const SkeletonShimmer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 1400),
    );
    useEffect(() {
      controller.repeat();
      return null;
    }, [controller]);
    final progress = useAnimation(controller);
    final palette = context.appPalette;
    final baseColor = palette.surfaceHighlight;
    final highlightColor = Color.alphaBlend(
      palette.foreground.withValues(alpha: 0.12),
      baseColor,
    );

    return RepaintBoundary(
      child: ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) => LinearGradient(
          begin: Alignment(-2.5 + progress * 5, 0),
          end: Alignment(-1.5 + progress * 5, 0),
          colors: [baseColor, highlightColor, baseColor],
          stops: const [0, 0.5, 1],
        ).createShader(bounds),
        child: child,
      ),
    );
  }
}
