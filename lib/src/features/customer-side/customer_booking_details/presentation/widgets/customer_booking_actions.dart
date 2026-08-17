import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/booking_status.dart';
import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CustomerBookingActions extends StatelessWidget {
  const CustomerBookingActions({
    super.key,
    required this.booking,
    required this.isCancelling,
    required this.onCancel,
    required this.onBookAgain,
  });
  final BookingModel booking;
  final bool isCancelling;
  final Future<void> Function() onCancel;
  final Future<void> Function() onBookAgain;

  bool get _isPast {
    final now = DateTime.now();
    return booking.checkOut.isBefore(DateTime(now.year, now.month, now.day));
  }

  bool get _canCancel => !_isPast && booking.status == BookingStatus.confirmed;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      if (_canCancel) ...[
        CustomButton(
          buttonName: 'Cancel Booking',
          color: const Color(0xFFDC2626),
          onPressed: onCancel,
          enabled: !isCancelling,
        ),
        const SizedBox(height: 14),
      ],
      if (_isPast)
        CustomButton(
          buttonName: 'Book Again',
          color: AppColors.surfaceHighlight,
          onPressed: onBookAgain,
        ),
    ],
  );
}
