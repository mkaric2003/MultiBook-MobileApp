import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/stay_amenity.dart';
import 'package:aquabook/l10n/l10n.dart';
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
          Text(
            context.l10n.amenities,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
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
                    Text(context.l10n.stayAmenity(amenity)),
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
    StayAmenity.airConditioning => Icons.ac_unit_rounded,
    StayAmenity.heating => Icons.thermostat_rounded,
    StayAmenity.kitchen => Icons.kitchen_rounded,
    StayAmenity.washer => Icons.local_laundry_service_rounded,
    StayAmenity.balcony => Icons.balcony_rounded,
    StayAmenity.seaView => Icons.waves_rounded,
    StayAmenity.mountainView => Icons.terrain_rounded,
    StayAmenity.workspace => Icons.desk_rounded,
    StayAmenity.elevator => Icons.elevator_rounded,
    StayAmenity.skiInSkiOut => Icons.downhill_skiing_rounded,
    StayAmenity.skiStorage => Icons.inventory_2_rounded,
    StayAmenity.skiRental => Icons.snowshoeing_rounded,
    StayAmenity.skiShuttle => Icons.airport_shuttle_rounded,
  };
}
