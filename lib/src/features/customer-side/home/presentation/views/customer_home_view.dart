import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomerHomeView extends StatelessWidget {
  const CustomerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Customer home',
          style: TextStyle(color: AppColors.muted, fontSize: 18),
        ),
      ),
    );
  }
}
