import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/stay_room_model.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/form_field_label.dart';
import 'package:multibook/src/global_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StayUnitEditor extends HookWidget {
  const StayUnitEditor({
    super.key,
    required this.room,
    required this.canRemove,
    required this.onChanged,
    required this.onRemove,
  });

  final StayRoomModel room;
  final bool canRemove;
  final ValueChanged<StayRoomModel> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(text: room.name);
    final guestsController = useTextEditingController(
      text: '${room.maxGuests}',
    );
    final sizeController = useTextEditingController(
      text: '${room.sizeSquareMeters}',
    );
    final priceController = useTextEditingController(
      text: (room.pricePerNight / 100).toStringAsFixed(2),
    );
    final quantityController = useTextEditingController(
      text: '${room.quantity}',
    );

    StayRoomModel value() => room.copyWith(
      name: nameController.text.trim(),
      maxGuests: int.tryParse(guestsController.text) ?? 0,
      sizeSquareMeters: int.tryParse(sizeController.text) ?? 0,
      pricePerNight:
          ((double.tryParse(priceController.text.replaceAll(',', '.')) ?? 0) *
                  100)
              .round(),
      quantity: int.tryParse(quantityController.text) ?? 0,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: context.appPalette.surfaceHighlight),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: FormFieldLabel(context.l10n.roomOrUnit)),
                if (canRemove)
                  IconButton(
                    onPressed: onRemove,
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.redAccent,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: context.l10n.unitNameExample,
              controller: nameController,
              onChanged: (_) => onChanged(value()),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: context.l10n.maxGuests,
                    controller: guestsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (_) => onChanged(value()),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    hintText: context.l10n.sizeSquareMeters,
                    controller: sizeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (_) => onChanged(value()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: context.l10n.pricePerNight,
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*([.,]\d{0,2})?$'),
                      ),
                    ],
                    onChanged: (_) => onChanged(value()),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    hintText: context.l10n.unitsAvailable,
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (_) => onChanged(value()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
