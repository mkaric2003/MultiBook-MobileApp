import 'package:flutter/material.dart';
import 'package:multibook/src/global_widgets/skeleton_shimmer.dart';

class ClientBookingsSkeleton extends StatelessWidget {
  const ClientBookingsSkeleton({super.key});

  @override
  Widget build(BuildContext context) => SkeletonShimmer(
    child: ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 120),
      itemCount: 4,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, index) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 22, backgroundColor: Colors.white),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _box(width: index.isEven ? 142 : 112, height: 16),
                      const SizedBox(height: 8),
                      _box(width: index.isEven ? 105 : 135, height: 14),
                    ],
                  ),
                ),
                _box(width: 72, height: 25, radius: 13),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _box(width: 21, height: 21, radius: 6),
                const SizedBox(width: 7),
                _box(width: 176, height: 14),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _box(width: 21, height: 21, radius: 6),
                const SizedBox(width: 7),
                _box(width: 108, height: 14),
              ],
            ),
            const SizedBox(height: 15),
            _box(width: double.infinity, height: 44, radius: 12),
          ],
        ),
      ),
    ),
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
