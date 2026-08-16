import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StayDetailPageDot extends StatelessWidget {
  const StayDetailPageDot({super.key, this.active = false});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9,
      height: 9,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: active ? Colors.white : AppColors.muted,
        shape: BoxShape.circle,
      ),
    );
  }
}
