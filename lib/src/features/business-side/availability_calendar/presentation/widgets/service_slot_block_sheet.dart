import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ServiceSlotBlockSheet extends StatelessWidget {
  const ServiceSlotBlockSheet({
    required this.timeLabel,
    required this.isBlocked,
    required this.onPressed,
    super.key,
  });

  final String timeLabel;
  final bool isBlocked;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) => SafeArea(
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
            isBlocked ? 'Unblock time slot' : 'Block time slot',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Text(
            isBlocked
                ? '$timeLabel is manually blocked and cannot be booked.'
                : 'Prevent customers from booking $timeLabel.',
            style: const TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 24),
          CustomButton(
            buttonName: isBlocked
                ? context.l10n.unblockSlot
                : context.l10n.blockSlot,
            color: isBlocked ? AppColors.surfaceHighlight : AppColors.primary,
            onPressed: () => _submit(context),
          ),
        ],
      ),
    ),
  );

  Future<void> _submit(BuildContext context) async {
    try {
      await onPressed();
      if (!context.mounted) return;
      Navigator.of(context).pop();
      toastification.show(
        context: context,
        alignment: Alignment.bottomCenter,
        autoCloseDuration: const Duration(seconds: 3),
        type: ToastificationType.success,
        title: Text(isBlocked ? 'Slot unblocked.' : 'Slot blocked.'),
      );
    } catch (_) {
      if (!context.mounted) return;
      toastification.show(
        context: context,
        alignment: Alignment.bottomCenter,
        autoCloseDuration: const Duration(seconds: 3),
        type: ToastificationType.error,
        title: Text(
          isBlocked
              ? 'We could not unblock this slot.'
              : 'We could not block this slot.',
        ),
      );
    }
  }
}
