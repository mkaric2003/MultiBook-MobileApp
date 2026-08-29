import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentTimeGrid extends StatelessWidget {
  const AppointmentTimeGrid({
    required this.times,
    required this.bookableStartTimes,
    required this.selectedTime,
    required this.selectedDurationMinutes,
    required this.onTimeSelected,
    super.key,
  });

  final List<int> times;
  final Set<int> bookableStartTimes;
  final int? selectedTime;
  final int selectedDurationMinutes;
  final ValueChanged<int> onTimeSelected;

  @override
  Widget build(BuildContext context) {
    if (times.isEmpty) {
      return Text(
        context.l10n.noAppointmentSlotsAvailable,
        style: const TextStyle(color: AppColors.muted),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: times.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        mainAxisExtent: 48,
      ),
      itemBuilder: (context, index) {
        final time = times[index];
        final isSelected =
            selectedTime != null &&
            time >= selectedTime! &&
            time < selectedTime! + selectedDurationMinutes;
        final isBookableStart = bookableStartTimes.contains(time);
        return InkWell(
          onTap: isBookableStart ? () => onTimeSelected(time) : null,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary
                  : isBookableStart
                  ? AppColors.surface
                  : AppColors.surfaceHighlight,
              border: Border.all(color: AppColors.surfaceHighlight),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _formatTime(time),
              style: TextStyle(
                color: isBookableStart || isSelected
                    ? Colors.white
                    : AppColors.muted,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      },
    );
  }

  static String _formatTime(int minutes) {
    return DateFormat(
      'h:mm a',
    ).format(DateTime(2000, 1, 1).add(Duration(minutes: minutes)));
  }
}
