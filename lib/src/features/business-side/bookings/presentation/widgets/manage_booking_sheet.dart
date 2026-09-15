import 'package:multibook/app.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/data/enums/booking_status.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/features/business-side/bookings/presentation/widgets/client_booking_status_pill.dart';
import 'package:multibook/src/features/shared/chat/domain/models/chat_conversation_arguments.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class ManageBookingSheet extends StatelessWidget {
  const ManageBookingSheet({
    super.key,
    required this.booking,
    required this.onDecline,
    required this.onComplete,
    required this.onNoShow,
  });
  final BookingModel booking;
  final Future<bool> Function(BookingModel booking) onDecline;
  final Future<bool> Function(BookingModel booking) onComplete;
  final Future<bool> Function(BookingModel booking) onNoShow;
  @override
  Widget build(BuildContext context) {
    final canMarkNoShow =
        _isCashBooking &&
        DateTime.now().isAfter(booking.checkOut) &&
        (booking.status == BookingStatus.confirmed ||
            booking.status == BookingStatus.completed);
    return Container(
      decoration: BoxDecoration(
        color: context.appPalette.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Manage Booking',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    style: IconButton.styleFrom(
                      backgroundColor: context.appPalette.surfaceHighlight,
                    ),
                  ),
                ],
              ),
              Divider(height: 26, color: context.appPalette.surfaceHighlight),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.appPalette.surface,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 23,
                          backgroundImage:
                              (booking.customerAvatarUrl ?? '').isEmpty
                              ? null
                              : NetworkImage(booking.customerAvatarUrl!),
                          child: (booking.customerAvatarUrl ?? '').isEmpty
                              ? Icon(
                                  Icons.person,
                                  color: context.appPalette.muted,
                                )
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Column(
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
                            ClientBookingStatusPill(status: booking.status),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        const Icon(
                          Icons.bed_rounded,
                          color: AppColors.primary,
                          size: 21,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            booking.roomType ?? 'Stay booking',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 31, top: 3),
                      child: Text(
                        'Stay reservation',
                        style: TextStyle(
                          color: context.appPalette.muted,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: AppColors.primary,
                          size: 21,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${DateFormat('MMM d, y').format(booking.checkIn)} – ${DateFormat('MMM d, y').format(booking.checkOut)}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                context.l10n.checkInOutTimes,
                                style: TextStyle(
                                  color: context.appPalette.muted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        const Icon(
                          Icons.groups,
                          color: AppColors.primary,
                          size: 21,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '$_totalGuests ${_totalGuests == 1 ? 'Guest' : 'Guests'}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        const Icon(
                          Icons.attach_money,
                          color: AppColors.primary,
                          size: 21,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          context.l10n.formatCurrency(booking.total),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (booking.status == BookingStatus.confirmed) ...[
                const SizedBox(height: 20),
                if (DateTime.now().isAfter(booking.checkOut)) ...[
                  CustomButton(
                    buttonName: context.l10n.markAsCompleted,
                    height: 52,
                    onPressed: () async {
                      final wasCompleted = await onComplete(booking);
                      if (wasCompleted && context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  if (canMarkNoShow) ...[
                    CustomButton(
                      buttonName: context.l10n.markAsNoShow,
                      height: 52,
                      color: Colors.transparent,
                      textColor: const Color(0xFFFB4B4B),
                      borderColor: const Color(0xFFFB4B4B),
                      onPressed: () async {
                        final wasMarkedNoShow = await onNoShow(booking);
                        if (wasMarkedNoShow && context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 1),
                          child: Icon(
                            Icons.info_outline,
                            size: 15,
                            color: context.appPalette.muted,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            context.l10n.noShowEarningsHint,
                            style: TextStyle(
                              color: context.appPalette.muted,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ],
                CustomButton(
                  buttonName: '×  ${context.l10n.declineBooking}',
                  height: 52,
                  color: Colors.transparent,
                  textColor: const Color(0xFFFB4B4B),
                  borderColor: const Color(0xFFFB4B4B),
                  onPressed: () async {
                    final wasDeclined = await onDecline(booking);
                    if (!context.mounted) {
                      return;
                    }
                    if (wasDeclined) {
                      Navigator.of(context).pop();
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(context.l10n.couldNotDeclineBooking),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
              ],
              CustomButton(
                buttonName: context.l10n.messageCustomer,
                color: context.appPalette.surfaceHighlight,
                height: 52,
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
  }

  int get _totalGuests => booking.adults + booking.children + booking.infants;

  bool get _isCashBooking =>
      booking.paymentMethod.trim().toLowerCase() == 'cash' ||
      booking.paymentStatus.name == 'pending';
}
