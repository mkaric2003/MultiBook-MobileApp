import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/service_availability_slot_model.dart';
import 'package:aquabook/src/data/models/service_provider_model.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/service_availability_slots_section.dart';
import 'package:flutter/material.dart';

class ServiceProviderAvailabilityCard extends StatelessWidget {
  const ServiceProviderAvailabilityCard({
    required this.provider,
    required this.onRemove,
    required this.onSlotAdded,
    required this.onSlotRemoved,
    super.key,
  });

  final ServiceProviderModel provider;
  final VoidCallback onRemove;
  final ValueChanged<ServiceAvailabilitySlotModel> onSlotAdded;
  final ValueChanged<String> onSlotRemoved;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.surfaceHighlight),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person_rounded, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                provider.name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.close, color: AppColors.muted),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ServiceAvailabilitySlotsSection(
          slots: provider.availabilitySlots,
          onSlotAdded: onSlotAdded,
          onSlotRemoved: onSlotRemoved,
        ),
      ],
    ),
  );
}
