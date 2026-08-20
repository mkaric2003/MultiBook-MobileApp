import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_service_promotion.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/widgets/explore_promotion_dot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExploreServicePromotionCarousel extends HookWidget {
  const ExploreServicePromotionCarousel({super.key});

  static const _promotions = [
    ExploreServicePromotion(
      title: 'Top-rated services',
      subtitle: 'Book instantly · Best prices',
      colors: [AppColors.primary, Color(0xFFC226D7)],
    ),
    ExploreServicePromotion(
      title: 'Last-minute availability',
      subtitle: 'Find an opening for today',
      colors: [Color(0xFF6437D9), Color(0xFF8B5CF6)],
    ),
    ExploreServicePromotion(
      title: 'Trusted local experts',
      subtitle: 'Verified providers near you',
      colors: [Color(0xFF9221B5), Color(0xFFC226D7)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final activeIndex = useState(0);
    final pageController = usePageController();

    return SizedBox(
      height: 118,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: _promotions.length,
              onPageChanged: (index) => activeIndex.value = index,
              itemBuilder: (_, index) {
                final promotion = _promotions[index];
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
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          promotion.subtitle,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
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
                    _promotions.length,
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
