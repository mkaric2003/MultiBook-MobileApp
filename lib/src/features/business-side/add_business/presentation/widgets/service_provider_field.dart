import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/form_field_label.dart';
import 'package:aquabook/src/global_widgets/custom_textfield.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ServiceProviderField extends StatelessWidget {
  const ServiceProviderField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      FormFieldLabel(context.l10n.serviceProviderRequired),
      const SizedBox(height: 10),
      CustomTextField(
        controller: controller,
        hintText: context.l10n.providerNameHint,
      ),
    ],
  );
}
