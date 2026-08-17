import 'package:flutter/material.dart';

class BookingConfirmationHeader extends StatelessWidget {
  const BookingConfirmationHeader({super.key});
  @override
  Widget build(BuildContext context) => const Column(
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
        style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 16),
      ),
    ],
  );
}
