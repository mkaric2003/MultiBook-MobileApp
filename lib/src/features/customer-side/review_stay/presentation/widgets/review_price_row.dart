import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ReviewPriceRow extends StatelessWidget {
  const ReviewPriceRow({
    super.key,
    required this.label,
    required this.value,
    this.bold = false,
  });
  final String label;
  final String value;
  final bool bold;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          label,
          style: TextStyle(
            color: bold
                ? context.appPalette.foreground
                : context.appPalette.muted,
            fontSize: 16,
            fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: 16,
          fontWeight: bold ? FontWeight.w800 : FontWeight.w700,
        ),
      ),
    ],
  );
}
