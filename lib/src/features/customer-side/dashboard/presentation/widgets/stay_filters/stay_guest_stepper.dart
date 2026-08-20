import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/stay_filters/guest_stepper_circle_button.dart';
import 'package:flutter/material.dart';

class StayGuestStepper extends StatelessWidget {
  const StayGuestStepper({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.minimum,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final int value;
  final int minimum;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(subtitle, style: const TextStyle(color: AppColors.muted)),
            ],
          ),
        ),
        GuestStepperCircleButton(
          icon: Icons.remove,
          enabled: value > minimum,
          onTap: () => onChanged(value - 1),
        ),
        SizedBox(
          width: 52,
          child: Text(
            '$value',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        GuestStepperCircleButton(
          icon: Icons.add,
          enabled: true,
          onTap: () => onChanged(value + 1),
        ),
      ],
    );
  }
}
