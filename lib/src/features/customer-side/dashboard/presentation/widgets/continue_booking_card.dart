import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:multibook/app.dart';
import 'package:multibook/src/data/models/booking_draft_model.dart';
import 'package:multibook/src/features/customer-side/booking_details/domain/models/booking_details_arguments.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ContinueBookingCard extends StatelessWidget {
  const ContinueBookingCard({super.key, required this.draft});
  final BookingDraftModel draft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.surfaceHighlight),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  draft.businessImageUrl,
                  width: 65,
                  height: 65,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const SizedBox(
                    width: 65,
                    height: 65,
                    child: ColoredBox(color: AppColors.surfaceHighlight),
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      draft.businessName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${DateFormat('dd.MM').format(draft.checkIn)}–${DateFormat('dd.MM').format(draft.checkOut)} • ${context.l10n.guests(draft.adults + draft.children + draft.infants)}',
                      style: TextStyle(color: AppColors.muted, fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${context.l10n.formatCurrency(draft.pricePerNight)}${context.l10n.perNight}',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomButton(
            buttonName: context.l10n.resume,
            height: 41,
            onPressed: () async => context.push(
              AppRoutes.BOOKING_DETAILS,
              extra: BookingDetailsArguments(
                stay: StayListing(
                  id: draft.businessId,
                  name: draft.businessName,
                  location: draft.businessLocation,
                  pricePerNight: draft.pricePerNight,
                  rating: 0,
                  reviewCount: 0,
                  imageUrl: draft.businessImageUrl,
                ),
                pricePerNight: draft.pricePerNight,
                draft: draft,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
