import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/app.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/features/customer-side/bookings/presentation/widgets/customer_appointment_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CustomerAppointmentCard extends StatelessWidget {
  const CustomerAppointmentCard({
    required this.appointment,
    required this.onUpdated,
    super.key,
  });

  final AppointmentModel appointment;
  final ValueChanged<AppointmentModel> onUpdated;

  @override
  Widget build(BuildContext context) {
    final start = DateTime(
      2000,
      1,
      1,
    ).add(Duration(minutes: appointment.startMinutes));
    final duration = appointment.endMinutes - appointment.startMinutes;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.appPalette.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  appointment.businessImageUrl,
                  width: 74,
                  height: 74,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => SizedBox(
                    width: 74,
                    height: 74,
                    child: ColoredBox(
                      color: context.appPalette.surfaceHighlight,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.businessName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${appointment.serviceNames.join(', ')} – ${context.l10n.serviceDuration(duration)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: context.appPalette.muted,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      appointment.providerName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: context.appPalette.muted,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${DateFormat('MMM d').format(appointment.date)}, ${DateFormat('h:mm a').format(start)}',
                      style: TextStyle(
                        color: context.appPalette.muted,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CustomerAppointmentStatusPill(status: appointment.status),
              const Spacer(),
              InkWell(
                onTap: () async {
                  final updated = await context.push<AppointmentModel>(
                    AppRoutes.APPOINTMENT_DETAILS,
                    extra: appointment,
                  );
                  if (updated != null) onUpdated(updated);
                },
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    context.l10n.viewDetails,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
