import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:flutter/material.dart';

class MoreHeader extends StatelessWidget {
  const MoreHeader({
    super.key,
    required this.businesses,
    required this.selectedBusiness,
    required this.onBusinessSelected,
  });

  final List<BusinessModel> businesses;
  final BusinessModel? selectedBusiness;
  final ValueChanged<BusinessModel> onBusinessSelected;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(20, 16, 16, 14),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.surfaceHighlight)),
    ),
    child: Row(
      children: [
        const Expanded(
          child: Text(
            'More',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
        ),
        PopupMenuButton<String>(
          enabled: businesses.isNotEmpty,
          onSelected: (businessId) {
            for (final business in businesses) {
              if (business.id == businessId) {
                onBusinessSelected(business);
                return;
              }
            }
          },
          itemBuilder: (_) => businesses
              .map(
                (business) => PopupMenuItem(
                  value: business.id,
                  child: Text(business.name),
                ),
              )
              .toList(),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 178),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF172554),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.apartment_rounded,
                  color: AppColors.primary,
                  size: 19,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    selectedBusiness?.name ?? 'Select business',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(Icons.keyboard_arrow_down, size: 20),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
