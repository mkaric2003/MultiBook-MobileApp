import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/form_field_label.dart';
import 'package:aquabook/src/global_widgets/custom_textfield.dart';
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
        const FormFieldLabel('First room type*'),
        const SizedBox(height: 10),
        CustomTextField(
          hintText: 'e.g. Deluxe room',
          controller: nameController,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                hintText: 'Max guests',
                controller: guestsController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomTextField(
                hintText: 'Size m²',
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
                hintText: 'Price per night',
                controller: priceController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomTextField(
                hintText: 'Rooms available',
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
