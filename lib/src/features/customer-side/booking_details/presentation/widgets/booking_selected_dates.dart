import 'package:aquabook/src/features/customer-side/booking_details/presentation/widgets/booking_date_value.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingSelectedDates extends StatelessWidget {
  const BookingSelectedDates({
    super.key,
    required this.checkIn,
    required this.checkOut,
  });
  final DateTime checkIn;
  final DateTime checkOut;
  @override
  Widget build(BuildContext context) {
    final format = DateFormat('MMM d');
    return Row(
      children: [
        Expanded(
          child: BookingDateValue(
            label: context.l10n.checkIn,
            value: format.format(checkIn),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: BookingDateValue(
            label: context.l10n.checkOut,
            value: format.format(checkOut),
          ),
        ),
      ],
    );
  }
}
