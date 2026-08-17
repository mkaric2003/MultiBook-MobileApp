import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/booking_status.dart';
import 'package:aquabook/src/features/business-side/availability_calendar/domain/models/availability_day_summary.dart';
import 'package:flutter/material.dart';

class AvailabilityCalendarDay extends StatelessWidget {
  const AvailabilityCalendarDay({
    super.key,
    required this.date,
    required this.isSelected,
    required this.summary,
    required this.onTap,
  });

  final DateTime date;
  final bool isSelected;
  final AvailabilityDaySummary? summary;
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
          if (summary != null)
            summary!.totalRooms > 1
                ? Text(
                    '${summary!.bookedRooms}/${summary!.totalRooms}',
                    style: TextStyle(
                      color: _occupancyColor(summary!),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: summary!.statuses
                        .take(3)
                        .map(
                          (status) => Container(
                            height: 5,
                            width: 5,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: BoxDecoration(
                              color: _statusColor(status),
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                        .toList(),
                  )
          else
            const SizedBox(height: 6),
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

  Color _occupancyColor(AvailabilityDaySummary summary) {
    if (summary.bookedRooms >= summary.totalRooms) {
      return const Color(0xFFFF4B4B);
    }
    if (summary.bookedRooms / summary.totalRooms >= .7) {
      return const Color(0xFFF59E0B);
    }
    return const Color(0xFF22C55E);
  }
}
