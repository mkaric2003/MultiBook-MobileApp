import 'package:multibook/src/features/business-side/add_business/presentation/widgets/form_field_label.dart';
import 'package:multibook/src/global_widgets/custom_textfield.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HotelRoomForm extends StatelessWidget {
  const HotelRoomForm({
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormFieldLabel(context.l10n.firstRoomTypeRequired),
        const SizedBox(height: 10),
        CustomTextField(
          hintText: context.l10n.roomNameExample,
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
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d*([.,]\d{0,2})?$'),
                  ),
                ],
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
                hintText: context.l10n.roomsAvailable,
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
}
