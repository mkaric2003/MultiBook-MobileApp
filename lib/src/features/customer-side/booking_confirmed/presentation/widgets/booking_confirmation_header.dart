import 'package:flutter/material.dart';
import 'package:multibook/src/core/theme/app_colors.dart';

class BookingConfirmationHeader extends StatelessWidget {
  const BookingConfirmationHeader({super.key});
  @override
  Widget build(BuildContext context) => Column(
    children: [
      CircleAvatar(
        radius: 49,
        backgroundColor: Color(0xFF10B981),
        child: Icon(Icons.check, color: Colors.white, size: 52),
      ),
      SizedBox(height: 24),
      Text(
        'Booking Confirmed!',
        style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800),
      ),
      SizedBox(height: 9),
      Text(
        'Your reservation has been successfully\nprocessed',
        textAlign: TextAlign.center,
        style: TextStyle(color: context.appPalette.muted, fontSize: 16),
      ),
    ],
  );
}
