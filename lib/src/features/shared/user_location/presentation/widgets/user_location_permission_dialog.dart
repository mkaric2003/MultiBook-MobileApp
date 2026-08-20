import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserLocationPermissionDialog extends StatelessWidget {
  const UserLocationPermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Row(
        children: [
          Icon(Icons.location_on_rounded, color: AppColors.primary),
          SizedBox(width: 10),
          Text('Use your location'),
        ],
      ),
      content: const Text(
        'Allow MultiBook to use your current location so we can save your city and show relevant stays and services nearby.',
        style: TextStyle(color: AppColors.muted, height: 1.4),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomButton(
              buttonName: 'Use current location',
              height: 46,
              fontSize: 15,
              onPressed: () => Navigator.of(context).pop(true),
            ),
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Not now'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
