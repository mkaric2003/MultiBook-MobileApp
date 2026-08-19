import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/booking_status.dart';
import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/features/business-side/bookings/presentation/widgets/client_booking_status_pill.dart';
import 'package:aquabook/src/features/shared/chat/domain/models/chat_conversation_arguments.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class ManageBookingSheet extends StatelessWidget {
  const ManageBookingSheet({
    super.key,
    required this.booking,
    required this.onCancel,
  });
  final BookingModel booking;
  final Future<bool> Function(BookingModel booking) onCancel;
  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(
      color: Color(0xFF1A1A2E),
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 26, 24, 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Manage Booking',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.surfaceHighlight,
                  ),
                ),
              ],
            ),
            const Divider(height: 34, color: AppColors.surfaceHighlight),
            Container(
              padding: const EdgeInsets.all(24),
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
                        radius: 29,
                        backgroundImage:
                            (booking.customerAvatarUrl ?? '').isEmpty
                            ? null
                            : NetworkImage(booking.customerAvatarUrl!),
                        child: (booking.customerAvatarUrl ?? '').isEmpty
                            ? const Icon(Icons.person, color: AppColors.muted)
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking.customerName,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 7),
                          ClientBookingStatusPill(status: booking.status),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 27),
                  Row(
                    children: [
                      const Icon(
                        Icons.bed_rounded,
                        color: AppColors.primary,
                        size: 25,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          booking.roomType ?? 'Stay booking',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 39, top: 4),
                    child: Text(
                      'Stay reservation',
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: AppColors.primary,
                        size: 25,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${DateFormat('MMM d, y').format(booking.checkIn)} – ${DateFormat('MMM d, y').format(booking.checkOut)}',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Check-in: 3:00 PM • Check-out: 11:00 AM',
                              style: TextStyle(
                                color: AppColors.muted,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      const Icon(
                        Icons.groups,
                        color: AppColors.primary,
                        size: 26,
                      ),
                      const SizedBox(width: 14),
                      Text(
                        '$_totalGuests ${_totalGuests == 1 ? 'Guest' : 'Guests'}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        color: AppColors.primary,
                        size: 26,
                      ),
                      const SizedBox(width: 14),
                      Text(
                        '\$${booking.total}.00',
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (booking.status == BookingStatus.confirmed) ...[
              const SizedBox(height: 30),
              CustomButton(
                buttonName: '×  Cancel Booking',
                height: 70,
                color: Colors.transparent,
                textColor: const Color(0xFFFB4B4B),
                borderColor: const Color(0xFFFB4B4B),
                onPressed: () async {
                  final wasCancelled = await onCancel(booking);
                  if (!context.mounted) {
                    return;
                  }
                  if (wasCancelled) {
                    Navigator.of(context).pop();
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('We could not cancel this booking.'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 18),
            ],
            CustomButton(
              buttonName: 'Message customer',
              color: AppColors.surfaceHighlight,
              height: 70,
              onPressed: () {
                Navigator.of(context).pop();
                context.push(
                  AppRoutes.CHAT_CONVERSATION,
                  extra: ChatConversationArguments(
                    businessId: booking.businessId,
                    businessOwnerId: booking.businessOwnerId,
                    businessName: booking.businessName,
                    businessImageUrl: booking.businessImageUrl,
                    customerId: booking.customerId,
                    customerName: booking.customerName,
                    customerImageUrl: booking.customerAvatarUrl,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );

  int get _totalGuests => booking.adults + booking.children + booking.infants;
}
