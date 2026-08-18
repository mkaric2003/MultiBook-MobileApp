import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/service_offering_model.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/form_field_label.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:aquabook/src/global_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ServiceOfferingsSection extends HookWidget {
  const ServiceOfferingsSection({
    required this.offerings,
    required this.onOfferingAdded,
    required this.onOfferingRemoved,
    super.key,
  });

  final List<ServiceOfferingModel> offerings;
  final ValueChanged<ServiceOfferingModel> onOfferingAdded;
  final ValueChanged<String> onOfferingRemoved;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final durationController = useTextEditingController();
    final priceController = useTextEditingController();
    final descriptionController = useTextEditingController();
    useListenable(nameController);
    useListenable(durationController);
    useListenable(priceController);

    final canAdd =
        nameController.text.trim().isNotEmpty &&
        (int.tryParse(durationController.text) ?? 0) > 0 &&
        (int.tryParse(priceController.text) ?? 0) >= 0;

    void addOffering() {
      if (!canAdd) return;
      onOfferingAdded(
        ServiceOfferingModel(
          id: 'service-${DateTime.now().microsecondsSinceEpoch}',
          name: nameController.text.trim(),
          durationMinutes: int.parse(durationController.text),
          price: int.parse(priceController.text),
          description: descriptionController.text.trim().isEmpty
              ? null
              : descriptionController.text.trim(),
        ),
      );
      nameController.clear();
      durationController.clear();
      priceController.clear();
      descriptionController.clear();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormFieldLabel('Services offered*'),
        const SizedBox(height: 8),
        const Text(
          'Add every service your customers can book.',
          style: TextStyle(color: AppColors.muted, fontSize: 13),
        ),
        const SizedBox(height: 14),
        const FormFieldLabel('Service type*'),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: 'e.g. Haircut, teeth whitening, electrical inspection',
          controller: nameController,
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormFieldLabel('Duration (min)*'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: '60',
                    controller: durationController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormFieldLabel('Price*'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: '50',
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const FormFieldLabel('Description (optional)'),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: 'Briefly describe this service',
          controller: descriptionController,
          maxLines: 2,
        ),
        const SizedBox(height: 12),
        CustomButton(
          buttonName: 'Add service',
          color: AppColors.surface,
          textColor: AppColors.primary,
          borderColor: AppColors.primary,
          onPressed: canAdd ? addOffering : null,
          enabled: canAdd,
        ),
        if (offerings.isNotEmpty) ...[
          const SizedBox(height: 16),
          ...offerings.indexed.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.surfaceHighlight),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.event_available, color: AppColors.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.$2.name,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${entry.$2.durationMinutes} min · \$${entry.$2.price}',
                            style: const TextStyle(
                              color: AppColors.muted,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => onOfferingRemoved(entry.$2.id),
                      icon: const Icon(Icons.close, color: AppColors.muted),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
