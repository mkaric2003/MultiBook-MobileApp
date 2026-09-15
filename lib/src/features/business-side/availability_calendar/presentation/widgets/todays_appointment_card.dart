import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodaysAppointmentCard extends StatelessWidget {
  const TodaysAppointmentCard({required this.appointment, super.key});

  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    final startsAt = appointment.date.add(
      Duration(minutes: appointment.startMinutes),
    );
    final endsAt = appointment.date.add(
      Duration(minutes: appointment.endMinutes),
    );
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: context.appPalette.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: .2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.person_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment.customerName,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 3),
                Text(
                  appointment.serviceNames.join(', '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: context.appPalette.muted),
                ),
              ],
            ),
          ),
          Text(
            '${DateFormat('h:mm a').format(startsAt)}–${DateFormat('h:mm a').format(endsAt)}',
            style: TextStyle(color: context.appPalette.muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
