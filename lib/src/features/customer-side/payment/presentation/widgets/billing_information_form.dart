import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/global_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class BillingInformationForm extends StatelessWidget {
  const BillingInformationForm({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController address;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Full Name'),
        const SizedBox(height: 8),
        CustomTextField(hintText: 'Enter your full name', controller: name),
        const SizedBox(height: 18),
        const Text('Email'),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: 'your.email@example.com',
          controller: email,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 18),
        const Text('Phone Number'),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: '+1 (555) 123-4567',
          controller: phone,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 18),
        const Text('Billing Address'),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: 'Enter your billing address',
          controller: address,
          maxLines: 3,
        ),
      ],
    ),
  );
}
