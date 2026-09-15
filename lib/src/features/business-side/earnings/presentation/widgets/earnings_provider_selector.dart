import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/service_provider_model.dart';
import 'package:flutter/material.dart';

class EarningsProviderSelector extends StatelessWidget {
  const EarningsProviderSelector({
    required this.providers,
    required this.selectedProvider,
    required this.onSelected,
    super.key,
  });

  final List<ServiceProviderModel> providers;
  final ServiceProviderModel? selectedProvider;
  final ValueChanged<ServiceProviderModel?> onSelected;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: BoxDecoration(
      color: context.appPalette.surface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: context.appPalette.border),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedProvider?.id ?? '',
        isExpanded: true,
        dropdownColor: context.appPalette.surface,
        icon: Icon(Icons.keyboard_arrow_down, color: context.appPalette.muted),
        style: TextStyle(
          color: context.appPalette.foreground,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        items: [
          DropdownMenuItem(value: '', child: Text(context.l10n.allEmployees)),
          ...providers.map(
            (provider) => DropdownMenuItem(
              value: provider.id,
              child: Text(provider.name),
            ),
          ),
        ],
        onChanged: (id) => onSelected(
          providers.where((provider) => provider.id == id).firstOrNull,
        ),
      ),
    ),
  );
}
