import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/business_review_model.dart';
import 'package:multibook/src/domain/use_cases/reviews/get_business_reviews_use_case.dart';
import 'package:multibook/src/features/shared/business_reviews/presentation/widgets/business_review_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BusinessReviewsSheet extends HookWidget {
  const BusinessReviewsSheet({required this.businessId, super.key});

  final String businessId;

  @override
  Widget build(BuildContext context) {
    final future = useMemoized(
      () => getIt<GetBusinessReviewsUseCase>().execute(businessId),
      [businessId],
    );
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 18, 22, 24),
        child: FutureBuilder<Result<List<BusinessReviewModel>>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const SizedBox(
                height: 180,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final reviews = switch (snapshot.data) {
              Success<List<BusinessReviewModel>>(value: final items) => items,
              _ => const <BusinessReviewModel>[],
            };
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * .78,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 42,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    context.l10n.allReviews,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: reviews.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 14),
                      itemBuilder: (_, index) =>
                          BusinessReviewCard(review: reviews[index]),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
