import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChatTypingIndicator extends HookWidget {
  const ChatTypingIndicator({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 900),
    )..repeat();
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(
                  16,
                ).copyWith(bottomLeft: const Radius.circular(3)),
              ),
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, _) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    3,
                    (index) => _TypingDot(
                      progress: (controller.value + index / 3) % 1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              context.l10n.isTyping(name),
              style: const TextStyle(color: AppColors.muted, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypingDot extends StatelessWidget {
  const _TypingDot({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final height = progress < 0.5 ? progress * 8 : (1 - progress) * 8;
    return Transform.translate(
      offset: Offset(0, -height),
      child: Container(
        width: 6,
        height: 6,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
