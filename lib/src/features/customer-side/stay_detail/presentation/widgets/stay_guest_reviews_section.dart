import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:multibook/src/data/models/business_review_model.dart';
import 'package:multibook/src/features/shared/business_reviews/presentation/widgets/business_review_card.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class StayGuestReviewsSection extends StatelessWidget {
  const StayGuestReviewsSection({
    super.key,
    required this.stay,
    required this.reviews,
    required this.onViewAll,
  });

  final StayListing stay;
  final List<BusinessReviewModel> reviews;
  final Future<void> Function() onViewAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.appPalette.surfaceHighlight),
        ),
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
          ...reviews
              .take(3)
              .expand(
                (review) => [
                  BusinessReviewCard(review: review),
                  const SizedBox(height: 14),
                ],
              ),
          if (reviews.length > 3)
            CustomButton(
              buttonName: context.l10n.seeAllReviews,
              color: Colors.transparent,
              borderColor: context.appPalette.border,
              onPressed: onViewAll,
            ),
        ],
      ),
    );
  }
}
