import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GuestStepperCircleButton extends StatelessWidget {
  const GuestStepperCircleButton({
    super.key,
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: enabled ? onTap : null,
      style: IconButton.styleFrom(
        fixedSize: const Size(42, 42),
        side: BorderSide(color: context.appPalette.border),
        foregroundColor: enabled
            ? context.appPalette.foreground
            : context.appPalette.iconMuted,
      ),
      icon: Icon(icon, size: 20),
    );
  }
}
