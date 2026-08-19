import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/service_weekday.dart';
import 'package:aquabook/src/data/models/appointment_model.dart';
import 'package:aquabook/src/data/models/service_availability_block_model.dart';
import 'package:aquabook/src/data/models/service_provider_model.dart';
import 'package:aquabook/src/features/business-side/availability_calendar/presentation/widgets/appointment_customer_sheet.dart';
import 'package:aquabook/src/features/business-side/availability_calendar/presentation/widgets/service_slot_block_sheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServiceDaySlots extends StatelessWidget {
  const ServiceDaySlots({
    required this.provider,
    required this.date,
    required this.appointments,
    required this.blocks,
    required this.onBlockSlot,
    required this.onUnblockSlot,
    super.key,
  });

  final ServiceProviderModel provider;
  final DateTime date;
  final List<AppointmentModel> appointments;
  final List<ServiceAvailabilityBlockModel> blocks;
  final Future<void> Function(int startMinutes) onBlockSlot;
  final Future<void> Function(ServiceAvailabilityBlockModel block)
  onUnblockSlot;

  @override
  Widget build(BuildContext context) {
    final slots = _slotsForDate();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Slots for ${DateFormat('EEEE, MMM d').format(date)}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        const Text(
          'Purple slots are booked or blocked. Dark slots are available.',
          style: TextStyle(color: AppColors.muted, fontSize: 14),
        ),
        const SizedBox(height: 16),
        if (slots.isEmpty)
          const Text(
            'This provider has no working hours on the selected day.',
            style: TextStyle(color: AppColors.muted),
          )
        else
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: slots.map((slot) {
              final appointment = _appointmentForSlot(slot);
              final block = _blockForSlot(slot);
              final isBooked = appointment != null || block != null;
              return InkWell(
                onTap: () => _onSlotTap(
                  context: context,
                  slot: slot,
                  appointment: appointment,
                  block: block,
                ),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 102,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isBooked
                        ? AppColors.primary.withValues(alpha: .28)
                        : AppColors.surface,
                    border: Border.all(
                      color: isBooked
                          ? AppColors.primary
                          : AppColors.surfaceHighlight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _formatTime(slot),
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        appointment != null
                            ? 'Booked'
                            : block != null
                            ? 'Blocked'
                            : 'Available',
                        style: TextStyle(
                          color: isBooked ? AppColors.primary : AppColors.muted,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  List<int> _slotsForDate() {
    final weekday = ServiceWeekday.values[date.weekday - 1];
    final times = <int>{};
    for (final availability in provider.availabilitySlots.where(
      (slot) => slot.weekday == weekday,
    )) {
      for (
        var time = availability.startMinutes;
        time < availability.endMinutes;
        time += 30
      ) {
        times.add(time);
      }
    }
    return times.toList()..sort();
  }

  AppointmentModel? _appointmentForSlot(int time) => appointments
      .where(
        (appointment) =>
            appointment.status != 'cancelled' &&
            appointment.status != 'declined' &&
            time >= appointment.startMinutes &&
            time < appointment.endMinutes,
      )
      .firstOrNull;

  ServiceAvailabilityBlockModel? _blockForSlot(int time) =>
      blocks.where((block) => block.startMinutes == time).firstOrNull;

  void _onSlotTap({
    required BuildContext context,
    required int slot,
    required AppointmentModel? appointment,
    required ServiceAvailabilityBlockModel? block,
  }) {
    if (appointment != null) {
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColors.background,
        showDragHandle: false,
        builder: (_) => AppointmentCustomerSheet(appointment: appointment),
      );
      return;
    }
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.background,
      showDragHandle: false,
      builder: (_) => ServiceSlotBlockSheet(
        timeLabel: _formatTime(slot),
        isBlocked: block != null,
        onPressed: block == null
            ? () => onBlockSlot(slot)
            : () => onUnblockSlot(block),
      ),
    );
  }

  String _formatTime(int minutes) {
    final time = DateTime(2020).add(Duration(minutes: minutes));
    return DateFormat('h:mm a').format(time);
  }
}
