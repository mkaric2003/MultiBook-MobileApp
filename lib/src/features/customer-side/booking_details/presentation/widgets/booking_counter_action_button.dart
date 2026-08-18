import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BookingCounterActionButton extends StatelessWidget {
  const BookingCounterActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.outlined = false,
  });
  final IconData icon;
  final VoidCallback onPressed;
  final bool outlined;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 41,
    height: 41,
    child: outlined
        ? OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
              side: const BorderSide(color: AppColors.border),
            ),
            child: Icon(icon),
          )
        : FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
            ),
            child: Icon(icon),
          ),
  );
}
