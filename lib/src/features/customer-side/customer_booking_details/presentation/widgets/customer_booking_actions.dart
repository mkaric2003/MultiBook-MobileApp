import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/booking_status.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CustomerBookingActions extends StatelessWidget {
  const CustomerBookingActions({
    super.key,
    required this.booking,
    required this.isCancelling,
    required this.onCancel,
    required this.onBookAgain,
    required this.onLeaveReview,
    required this.hasSubmittedReview,
  });
  final BookingModel booking;
  final bool isCancelling;
  final Future<void> Function() onCancel;
  final Future<void> Function() onBookAgain;
  final Future<void> Function() onLeaveReview;
  final bool hasSubmittedReview;

  bool get _isPast {
    final now = DateTime.now();
    return booking.checkOut.isBefore(DateTime(now.year, now.month, now.day));
  }

  bool get _canCancel => !_isPast && booking.status == BookingStatus.confirmed;

  bool get _canReview => booking.status == BookingStatus.completed || _isPast;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      if (_canCancel) ...[
        CustomButton(
          buttonName: context.l10n.cancelBooking,
          color: const Color(0xFFDC2626),
          textColor: AppColors.white,
          onPressed: onCancel,
          enabled: !isCancelling,
        ),
        const SizedBox(height: 14),
      ],
      if (_canReview && !hasSubmittedReview) ...[
        CustomButton(
          buttonName: context.l10n.leaveReview,
          onPressed: onLeaveReview,
        ),
        const SizedBox(height: 14),
      ],
      if (_isPast) ...[
        CustomButton(
          buttonName: context.l10n.bookAgain,
          color: context.appPalette.surfaceHighlight,
          onPressed: onBookAgain,
        ),
      ],
    ],
  );
}
