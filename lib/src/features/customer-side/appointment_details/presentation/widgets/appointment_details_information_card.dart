import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/customer-side/appointment_details/domain/models/appointment_details_arguments.dart';
import 'package:multibook/src/features/customer-side/appointment_details/presentation/widgets/appointment_details_row.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentDetailsInformationCard extends StatelessWidget {
  const AppointmentDetailsInformationCard({required this.arguments, super.key});

  final AppointmentDetailsArguments arguments;

  @override
  Widget build(BuildContext context) {
    final appointment = arguments.appointment;
    final start = DateTime(
      2000,
      1,
      1,
    ).add(Duration(minutes: appointment.startMinutes));
    final end = DateTime(
      2000,
      1,
      1,
    ).add(Duration(minutes: appointment.endMinutes));
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.appPalette.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appPalette.surfaceHighlight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.appointmentInformation,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 20),
          AppointmentDetailsRow(
            label: context.l10n.service,
            value: appointment.serviceNames.join(', '),
          ),
          const SizedBox(height: 14),
          AppointmentDetailsRow(
            label: context.l10n.provider,
            value: appointment.providerName,
          ),
          const SizedBox(height: 14),
          AppointmentDetailsRow(
            label: context.l10n.dateAndTime,
            value:
                '${DateFormat('MMM d, y').format(appointment.date)}\n${DateFormat('h:mm a').format(start)} - ${DateFormat('h:mm a').format(end)}',
          ),
          const SizedBox(height: 14),
          AppointmentDetailsRow(
            label: context.l10n.status,
            value:
                '${appointment.status[0].toUpperCase()}${appointment.status.substring(1)}',
            valueColor: appointment.status == 'confirmed'
                ? AppColors.success
                : context.appPalette.muted,
          ),
          const SizedBox(height: 14),
          AppointmentDetailsRow(
            label: context.l10n.reference,
            value: appointment.confirmationCode,
          ),
        ],
      ),
    );
  }
}
