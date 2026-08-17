import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingCalendar extends StatelessWidget {
  const BookingCalendar({
    super.key,
    required this.checkIn,
    required this.checkOut,
    required this.visibleMonth,
    required this.unavailableDates,
    required this.isLoadingAvailability,
    required this.onDateSelected,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  final DateTime checkIn;
  final DateTime checkOut;
  final DateTime visibleMonth;
  final Set<DateTime> unavailableDates;
  final bool isLoadingAvailability;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(visibleMonth.year, visibleMonth.month, 1);
    final dayOffset = firstDay.weekday - 1;
    final daysInMonth = DateTime(
      visibleMonth.year,
      visibleMonth.month + 1,
      0,
    ).day;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 17,
                backgroundColor: AppColors.surfaceHighlight,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: onPreviousMonth,
                  icon: const Icon(Icons.chevron_left, size: 21),
                ),
              ),
              Expanded(
                child: Text(
                  DateFormat('MMMM yyyy').format(visibleMonth),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              CircleAvatar(
                radius: 17,
                backgroundColor: AppColors.surfaceHighlight,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: onNextMonth,
                  icon: const Icon(Icons.chevron_right, size: 21),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final day in ['M', 'T', 'W', 'T', 'F', 'S', 'S'])
                Text(
                  day,
                  style: TextStyle(color: AppColors.muted, fontSize: 12),
                ),
            ],
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dayOffset + daysInMonth,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              if (index < dayOffset) return const SizedBox.shrink();
              final date = DateTime(
                visibleMonth.year,
                visibleMonth.month,
                index - dayOffset + 1,
              );
              final selected =
                  _sameDay(date, checkIn) || _sameDay(date, checkOut);
              final between = date.isAfter(checkIn) && date.isBefore(checkOut);
              final unavailable = _isUnavailable(date);
              return InkWell(
                borderRadius: BorderRadius.circular(9),
                onTap: unavailable || isLoadingAvailability
                    ? null
                    : () => onDateSelected(date),
                child: Opacity(
                  opacity: unavailable ? .32 : 1,
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary
                          : between
                          ? AppColors.primary.withValues(alpha: .25)
                          : unavailable
                          ? AppColors.surfaceHighlight
                          : null,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Text(
                      '${date.day}',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  bool _sameDay(DateTime first, DateTime second) =>
      first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;

  bool _isUnavailable(DateTime date) =>
      unavailableDates.any((item) => _sameDay(item, date));
}
