import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Explore',
        style: TextStyle(color: AppColors.muted, fontSize: 18),
      ),
    );
  }
}
