import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:flutter/material.dart';

class ClientBookingsHeader extends StatelessWidget {
  const ClientBookingsHeader({
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
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.surfaceHighlight)),
    ),
    child: Row(
      children: [
        const Expanded(
          child: Text(
            'Bookings',
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
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
            decoration: BoxDecoration(
              color: const Color(0xFF172554),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Row(
              children: [
                Text(
                  selectedBusiness?.name ?? 'Select business',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
