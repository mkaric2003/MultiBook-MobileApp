import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class PromotionBadge extends StatelessWidget {
  const PromotionBadge({super.key});

  @override
  Widget build(BuildContext context) => Transform.rotate(
    angle: 0.785398,
    child: Container(
      width: 118,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 5),
      color: AppColors.primary,
      child: Text(
        context.l10n.promotion,
        maxLines: 1,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
      ),
    ),
  );
}
