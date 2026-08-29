import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/features/business-side/availability_calendar/presentation/widgets/customer_contact_row.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentCustomerSheet extends StatelessWidget {
  const AppointmentCustomerSheet({required this.appointment, super.key});

  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    final avatarUrl = appointment.customerAvatarUrl;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 14, 24, 26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 4,
                width: 42,
                decoration: BoxDecoration(
                  color: AppColors.muted,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              context.l10n.appointmentCustomer,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  radius: 31,
                  backgroundColor: AppColors.primary.withValues(alpha: .2),
                  backgroundImage: avatarUrl == null || avatarUrl.isEmpty
                      ? null
                      : NetworkImage(avatarUrl),
                  child: avatarUrl == null || avatarUrl.isEmpty
                      ? Text(
                          _initials(appointment.customerName),
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    appointment.customerName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            CustomerContactRow(
              icon: Icons.email_outlined,
              value: appointment.customerEmail,
            ),
            const SizedBox(height: 12),
            CustomerContactRow(
              icon: Icons.phone_outlined,
              value: appointment.customerPhone,
            ),
            const SizedBox(height: 24),
            CustomButton(
              buttonName: context.l10n.contactCustomer,
              leadingIcon: const Icon(Icons.email_outlined),
              enabled:
                  appointment.customerEmail.isNotEmpty ||
                  appointment.customerPhone.isNotEmpty,
              onPressed: _contactCustomer,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _contactCustomer() async {
    final email = appointment.customerEmail.trim();
    final phone = appointment.customerPhone.trim();
    final contactUri = email.isNotEmpty
        ? Uri(scheme: 'mailto', path: email)
        : Uri(scheme: 'tel', path: phone);
    await launchUrl(contactUri, mode: LaunchMode.externalApplication);
  }

  String _initials(String name) => name
      .split(' ')
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part[0].toUpperCase())
      .join();
}
