import 'package:flutter/material.dart';
import 'package:multibook/src/global_widgets/skeleton_shimmer.dart';

class PaymentMethodsSkeleton extends StatelessWidget {
  const PaymentMethodsSkeleton({super.key});

  @override
  Widget build(BuildContext context) => SkeletonShimmer(
    child: ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 32),
      children: [
        _box(width: 220, height: 22),
        const SizedBox(height: 12),
        _box(width: double.infinity, height: 14),
        const SizedBox(height: 8),
        _box(width: 235, height: 14),
        const SizedBox(height: 22),
        _paymentCard(),
        const SizedBox(height: 18),
        _paymentCard(),
      ],
    ),
  );

  Widget _paymentCard() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 205,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          _box(width: 74, height: 25, radius: 13),
          const Spacer(),
          _box(width: 92, height: 18),
          const SizedBox(width: 14),
          _box(width: 24, height: 24, radius: 6),
        ],
      ),
    ],
  );

  Widget _box({
    required double width,
    required double height,
    double radius = 7,
  }) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}
