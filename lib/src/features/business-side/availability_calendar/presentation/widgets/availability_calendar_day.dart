import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/booking_status.dart';
import 'package:flutter/material.dart';

class AvailabilityCalendarDay extends StatelessWidget {
  const AvailabilityCalendarDay({
    super.key,
    required this.date,
    required this.isSelected,
    required this.status,
    required this.onTap,
  });

  final DateTime date;
  final bool isSelected;
  final BookingStatus? status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    borderRadius: BorderRadius.circular(10),
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${date.day}',
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 3),
          SizedBox(
            height: 6,
            child: status == null
                ? null
                : Container(
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                      color: _statusColor(status!),
                      shape: BoxShape.circle,
                    ),
                  ),
          ),
        ],
      ),
    ),
  );

  Color _statusColor(BookingStatus status) => switch (status) {
    BookingStatus.confirmed => const Color(0xFF22C55E),
    BookingStatus.declined => const Color(0xFFF59E0B),
    BookingStatus.cancelled => const Color(0xFFFF4B4B),
    BookingStatus.completed => const Color(0xFF8B5CF6),
  };
}
