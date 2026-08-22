import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/business_review_model.dart';
import 'package:flutter/material.dart';

class BusinessReviewCard extends StatelessWidget {
  const BusinessReviewCard({required this.review, super.key});

  final BusinessReviewModel review;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.surfaceHighlight,
              backgroundImage: review.customerAvatarUrl?.isNotEmpty == true
                  ? NetworkImage(review.customerAvatarUrl!)
                  : null,
              child: review.customerAvatarUrl?.isNotEmpty == true
                  ? null
                  : const Icon(Icons.person, color: AppColors.muted),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                review.customerName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(
            5,
            (index) => Icon(
              index < review.rating
                  ? Icons.star_rounded
                  : Icons.star_outline_rounded,
              color: const Color(0xFFFACC15),
              size: 20,
            ),
          ),
        ),
        if (review.comment?.isNotEmpty == true) ...[
          const SizedBox(height: 10),
          Text(
            review.comment!,
            style: const TextStyle(color: AppColors.muted, height: 1.4),
          ),
        ],
      ],
    ),
  );
}
