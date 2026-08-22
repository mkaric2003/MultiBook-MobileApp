import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:aquabook/src/data/models/business_review_model.dart';
import 'package:aquabook/src/features/shared/business_reviews/presentation/widgets/business_review_card.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ServiceReviewsSection extends StatelessWidget {
  const ServiceReviewsSection({
    required this.service,
    required this.reviews,
    required this.onViewAll,
    super.key,
  });

  final ServiceListing service;
  final List<BusinessReviewModel> reviews;
  final Future<void> Function() onViewAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.customerReviews,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                '⭐ ${service.rating.toStringAsFixed(1)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
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
              borderColor: AppColors.border,
              onPressed: onViewAll,
            ),
        ],
      ),
    );
  }
}
