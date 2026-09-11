import 'package:multibook/app.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/features/business-side/bookings/presentation/widgets/client_appointment_status_label.dart';
import 'package:multibook/src/features/business-side/bookings/presentation/widgets/appointment_info_row.dart';
import 'package:multibook/src/features/shared/chat/domain/models/chat_conversation_arguments.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class ManageAppointmentSheet extends StatelessWidget {
  const ManageAppointmentSheet({
    required this.appointment,
    required this.onDecline,
    required this.onComplete,
    required this.onNoShow,
    required this.onReschedule,
    super.key,
  });

  final AppointmentModel appointment;
  final Future<bool> Function(AppointmentModel appointment) onDecline;
  final Future<bool> Function(AppointmentModel appointment) onComplete;
  final Future<bool> Function(AppointmentModel appointment) onNoShow;
  final Future<void> Function() onReschedule;

  @override
  Widget build(BuildContext context) {
    final start = DateTime(
      appointment.date.year,
      appointment.date.month,
      appointment.date.day,
    ).add(Duration(minutes: appointment.startMinutes));
    final end = start.add(
      Duration(minutes: appointment.endMinutes - appointment.startMinutes),
    );
    final canManage = appointment.status == 'confirmed';
    final hasEnded = DateTime.now().isAfter(end);
    final canComplete = canManage && hasEnded;
    final canMarkNoShow =
        hasEnded &&
        (appointment.status == 'confirmed' ||
            appointment.status == 'completed') &&
        (appointment.paymentMethod.trim().toLowerCase() == 'cash' ||
            appointment.paymentStatus.name == 'pending');

    return Container(
      decoration: BoxDecoration(
        color: context.appPalette.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Manage Appointment',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, size: 20),
                    style: IconButton.styleFrom(
                      backgroundColor: context.appPalette.surfaceHighlight,
                    ),
                  ),
                ],
              ),
              Divider(height: 28, color: context.appPalette.surfaceHighlight),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.appPalette.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 23,
                          child: Icon(
                            Icons.person,
                            color: context.appPalette.muted,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appointment.customerName,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 5),
                              ClientAppointmentStatusLabel(
                                status: appointment.status,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    AppointmentInfoRow(
                      icon: Icons.content_cut,
                      title: appointment.serviceNames.join(', '),
                      subtitle: appointment.providerName,
                    ),
                    const SizedBox(height: 16),
                    AppointmentInfoRow(
                      icon: Icons.calendar_month,
                      title: DateFormat('MMM d, y').format(start),
                      subtitle:
                          '${DateFormat('h:mm a').format(start)} – ${DateFormat('h:mm a').format(end)}',
                    ),
                    const SizedBox(height: 16),
                    AppointmentInfoRow(
                      icon: Icons.attach_money,
                      title: context.l10n.formatCurrency(appointment.total),
                      subtitle: appointment.paymentMethod,
                    ),
                    const SizedBox(height: 16),
                    AppointmentInfoRow(
                      icon: Icons.receipt_long_outlined,
                      title: appointment.confirmationCode,
                      subtitle: 'Confirmation code',
                    ),
                  ],
                ),
              ),
              if (canManage) ...[
                const SizedBox(height: 20),
                if (canComplete) ...[
                  CustomButton(
                    buttonName: context.l10n.markAsCompleted,
                    height: 48,
                    fontSize: 16,
                    onPressed: () async {
                      final didComplete = await onComplete(appointment);
                      if (didComplete && context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                ],
                CustomButton(
                  buttonName: context.l10n.declineAppointment,
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  height: 48,
                  fontSize: 16,
                  onPressed: () async {
                    final didDecline = await onDecline(appointment);
                    if (didDecline && context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
                const SizedBox(height: 10),
                CustomButton(
                  buttonName: context.l10n.rescheduleBooking,
                  height: 48,
                  fontSize: 16,
                  onPressed: onReschedule,
                ),
              ],
              if (canMarkNoShow) ...[
                const SizedBox(height: 10),
                CustomButton(
                  buttonName: context.l10n.markAsNoShow,
                  color: Colors.transparent,
                  textColor: Colors.redAccent,
                  borderColor: Colors.redAccent,
                  height: 48,
                  fontSize: 16,
                  onPressed: () async {
                    final didMarkNoShow = await onNoShow(appointment);
                    if (didMarkNoShow && context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 1),
                      child: Icon(
                        Icons.info_outline,
                        size: 15,
                        color: context.appPalette.muted,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        context.l10n.noShowEarningsHint,
                        style: TextStyle(
                          color: context.appPalette.muted,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 10),
              CustomButton(
                buttonName: context.l10n.contactCustomer,
                color: context.appPalette.surfaceHighlight,
                height: 48,
                fontSize: 16,
                leadingIcon: const Icon(Icons.chat_bubble_outline),
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push(
                    AppRoutes.CHAT_CONVERSATION,
                    extra: ChatConversationArguments(
                      businessId: appointment.businessId,
                      businessOwnerId: appointment.businessOwnerId,
                      businessName: appointment.businessName,
                      businessImageUrl: appointment.businessImageUrl,
                      customerId: appointment.customerId,
                      customerName: appointment.customerName,
                      customerImageUrl: appointment.customerAvatarUrl,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
