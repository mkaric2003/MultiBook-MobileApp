import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/service_provider_model.dart';
import 'package:flutter/material.dart';

class ServiceProviderSelector extends StatelessWidget {
  const ServiceProviderSelector({
    required this.providers,
    required this.selectedProviderId,
    required this.onChanged,
    super.key,
  });

  final List<ServiceProviderModel> providers;
  final String? selectedProviderId;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedProviderId,
        isExpanded: true,
        dropdownColor: AppColors.surface,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        items: providers
            .map(
              (provider) => DropdownMenuItem(
                value: provider.id,
                child: Text('${provider.name} · ${provider.title}'),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    ),
  );
}
