import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:flutter/material.dart';

class ClientBookingsHeader extends StatelessWidget {
  const ClientBookingsHeader({super.key, required this.selectedBusiness});

  final BusinessModel? selectedBusiness;

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
        Text(
          selectedBusiness?.name ?? 'No selected business',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
