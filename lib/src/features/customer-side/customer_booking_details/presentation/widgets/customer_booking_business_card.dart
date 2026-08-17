import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:flutter/material.dart';

class CustomerBookingBusinessCard extends StatelessWidget {
  const CustomerBookingBusinessCard({super.key, required this.booking});
  final BookingModel booking;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            booking.businessImageUrl,
            width: 82,
            height: 82,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const SizedBox(
              width: 82,
              height: 82,
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
                booking.businessName,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 18,
                    color: AppColors.muted,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      booking.businessCity,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
