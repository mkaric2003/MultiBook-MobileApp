import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsActions extends StatelessWidget {
  const AppointmentDetailsActions({
    required this.isCancelling,
    required this.canReschedule,
    required this.onCancel,
    required this.onReschedule,
    required this.onMessageProvider,
    super.key,
  });

  final bool isCancelling;
  final bool canReschedule;
  final Future<void> Function() onCancel;
  final Future<void> Function() onReschedule;
  final VoidCallback onMessageProvider;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      CustomButton(
        buttonName: context.l10n.cancelAppointment,
        color: Colors.redAccent,
        enabled: !isCancelling,
        onPressed: () => onCancel(),
      ),
      if (canReschedule) ...[
        const SizedBox(height: 12),
        CustomButton(
          buttonName: context.l10n.rescheduleAppointment,
          onPressed: () => onReschedule(),
        ),
      ],
      const SizedBox(height: 12),
      CustomButton(
        buttonName: context.l10n.messageProvider,
        color: AppColors.surfaceHighlight,
        onPressed: onMessageProvider,
      ),
    ],
  );
}
