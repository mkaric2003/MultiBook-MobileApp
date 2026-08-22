import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/form_field_label.dart';
import 'package:aquabook/src/global_widgets/custom_textfield.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StayUnitForm extends StatelessWidget {
  const StayUnitForm({
    super.key,
    required this.nameController,
    required this.guestsController,
    required this.sizeController,
    required this.priceController,
    required this.quantityController,
  });

  final TextEditingController nameController;
  final TextEditingController guestsController;
  final TextEditingController sizeController;
  final TextEditingController priceController;
  final TextEditingController quantityController;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const FormFieldLabel('First unit type*'),
      const SizedBox(height: 10),
      CustomTextField(
        hintText: context.l10n.unitNameExample,
        controller: nameController,
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: CustomTextField(
              hintText: context.l10n.maxGuests,
              controller: guestsController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomTextField(
              hintText: context.l10n.sizeSquareMeters,
              controller: sizeController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: CustomTextField(
              hintText: context.l10n.pricePerNight,
              controller: priceController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomTextField(
              hintText: context.l10n.unitsAvailable,
              controller: quantityController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
        ],
      ),
    ],
  );
}
