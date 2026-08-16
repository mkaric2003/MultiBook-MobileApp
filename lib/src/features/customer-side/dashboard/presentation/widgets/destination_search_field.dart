import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DestinationSearchField extends StatelessWidget {
  const DestinationSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF101010),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColors.surfaceHighlight),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Text(
              'Where to?',
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(Icons.location_on_rounded, color: AppColors.muted, size: 20),
          SizedBox(width: 12),
          Icon(Icons.filter_alt_rounded, color: AppColors.muted, size: 20),
          SizedBox(width: 12),
          Icon(Icons.mic_none_rounded, color: AppColors.muted, size: 20),
        ],
      ),
    );
  }
}
