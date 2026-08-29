import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RatingStarSelector extends StatelessWidget {
  const RatingStarSelector({
    required this.rating,
    required this.onChanged,
    super.key,
  });

  final int rating;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      5,
      (index) => IconButton(
        onPressed: () => onChanged(index + 1),
        iconSize: 38,
        splashRadius: 24,
        color: index < rating ? const Color(0xFFFACC15) : AppColors.border,
        icon: Icon(
          index < rating ? Icons.star_rounded : Icons.star_outline_rounded,
        ),
      ),
    ),
  );
}
