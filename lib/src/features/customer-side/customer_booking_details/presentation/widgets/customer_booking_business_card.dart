import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:flutter/material.dart';

class CustomerBookingBusinessCard extends StatelessWidget {
  const CustomerBookingBusinessCard({super.key, required this.booking});
  final BookingModel booking;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: context.appPalette.surface,
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
            errorBuilder: (_, _, _) => SizedBox(
              width: 82,
              height: 82,
              child: ColoredBox(color: context.appPalette.surfaceHighlight),
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
                  Icon(
                    Icons.location_on,
                    size: 18,
                    color: context.appPalette.muted,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      booking.businessCity,
                      style: TextStyle(
                        color: context.appPalette.muted,
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
