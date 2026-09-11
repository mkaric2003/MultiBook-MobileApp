import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class EarningsBusinessSelector extends StatelessWidget {
  const EarningsBusinessSelector({
    required this.businesses,
    required this.selectedBusiness,
    required this.onSelected,
    super.key,
  });

  final List<BusinessModel> businesses;
  final BusinessModel? selectedBusiness;
  final ValueChanged<BusinessModel> onSelected;

  @override
  Widget build(BuildContext context) => PopupMenuButton<String>(
    enabled: businesses.isNotEmpty,
    onSelected: (businessId) {
      for (final business in businesses) {
        if (business.id == businessId) {
          onSelected(business);
          return;
        }
      }
    },
    itemBuilder: (_) => businesses
        .map(
          (business) => PopupMenuItem(
            value: business.id,
            child: Text(
              business.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
        .toList(),
    child: Container(
      constraints: const BoxConstraints(maxWidth: 165),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: context.appPalette.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              selectedBusiness?.name ?? context.l10n.selectBusiness,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 19),
        ],
      ),
    ),
  );
}
