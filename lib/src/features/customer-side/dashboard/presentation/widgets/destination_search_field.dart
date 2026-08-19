import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DestinationSearchField extends StatelessWidget {
  const DestinationSearchField({
    required this.onTap,
    required this.hintText,
    super.key,
  });

  final VoidCallback onTap;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF101010),
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: AppColors.surfaceHighlight),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                hintText,
                style: const TextStyle(
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
      ),
    );
  }
}
