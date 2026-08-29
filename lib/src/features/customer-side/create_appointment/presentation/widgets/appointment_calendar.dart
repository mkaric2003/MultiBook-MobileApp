import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/create_appointment/presentation/widgets/appointment_calendar_weekday_label.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentCalendar extends StatelessWidget {
  const AppointmentCalendar({
    required this.visibleMonth,
    required this.selectedDate,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.onDateSelected,
    super.key,
  });

  final DateTime visibleMonth;
  final DateTime selectedDate;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(visibleMonth.year, visibleMonth.month);
    final numberOfDays = DateUtils.getDaysInMonth(
      visibleMonth.year,
      visibleMonth.month,
    );
    final leadingDays = firstDay.weekday - 1;
    final cells = leadingDays + numberOfDays;
    final rows = (cells / 7).ceil();
    final today = DateUtils.dateOnly(DateTime.now());

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onPreviousMonth,
                icon: const Icon(Icons.chevron_left, color: AppColors.muted),
              ),
              Expanded(
                child: Text(
                  DateFormat('MMMM yyyy').format(visibleMonth),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                onPressed: onNextMonth,
                icon: const Icon(Icons.chevron_right, color: AppColors.muted),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              AppointmentCalendarWeekdayLabel('M'),
              AppointmentCalendarWeekdayLabel('T'),
              AppointmentCalendarWeekdayLabel('W'),
              AppointmentCalendarWeekdayLabel('T'),
              AppointmentCalendarWeekdayLabel('F'),
              AppointmentCalendarWeekdayLabel('S'),
              AppointmentCalendarWeekdayLabel('S'),
            ],
          ),
          const SizedBox(height: 8),
          ...List.generate(rows, (rowIndex) {
            return Row(
              children: List.generate(7, (weekdayIndex) {
                final day = (rowIndex * 7) + weekdayIndex - leadingDays + 1;
                if (day < 1 || day > numberOfDays) {
                  return const Expanded(child: SizedBox(height: 42));
                }
                final date = DateTime(
                  visibleMonth.year,
                  visibleMonth.month,
                  day,
                );
                final isSelected = DateUtils.isSameDay(date, selectedDate);
                final isPast = date.isBefore(today);
                return Expanded(
                  child: InkWell(
                    onTap: isPast ? null : () => onDateSelected(date),
                    borderRadius: BorderRadius.circular(9),
                    child: Container(
                      height: 42,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        '$day',
                        style: TextStyle(
                          color: isPast
                              ? AppColors.muted.withValues(alpha: 0.45)
                              : Colors.white,
                          fontWeight: isSelected
                              ? FontWeight.w800
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ],
      ),
    );
  }
}
