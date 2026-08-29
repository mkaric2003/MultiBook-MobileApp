import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StayRatingSelector extends StatelessWidget {
  const StayRatingSelector({
    super.key,
    required this.minimumRating,
    required this.onChanged,
  });

  final double minimumRating;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      children: [
        for (var index = 1; index <= 5; index++)
          IconButton(
            onPressed: () =>
                onChanged(minimumRating == index ? 0 : index.toDouble()),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 30, height: 34),
            icon: Icon(
              index <= minimumRating
                  ? Icons.star_rounded
                  : Icons.star_outline_rounded,
              color: index <= minimumRating
                  ? const Color(0xFFFACC15)
                  : AppColors.iconMuted,
              size: 29,
            ),
          ),
        const SizedBox(width: 8),
        Text(
          minimumRating == 0 ? 'Any rating' : '${minimumRating.toInt()}+ stars',
          style: const TextStyle(color: AppColors.muted, fontSize: 16),
        ),
      ],
    );
  }
}
