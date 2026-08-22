import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:flutter/material.dart';

class StayOverview extends StatelessWidget {
  const StayOverview({super.key, required this.stay});

  final StayListing stay;

  @override
  Widget build(BuildContext context) {
    final price = stay.pricePerNight;
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stay.name,
            style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.muted, size: 19),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  '${stay.location.isEmpty ? context.l10n.cityCentre : stay.location} · 0.5 km',
                  style: const TextStyle(color: AppColors.muted, fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            '⭐ ${stay.rating.toStringAsFixed(1)} · ${context.l10n.reviews(stay.reviewCount)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          if (price != null) ...[
            const SizedBox(height: 22),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: context.l10n.formatCurrency(price),
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: ' ${context.l10n.perNight}',
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
