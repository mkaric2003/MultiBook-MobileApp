import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/appointment_confirmed/domain/models/appointment_confirmed_arguments.dart';
import 'package:flutter/material.dart';

class AppointmentConfirmationCodeCard extends StatelessWidget {
  const AppointmentConfirmationCodeCard({required this.arguments, super.key});

  final AppointmentConfirmedArguments arguments;

  @override
  Widget build(BuildContext context) {
    final provider = arguments.payment.review.provider;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: .12),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.primary.withValues(alpha: .35)),
          ),
          child: Column(
            children: [
              Text(
                context.l10n.confirmationCode.toUpperCase(),
                style: TextStyle(color: AppColors.muted, fontSize: 13),
              ),
              const SizedBox(height: 10),
              Text(
                arguments.appointment.confirmationCode,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.showCodeToProvider,
                style: TextStyle(color: AppColors.muted),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Container(
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
              Text(
                context.l10n.quickInfo,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.serviceProvider,
                    style: TextStyle(color: AppColors.muted),
                  ),
                  Flexible(
                    child: Text(
                      provider.name,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
