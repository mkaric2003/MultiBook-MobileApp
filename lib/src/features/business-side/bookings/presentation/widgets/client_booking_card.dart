import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/features/business-side/bookings/presentation/widgets/client_booking_status_pill.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
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
    padding: const EdgeInsets.all(14),
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
              radius: 22,
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
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    booking.roomType ?? 'Stay booking',
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ClientBookingStatusPill(status: booking.status),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Icon(Icons.watch_later_rounded, color: AppColors.primary, size: 21),
            const SizedBox(width: 5),
            Text(
              '${DateFormat('MMM d, y').format(booking.checkIn)} – ${DateFormat('MMM d, y').format(booking.checkOut)}',
              style: const TextStyle(color: AppColors.muted, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 9),
        Row(
          children: [
            Icon(
              _totalGuests < 2 ? Icons.person : Icons.groups,
              color: AppColors.primary,
              size: 21,
            ),
            const SizedBox(width: 5),
            Text(
              '$_totalGuests ${_totalGuests == 1 ? 'guest' : 'guests'}',
              style: const TextStyle(color: AppColors.muted, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 14),
        CustomButton(
          buttonName: context.l10n.manage,
          height: 44,
          onPressed: () async => onManage(),
        ),
      ],
    ),
  );

  int get _totalGuests => booking.adults + booking.children + booking.infants;
}
