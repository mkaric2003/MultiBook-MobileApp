import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/service_weekday.dart';
import 'package:multibook/src/data/models/service_availability_slot_model.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/form_field_label.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/service_time_picker_button.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ServiceAvailabilitySlotsSection extends HookWidget {
  const ServiceAvailabilitySlotsSection({
    required this.slots,
    required this.onSlotAdded,
    required this.onSlotRemoved,
    super.key,
  });

  final List<ServiceAvailabilitySlotModel> slots;
  final ValueChanged<ServiceAvailabilitySlotModel> onSlotAdded;
  final ValueChanged<String> onSlotRemoved;

  @override
  Widget build(BuildContext context) {
    final weekday = useState(ServiceWeekday.monday);
    final startTime = useState(const TimeOfDay(hour: 9, minute: 0));
    final endTime = useState(const TimeOfDay(hour: 17, minute: 0));
    final isValid = _toMinutes(endTime.value) > _toMinutes(startTime.value);

    Future<void> selectTime(ValueNotifier<TimeOfDay> notifier) async {
      final selected = await showTimePicker(
        context: context,
        initialTime: notifier.value,
        builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              surface: AppColors.surface,
            ),
          ),
          child: child!,
        ),
      );
      if (selected != null) notifier.value = selected;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormFieldLabel(context.l10n.availabilityRequired),
        const SizedBox(height: 8),
        Text(
          context.l10n.recurringSlotsDescription,
          style: TextStyle(color: AppColors.muted, fontSize: 13),
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<ServiceWeekday>(
          initialValue: weekday.value,
          dropdownColor: AppColors.surface,
          style: const TextStyle(color: AppColors.white, fontSize: 16),
          decoration: InputDecoration(labelText: context.l10n.day),
          items: ServiceWeekday.values
              .map(
                (day) => DropdownMenuItem(value: day, child: Text(day.label)),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) weekday.value = value;
          },
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ServiceTimePickerButton(
                label: context.l10n.from,
                time: startTime.value,
                onTap: () => selectTime(startTime),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ServiceTimePickerButton(
                label: context.l10n.to,
                time: endTime.value,
                onTap: () => selectTime(endTime),
              ),
            ),
          ],
        ),
        if (!isValid) ...[
          const SizedBox(height: 8),
          Text(
            context.l10n.endTimeAfterStart,
            style: TextStyle(color: Colors.redAccent, fontSize: 13),
          ),
        ],
        const SizedBox(height: 12),
        CustomButton(
          buttonName: context.l10n.addAvailabilitySlot,
          color: AppColors.surface,
          textColor: AppColors.primary,
          borderColor: AppColors.primary,
          onPressed: !isValid
              ? null
              : () => onSlotAdded(
                  ServiceAvailabilitySlotModel(
                    id: 'slot-${DateTime.now().microsecondsSinceEpoch}',
                    weekday: weekday.value,
                    startMinutes: _toMinutes(startTime.value),
                    endMinutes: _toMinutes(endTime.value),
                  ),
                ),
          enabled: isValid,
        ),
        if (slots.isNotEmpty) ...[
          const SizedBox(height: 16),
          ...slots.map(
            (slot) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.surfaceHighlight),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.schedule, color: AppColors.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${slot.weekday.label}: ${_formatMinutes(slot.startMinutes)} – ${_formatMinutes(slot.endMinutes)}',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => onSlotRemoved(slot.id),
                      icon: const Icon(Icons.close, color: AppColors.muted),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  static int _toMinutes(TimeOfDay value) => (value.hour * 60) + value.minute;

  static String _formatMinutes(int minutes) {
    final hour = (minutes ~/ 60).toString().padLeft(2, '0');
    final minute = (minutes % 60).toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
