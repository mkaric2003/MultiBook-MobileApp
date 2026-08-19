import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/appointment_model.dart';
import 'package:aquabook/src/features/business-side/bookings/presentation/widgets/client_appointment_status_label.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClientAppointmentCard extends StatelessWidget {
  const ClientAppointmentCard({
    required this.appointment,
    required this.onManage,
    super.key,
  });

  final AppointmentModel appointment;
  final VoidCallback onManage;

  @override
  Widget build(BuildContext context) {
    final start = DateTime(
      appointment.date.year,
      appointment.date.month,
      appointment.date.day,
    ).add(Duration(minutes: appointment.startMinutes));
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF172554),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                child: Icon(Icons.person, color: AppColors.muted),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.customerName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      appointment.serviceNames.join(', '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ClientAppointmentStatusLabel(status: appointment.status),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.person_outline, color: AppColors.primary),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  appointment.providerName,
                  style: const TextStyle(color: AppColors.muted, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              const Icon(Icons.watch_later_rounded, color: AppColors.primary),
              const SizedBox(width: 7),
              Text(
                '${DateFormat('MMM d, y').format(start)} · ${DateFormat('h:mm a').format(start)}',
                style: const TextStyle(color: AppColors.muted, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 14),
          CustomButton(
            buttonName: 'Manage',
            height: 44,
            fontSize: 15,
            onPressed: onManage,
          ),
        ],
      ),
    );
  }
}
