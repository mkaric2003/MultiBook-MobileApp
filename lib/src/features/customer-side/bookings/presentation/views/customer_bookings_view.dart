import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomerBookingsView extends StatelessWidget {
  const CustomerBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Bookings',
        style: TextStyle(color: AppColors.muted, fontSize: 18),
      ),
    );
  }
}
