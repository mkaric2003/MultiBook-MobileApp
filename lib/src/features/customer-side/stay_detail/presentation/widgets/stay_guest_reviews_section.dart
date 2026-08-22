import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/presentation/widgets/stay_review_card.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class StayGuestReviewsSection extends StatelessWidget {
  const StayGuestReviewsSection({super.key, required this.stay});

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
          Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.guestReviews,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                '⭐ ${stay.rating.toStringAsFixed(1)} / 5',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const StayReviewCard(
            name: 'Sarah M.',
            review:
                'Amazing stay! The room was spotless and the staff was incredibly helpful. Great location too.',
          ),
          const SizedBox(height: 14),
          const StayReviewCard(
            name: 'James K.',
            review:
                'Perfect for business travel. Fast Wi-Fi, comfortable workspace, and excellent breakfast.',
          ),
          const SizedBox(height: 18),
          CustomButton(
            buttonName: context.l10n.seeAllReviews,
            color: Colors.transparent,
            borderColor: AppColors.border,
            onPressed: () async {},
          ),
        ],
      ),
    );
  }
}
