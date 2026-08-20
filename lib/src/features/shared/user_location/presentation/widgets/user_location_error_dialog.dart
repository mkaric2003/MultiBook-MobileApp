import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class UserLocationErrorDialog extends StatelessWidget {
  const UserLocationErrorDialog({
    required this.message,
    required this.canOpenSettings,
    required this.onOpenSettings,
    super.key,
  });

  final String message;
  final bool canOpenSettings;
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Location unavailable'),
      content: Text(message, style: const TextStyle(color: AppColors.muted)),
      actions: [
        if (canOpenSettings)
          TextButton(onPressed: onOpenSettings, child: const Text('Settings')),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
