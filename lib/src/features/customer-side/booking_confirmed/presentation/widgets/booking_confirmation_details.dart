import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class BookingConfirmationDetails extends StatelessWidget {
  const BookingConfirmationDetails({
    super.key,
    required this.code,
    required this.total,
    this.discountAmount = 0,
    this.originalTotal = 0,
  });
  final String code;
  final int total;
  final int discountAmount;
  final int originalTotal;
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
        Text(
          context.l10n.confirmationDetails,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        if (discountAmount > 0) ...[
          const SizedBox(height: 18),
          Text(
            context.l10n.promotion,
            style: const TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 5),
          Text(
            '-${context.l10n.formatCurrency(discountAmount)}',
            style: const TextStyle(
              color: AppColors.success,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
        const SizedBox(height: 18),
        Text(
          context.l10n.confirmationCode,
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
        Text(
          context.l10n.totalPaid,
          style: const TextStyle(color: AppColors.muted),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            if (discountAmount > 0) ...[
              Text(
                context.l10n.formatCurrency(originalTotal),
                style: const TextStyle(
                  color: AppColors.muted,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: AppColors.muted,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              context.l10n.formatCurrency(total),
              style: const TextStyle(
                color: Color(0xFF10B981),
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
