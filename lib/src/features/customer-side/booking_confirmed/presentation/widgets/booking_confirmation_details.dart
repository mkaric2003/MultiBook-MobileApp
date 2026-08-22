import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class BookingConfirmationDetails extends StatelessWidget {
  const BookingConfirmationDetails({
    super.key,
    required this.code,
    required this.total,
  });
  final String code;
  final int total;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: AppColors.surface,
      border: Border.all(color: AppColors.border),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Confirmation Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 18),
        const Text(
          'Confirmation Code',
          style: TextStyle(color: AppColors.muted),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surfaceHighlight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  code,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              const Icon(Icons.copy, color: AppColors.primary),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text(context.l10n.totalPaid, style: const TextStyle(color: AppColors.muted)),
        const SizedBox(height: 5),
        Text(
          '\$$total',
          style: const TextStyle(
            color: Color(0xFF10B981),
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}
