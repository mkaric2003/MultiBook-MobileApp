import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/features/business-side/bookings/presentation/widgets/client_booking_status_pill.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClientBookingCard extends StatelessWidget {
  const ClientBookingCard({
    super.key,
    required this.booking,
    required this.onManage,
  });
  final BookingModel booking;
  final VoidCallback onManage;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: const Color(0xFF172554),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: (booking.customerAvatarUrl ?? '').isEmpty
                  ? null
                  : NetworkImage(booking.customerAvatarUrl!),
              child: (booking.customerAvatarUrl ?? '').isEmpty
                  ? const Icon(Icons.person, color: AppColors.muted)
                  : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.customerName,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    booking.roomType ?? 'Stay booking',
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ClientBookingStatusPill(status: booking.status),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Icon(Icons.watch_later_rounded, color: AppColors.primary, size: 25),
            const SizedBox(width: 5),
            Text(
              '${DateFormat('MMM d, y').format(booking.checkIn)} – ${DateFormat('MMM d, y').format(booking.checkOut)}',
              style: const TextStyle(color: AppColors.muted, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 9),
        Row(
          children: [
            Icon(
              _totalGuests < 2 ? Icons.person : Icons.groups,
              color: AppColors.primary,
              size: 25,
            ),
            const SizedBox(width: 5),
            Text(
              '$_totalGuests ${_totalGuests == 1 ? 'guest' : 'guests'}',
              style: const TextStyle(color: AppColors.muted, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 20),
        CustomButton(
          buttonName: 'Manage',
          height: 50,
          onPressed: () async => onManage(),
        ),
      ],
    ),
  );

  int get _totalGuests => booking.adults + booking.children + booking.infants;
}
