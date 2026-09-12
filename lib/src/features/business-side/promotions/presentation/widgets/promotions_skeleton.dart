import 'package:flutter/material.dart';
import 'package:multibook/src/global_widgets/skeleton_shimmer.dart';

class PromotionsSkeleton extends StatelessWidget {
  const PromotionsSkeleton({super.key});

  @override
  Widget build(BuildContext context) => SkeletonShimmer(
    child: ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: [
        _box(width: 128, height: 14),
        const SizedBox(height: 10),
        _box(width: 184, height: 22),
        const SizedBox(height: 18),
        for (var index = 0; index < 3; index++) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _box(width: index.isEven ? 158 : 126, height: 17),
                    ),
                    const SizedBox(width: 12),
                    _box(width: 28, height: 28, radius: 8),
                    const SizedBox(width: 12),
                    _box(width: 46, height: 28, radius: 14),
                  ],
                ),
                const SizedBox(height: 12),
                _box(width: 82, height: 16),
                const SizedBox(height: 10),
                _box(width: 238, height: 12),
                const SizedBox(height: 9),
                _box(width: 94, height: 13),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
        _box(width: double.infinity, height: 52, radius: 12),
      ],
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
