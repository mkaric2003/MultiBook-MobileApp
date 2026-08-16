import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/stay_amenity.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:flutter/material.dart';

class AmenitiesSection extends StatelessWidget {
  const AmenitiesSection({super.key, required this.business});

  final BusinessModel business;

  @override
  Widget build(BuildContext context) {
    final amenities = business.stayDetails?.amenities ?? const [];
    if (amenities.isEmpty) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.surfaceHighlight),
          bottom: BorderSide(color: AppColors.surfaceHighlight),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Amenities',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 22),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 1.7,
            children: [
              for (final amenity in amenities)
                Column(
                  children: [
                    Icon(_iconFor(amenity), color: AppColors.primary, size: 30),
                    const SizedBox(height: 8),
                    Text(amenity.label),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _iconFor(StayAmenity amenity) => switch (amenity) {
    StayAmenity.wifi => Icons.wifi,
    StayAmenity.parking => Icons.local_parking,
    StayAmenity.pool => Icons.pool,
    StayAmenity.spa => Icons.spa,
    StayAmenity.petFriendly => Icons.pets,
    StayAmenity.gym => Icons.fitness_center,
  };
}
