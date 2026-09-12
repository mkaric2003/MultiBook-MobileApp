import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/service_availability_slot_model.dart';
import 'package:multibook/src/data/models/service_provider_model.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/form_field_label.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/service_provider_availability_card.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:multibook/src/global_widgets/custom_textfield.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ServiceProvidersSection extends HookWidget {
  const ServiceProvidersSection({
    required this.providers,
    required this.onProviderAdded,
    required this.onProviderRemoved,
    required this.onSlotAdded,
    required this.onSlotRemoved,
    super.key,
  });

  final List<ServiceProviderModel> providers;
  final ValueChanged<ServiceProviderModel> onProviderAdded;
  final ValueChanged<String> onProviderRemoved;
  final void Function(String providerId, ServiceAvailabilitySlotModel slot)
  onSlotAdded;
  final void Function(String providerId, String slotId) onSlotRemoved;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final commissionController = useTextEditingController(text: '100');
    useListenable(nameController);
    useListenable(commissionController);
    final commissionRate = double.tryParse(commissionController.text);
    final canAdd =
        nameController.text.trim().isNotEmpty &&
        commissionRate != null &&
        commissionRate >= 0 &&
        commissionRate <= 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormFieldLabel(context.l10n.serviceProvidersRequired),
        const SizedBox(height: 8),
        Text(
          context.l10n.serviceProvidersDescription,
          style: TextStyle(color: context.appPalette.muted, fontSize: 13),
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: nameController,
          hintText: context.l10n.providerNameExample,
        ),
        const SizedBox(height: 10),
        FormFieldLabel(context.l10n.providerCommissionRateHint),
        const SizedBox(height: 6),
        Text(
          context.l10n.providerCommissionRateDescription,
          style: TextStyle(color: context.appPalette.muted, fontSize: 13),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: commissionController,
          hintText: context.l10n.providerCommissionRateRangeHint,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}(\.\d{0,2})?')),
          ],
        ),
        const SizedBox(height: 12),
        CustomButton(
          buttonName: context.l10n.addProvider,
          color: context.appPalette.surface,
          textColor: AppColors.primary,
          borderColor: AppColors.primary,
          enabled: canAdd,
          onPressed: !canAdd
              ? null
              : () {
                  onProviderAdded(
                    ServiceProviderModel(
                      id: 'provider-${DateTime.now().microsecondsSinceEpoch}',
                      name: nameController.text.trim(),
                      commissionRate: commissionRate,
                    ),
                  );
                  nameController.clear();
                },
        ),
        if (providers.isNotEmpty) ...[
          const SizedBox(height: 18),
          ...providers.map(
            (provider) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: ServiceProviderAvailabilityCard(
                provider: provider,
                onRemove: () => onProviderRemoved(provider.id),
                onSlotAdded: (slot) => onSlotAdded(provider.id, slot),
                onSlotRemoved: (slotId) => onSlotRemoved(provider.id, slotId),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
