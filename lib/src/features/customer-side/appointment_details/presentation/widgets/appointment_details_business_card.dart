import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/features/customer-side/appointment_details/domain/models/appointment_details_arguments.dart';
import 'package:aquabook/src/features/customer-side/appointment_details/domain/utils/appointment_details_formatters.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsBusinessCard extends StatelessWidget {
  const AppointmentDetailsBusinessCard({
    required this.arguments,
    required this.business,
    super.key,
  });

  final AppointmentDetailsArguments arguments;
  final BusinessModel? business;

  @override
  Widget build(BuildContext context) {
    final appointment = arguments.appointment;
    final imageUrl = appointment.businessImageUrl.isNotEmpty
        ? appointment.businessImageUrl
        : business?.coverPhotoUrl ?? business?.logoUrl ?? '';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceHighlight),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 66,
              height: 66,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const SizedBox(
                width: 66,
                height: 66,
                child: ColoredBox(color: AppColors.surfaceHighlight),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment.businessName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  business == null
                      ? 'Service business'
                      : AppointmentDetailsFormatters.businessCategory(
                          business!.categoryId,
                        ),
                  style: const TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 7),
                Text(
                  '⭐ ${business?.averageRating.toStringAsFixed(1) ?? '–'} (${business?.reviewCount ?? 0})',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
