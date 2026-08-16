import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Saved',
        style: TextStyle(color: AppColors.muted, fontSize: 18),
      ),
    );
  }
}
