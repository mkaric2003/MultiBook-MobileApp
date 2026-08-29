import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
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
      title: Text(context.l10n.locationUnavailable),
      content: Text(message, style: const TextStyle(color: AppColors.muted)),
      actions: [
        if (canOpenSettings)
          TextButton(
            onPressed: onOpenSettings,
            child: Text(context.l10n.openSettings),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.ok),
        ),
      ],
    );
  }
}
