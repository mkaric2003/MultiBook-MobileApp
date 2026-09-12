import 'package:flutter/material.dart';
import 'package:multibook/src/global_widgets/skeleton_shimmer.dart';

class CustomerBookingsSkeleton extends StatelessWidget {
  const CustomerBookingsSkeleton.stays({super.key})
    : cardHeight = 158,
      imageSize = 78;

  const CustomerBookingsSkeleton.appointments({super.key})
    : cardHeight = 174,
      imageSize = 74;

  final double cardHeight;
  final double imageSize;

  @override
  Widget build(BuildContext context) => SkeletonShimmer(
    child: ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 78),
      itemCount: 3,
      separatorBuilder: (_, _) => const SizedBox(height: 18),
      itemBuilder: (_, index) => index == 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _box(height: 22, width: 112),
                const SizedBox(height: 18),
                _card(),
              ],
            )
          : _card(),
    ),
  );

  Widget _card() => Container(
    height: cardHeight,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _box(height: imageSize, width: imageSize, radius: 12),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _box(height: 17, width: 158),
                  const SizedBox(height: 10),
                  _box(height: 13, width: 126),
                  const SizedBox(height: 9),
                  _box(height: 13, width: 96),
                  if (cardHeight > 160) ...[
                    const SizedBox(height: 9),
                    _box(height: 13, width: 116),
                  ],
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            _box(height: 24, width: 82, radius: 12),
            const Spacer(),
            _box(height: 14, width: 76),
          ],
        ),
      ],
    ),
  );

  Widget _box({
    required double height,
    required double width,
    double radius = 7,
  }) => Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}
