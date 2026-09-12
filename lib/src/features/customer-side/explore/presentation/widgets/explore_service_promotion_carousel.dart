import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/explore/domain/models/explore_service_promotion.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/customer-side/explore/presentation/widgets/explore_promotion_dot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExploreServicePromotionCarousel extends HookWidget {
  const ExploreServicePromotionCarousel({super.key});

  List<ExploreServicePromotion> _promotions(BuildContext context) => [
    ExploreServicePromotion(
      title: context.l10n.topRatedServices,
      subtitle: context.l10n.bookInstantlyBestPrices,
      colors: [AppColors.primary, Color(0xFFC226D7)],
    ),
    ExploreServicePromotion(
      title: context.l10n.lastMinuteAvailability,
      subtitle: context.l10n.findOpeningToday,
      colors: [Color(0xFF6437D9), Color(0xFF8B5CF6)],
    ),
    ExploreServicePromotion(
      title: context.l10n.trustedLocalExperts,
      subtitle: context.l10n.verifiedProvidersNearYou,
      colors: [Color(0xFF9221B5), Color(0xFFC226D7)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final activeIndex = useState(0);
    final pageController = usePageController();
    final promotions = _promotions(context);

    return SizedBox(
      height: 118,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: promotions.length,
              onPageChanged: (index) => activeIndex.value = index,
              itemBuilder: (_, index) {
                final promotion = promotions[index];
                return DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: promotion.colors),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          promotion.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          promotion.subtitle,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    promotions.length,
                    (index) => ExplorePromotionDot(
                      isActive: activeIndex.value == index,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
