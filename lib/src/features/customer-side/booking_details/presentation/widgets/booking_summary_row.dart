import 'package:flutter/material.dart';

class BookingSummaryRow extends StatelessWidget {
  const BookingSummaryRow({
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
