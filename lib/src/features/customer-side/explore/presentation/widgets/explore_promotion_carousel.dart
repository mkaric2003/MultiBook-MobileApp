import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_stay_promotion.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/widgets/explore_promotion_dot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExplorePromotionCarousel extends HookWidget {
  const ExplorePromotionCarousel({super.key});

  static const _promotions = [
    ExploreStayPromotion(
      title: 'Autumn getaways',
      subtitle: 'Save up to 30%',
      imageUrl:
          'https://images.unsplash.com/photo-1449158743715-0a90ebb6d2d8?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreStayPromotion(
      title: 'Weekend escapes',
      subtitle: 'Your next break is closer than you think',
      imageUrl:
          'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreStayPromotion(
      title: 'Beachfront stays',
      subtitle: 'Wake up to ocean views',
      imageUrl:
          'https://images.unsplash.com/photo-1540541338287-41700207dee6?auto=format&fit=crop&w=1000&q=85',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final activeIndex = useState(0);
    final pageController = usePageController();

    return SizedBox(
      height: 220,
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
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(promotion.imageUrl, fit: BoxFit.cover),
                    const DecoratedBox(
                      decoration: BoxDecoration(color: Color(0xA78B00D6)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(28),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              promotion.title,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              promotion.subtitle,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
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
