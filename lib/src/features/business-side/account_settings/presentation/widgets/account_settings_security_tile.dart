import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AccountSettingsSecurityTile extends StatelessWidget {
  const AccountSettingsSecurityTile({super.key});

  @override
  Widget build(BuildContext context) => Container(
    height: 78,
    padding: const EdgeInsets.symmetric(horizontal: 24),
    decoration: BoxDecoration(
      color: AppColors.surface,
      border: Border.all(color: AppColors.border),
      borderRadius: BorderRadius.circular(14),
    ),
    child: const Row(
      children: [
        Expanded(
          child: Text(
            'Change Password',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        Icon(Icons.chevron_right, color: AppColors.muted, size: 30),
      ],
    ),
  );
}
