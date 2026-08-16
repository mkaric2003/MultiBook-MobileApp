import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class StayLocationSection extends StatelessWidget {
  const StayLocationSection({super.key, required this.stay});

  final StayListing stay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.surfaceHighlight)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Location',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          Container(
            height: 145,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.map_outlined,
              size: 48,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            stay.location.isEmpty
                ? 'Location available on request'
                : stay.location,
            style: const TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 14),
          CustomButton(
            buttonName: 'Open in Maps',
            color: Colors.transparent,
            borderColor: AppColors.border,
            onPressed: () async {},
          ),
        ],
      ),
    );
  }
}
