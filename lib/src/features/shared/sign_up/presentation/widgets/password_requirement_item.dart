import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PasswordRequirementItem extends StatelessWidget {
  const PasswordRequirementItem({
    super.key,
    required this.label,
    required this.met,
  });

  final String label;
  final bool met;

  @override
  Widget build(BuildContext context) {
    final textColor = context.appPalette.muted;
    const okColor = Color(0xFF34D399);
    const errColor = Color(0xFFF28B82);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          met ? Icons.check_rounded : Icons.close_rounded,
          size: 18,
          color: met ? okColor : errColor,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: textColor, fontSize: 16, height: 1.2),
          ),
        ),
      ],
    );
  }
}
