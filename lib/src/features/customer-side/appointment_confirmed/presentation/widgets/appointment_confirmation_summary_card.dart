import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/features/customer-side/appointment_confirmed/domain/models/appointment_confirmed_arguments.dart';
import 'package:aquabook/src/features/customer-side/appointment_confirmed/presentation/widgets/appointment_confirmation_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentConfirmationSummaryCard extends StatelessWidget {
  const AppointmentConfirmationSummaryCard({
    required this.arguments,
    super.key,
  });

  final AppointmentConfirmedArguments arguments;

  @override
  Widget build(BuildContext context) {
    final review = arguments.payment.review;
    final business = review.business;
    final duration = review.offerings.fold(
      0,
      (total, offering) => total + offering.durationMinutes,
    );
    final start = DateTime(
      2000,
      1,
      1,
    ).add(Duration(minutes: review.startMinutes));
    final end = start.add(Duration(minutes: duration));
    final imageUrl = business.logoUrl ?? business.coverPhotoUrl ?? '';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.surfaceHighlight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: 74,
                  height: 74,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const SizedBox(
                    width: 74,
                    height: 74,
                    child: ColoredBox(color: AppColors.surfaceHighlight),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      business.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      review.offerings.map((item) => item.name).join(', '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.muted),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '⭐ ${business.averageRating.toStringAsFixed(1)} • ${context.l10n.reviews(business.reviewCount)}',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          AppointmentConfirmationInfo(
            icon: Icons.calendar_month_rounded,
            label: 'DATE & TIME',
            value: DateFormat('EEEE, MMMM d, y').format(review.date),
            detail:
                '${DateFormat('h:mm a').format(start)} - ${DateFormat('h:mm a').format(end)}',
          ),
          const SizedBox(height: 14),
          AppointmentConfirmationInfo(
            icon: Icons.schedule_rounded,
            label: 'DURATION',
            value: '$duration minutes',
          ),
          if (arguments.appointment.discountAmount > 0) ...[
            const SizedBox(height: 14),
            AppointmentConfirmationInfo(
              icon: Icons.local_offer_outlined,
              label: context.l10n.promotion.toUpperCase(),
              value:
                  '-${context.l10n.formatCurrency(arguments.appointment.discountAmount)}',
              iconBackground: AppColors.success.withValues(alpha: .2),
              iconColor: AppColors.success,
            ),
          ],
          const SizedBox(height: 14),
          AppointmentConfirmationInfo(
            icon: Icons.attach_money_rounded,
            label: 'TOTAL AMOUNT',
            value: context.l10n.formatCurrency(arguments.appointment.total),
            originalValue: arguments.appointment.discountAmount > 0
                ? context.l10n.formatCurrency(arguments.payment.total)
                : null,
            detail: arguments.appointment.paymentStatus.name == 'pending'
                ? context.l10n.cashPaymentDue
                : 'Paid via ${arguments.appointment.paymentMethod}',
            iconBackground: AppColors.success.withValues(alpha: .2),
            iconColor: AppColors.success,
          ),
        ],
      ),
    );
  }
}
