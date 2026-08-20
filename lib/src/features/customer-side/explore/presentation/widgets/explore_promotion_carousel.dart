import 'package:flutter/material.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/widgets/explore_promotion_dot.dart';

class ExplorePromotionCarousel extends StatelessWidget {
  const ExplorePromotionCarousel({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 220,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1449158743715-0a90ebb6d2d8?auto=format&fit=crop&w=1000&q=85',
            fit: BoxFit.cover,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(color: Color(0xA78B00D6)),
          ),
          const Padding(
            padding: EdgeInsets.all(28),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Autumn Getaways',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Save up to 30%',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ExplorePromotionDot(isActive: true),
                  ExplorePromotionDot(),
                  ExplorePromotionDot(),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
