import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/stay_extra_type.dart';
import 'package:aquabook/src/data/models/stay_extra_model.dart';
import 'package:flutter/material.dart';

class ReviewExtraTile extends StatelessWidget {
  const ReviewExtraTile({
    super.key,
    required this.extra,
    required this.selected,
    required this.onChanged,
  });
  final StayExtraModel extra;
  final bool selected;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.surface,
      border: Border.all(color: AppColors.border),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Container(
          width: 58,
          height: 58,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.surfaceHighlight,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(_icon(extra.type), color: AppColors.primary, size: 29),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                extra.type.label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                extra.type.description,
                style: const TextStyle(color: AppColors.muted),
              ),
              const SizedBox(height: 5),
              Text(
                '+${context.l10n.formatCurrency(extra.price)}${extra.isPerHour
                    ? '/hour'
                    : extra.isPerNight
                    ? '/day'
                    : ''}',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        Checkbox(
          value: selected,
          onChanged: (value) => onChanged(value ?? false),
          activeColor: AppColors.primary,
        ),
      ],
    ),
  );
  IconData _icon(StayExtraType type) => switch (type) {
    StayExtraType.breakfast => Icons.restaurant,
    StayExtraType.parking => Icons.local_parking,
    StayExtraType.spaAccess => Icons.spa,
    StayExtraType.airportTransfer => Icons.local_taxi_rounded,
    StayExtraType.lateCheckout => Icons.schedule_rounded,
    StayExtraType.petStay => Icons.pets_rounded,
    StayExtraType.extraBed => Icons.bed_rounded,
    StayExtraType.laundryService => Icons.local_laundry_service_rounded,
    StayExtraType.quadBikeRental => Icons.directions_car_filled_rounded,
    StayExtraType.guidedTour => Icons.tour_rounded,
    StayExtraType.hikingGuide => Icons.hiking_rounded,
    StayExtraType.boatTour => Icons.directions_boat_rounded,
  };
}
