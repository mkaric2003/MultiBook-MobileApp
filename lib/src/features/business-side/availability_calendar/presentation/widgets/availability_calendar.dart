import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/booking_status.dart';
import 'package:aquabook/src/features/business-side/availability_calendar/presentation/widgets/availability_calendar_day.dart';
import 'package:aquabook/src/features/business-side/availability_calendar/presentation/widgets/availability_calendar_weekday_label.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AvailabilityCalendar extends StatelessWidget {
  const AvailabilityCalendar({
    super.key,
    required this.visibleDate,
    required this.isMonthly,
    required this.selectedDate,
    required this.statuses,
    required this.onPrevious,
    required this.onNext,
    required this.onDateSelected,
  });

  final DateTime visibleDate;
  final bool isMonthly;
  final DateTime selectedDate;
  final Map<DateTime, BookingStatus> statuses;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    final dates = isMonthly ? _monthDates() : _weekDates();
    final weekStart = visibleDate.subtract(
      Duration(days: visibleDate.weekday - 1),
    );
    final title = isMonthly
        ? DateFormat('MMMM yyyy').format(visibleDate)
        : '${DateFormat('MMM d').format(weekStart)} – ${DateFormat('MMM d, y').format(weekStart.add(const Duration(days: 6)))}';

    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: onPrevious,
              icon: const Icon(Icons.chevron_left, color: AppColors.muted),
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            IconButton(
              onPressed: onNext,
              icon: const Icon(Icons.chevron_right, color: AppColors.muted),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              const Row(
                children: [
                  AvailabilityCalendarWeekdayLabel('M'),
                  AvailabilityCalendarWeekdayLabel('T'),
                  AvailabilityCalendarWeekdayLabel('W'),
                  AvailabilityCalendarWeekdayLabel('T'),
                  AvailabilityCalendarWeekdayLabel('F'),
                  AvailabilityCalendarWeekdayLabel('S'),
                  AvailabilityCalendarWeekdayLabel('S'),
                ],
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dates.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final date = dates[index];
                  if (date == null) return const SizedBox.shrink();
                  final status = _statusForDate(date);
                  return AvailabilityCalendarDay(
                    date: date,
                    isSelected: _sameDay(date, selectedDate),
                    status: status,
                    onTap: () => onDateSelected(date),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<DateTime?> _monthDates() {
    final firstDay = DateTime(visibleDate.year, visibleDate.month, 1);
    final offset = firstDay.weekday - 1;
    final dayCount = DateTime(visibleDate.year, visibleDate.month + 1, 0).day;
    return [
      for (var index = 0; index < offset + dayCount; index++)
        index < offset
            ? null
            : DateTime(visibleDate.year, visibleDate.month, index - offset + 1),
    ];
  }

  List<DateTime?> _weekDates() {
    final monday = visibleDate.subtract(
      Duration(days: visibleDate.weekday - 1),
    );
    return List.generate(7, (index) => monday.add(Duration(days: index)));
  }

  BookingStatus? _statusForDate(DateTime date) {
    for (final entry in statuses.entries) {
      if (_sameDay(entry.key, date)) return entry.value;
    }
    return null;
  }

  bool _sameDay(DateTime first, DateTime second) =>
      first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}
