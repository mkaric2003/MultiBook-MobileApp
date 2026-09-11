import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AccountSettingsSecurityTile extends StatelessWidget {
  const AccountSettingsSecurityTile({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(14),
    child: Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: context.appPalette.surface,
        border: Border.all(color: context.appPalette.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              context.l10n.changePassword,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          Icon(Icons.chevron_right, color: context.appPalette.muted, size: 24),
        ],
      ),
    ),
  );
}
