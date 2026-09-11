import 'package:multibook/app.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SavedBusinessCard extends StatelessWidget {
  const SavedBusinessCard({
    super.key,
    required this.business,
    required this.onRemove,
  });
  final BusinessModel business;
  final VoidCallback onRemove;
  @override
  Widget build(BuildContext context) {
    final stay = StayListing.fromBusiness(business);
    final service = ServiceListing.fromBusiness(business);
    final isStay = business.type == BusinessType.stays;
    return Container(
      decoration: BoxDecoration(
        color: context.appPalette.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                stay.imageUrl,
                height: 190,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => SizedBox(
                  height: 190,
                  child: ColoredBox(color: context.appPalette.surfaceHighlight),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: onRemove,
                    icon: const Icon(Icons.favorite, color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stay.name,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  stay.location,
                  style: TextStyle(color: context.appPalette.muted),
                ),
                const SizedBox(height: 8),
                Text(
                  '⭐ ${stay.rating.toStringAsFixed(1)} (${context.l10n.reviews(stay.reviewCount)})',
                  style: TextStyle(color: context.appPalette.muted),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Text(
                      isStay
                          ? '${context.l10n.formatCurrency(stay.pricePerNight ?? 0)}${context.l10n.perNight}'
                          : context.l10n.formatCurrency(service.price ?? 0),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    FilledButton(
                      onPressed: () => context.push(
                        isStay
                            ? AppRoutes.STAY_DETAIL
                            : AppRoutes.SERVICE_DETAIL,
                        extra: isStay ? stay : service,
                      ),
                      child: Text(context.l10n.viewDetails),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
