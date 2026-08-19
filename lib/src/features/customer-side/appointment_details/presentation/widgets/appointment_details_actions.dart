import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsActions extends StatelessWidget {
  const AppointmentDetailsActions({
    required this.isCancelling,
    required this.onCancel,
    super.key,
  });

  final bool isCancelling;
  final Future<void> Function() onCancel;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      CustomButton(
        buttonName: 'Cancel appointment',
        color: Colors.redAccent,
        enabled: !isCancelling,
        onPressed: () => onCancel(),
      ),
      const SizedBox(height: 12),
      CustomButton(buttonName: 'Reschedule appointment', onPressed: () {}),
      const SizedBox(height: 12),
      CustomButton(
        buttonName: 'Message provider',
        color: AppColors.surfaceHighlight,
        onPressed: () {},
      ),
    ],
  );
}
