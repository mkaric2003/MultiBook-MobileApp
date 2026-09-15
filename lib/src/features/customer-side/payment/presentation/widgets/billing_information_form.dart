import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/global_widgets/custom_textfield.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class BillingInformationForm extends StatelessWidget {
  const BillingInformationForm({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.showAddress = true,
  });
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController address;
  final bool showAddress;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: context.appPalette.surface,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.fullName),
        const SizedBox(height: 8),
        CustomTextField(hintText: context.l10n.enterFullName, controller: name),
        const SizedBox(height: 18),
        Text(context.l10n.email),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: context.l10n.emailExample,
          controller: email,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 18),
        Text(context.l10n.phoneNumber),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: context.l10n.phoneNumberExample,
          controller: phone,
          keyboardType: TextInputType.phone,
        ),
        if (showAddress) ...[
          const SizedBox(height: 18),
          Text(context.l10n.billingAddress),
          const SizedBox(height: 8),
          CustomTextField(
            hintText: context.l10n.enterBillingAddress,
            controller: address,
            maxLines: 3,
          ),
        ],
      ],
    ),
  );
}
