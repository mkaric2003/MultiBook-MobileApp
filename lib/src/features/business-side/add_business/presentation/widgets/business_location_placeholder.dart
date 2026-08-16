import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BusinessLocationPlaceholder extends StatelessWidget {
  const BusinessLocationPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 178,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_on, color: AppColors.primary, size: 30),
          SizedBox(height: 10),
          Text(
            'Tap to place pin on map',
            style: TextStyle(color: AppColors.muted, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
