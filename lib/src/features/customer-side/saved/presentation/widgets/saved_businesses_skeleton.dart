import 'package:flutter/material.dart';
import 'package:multibook/src/global_widgets/skeleton_shimmer.dart';

class SavedBusinessesSkeleton extends StatelessWidget {
  const SavedBusinessesSkeleton({super.key});

  @override
  Widget build(BuildContext context) => SkeletonShimmer(
    child: ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
      itemCount: 2,
      separatorBuilder: (_, _) => const SizedBox(height: 18),
      itemBuilder: (_, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 190,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _box(height: 19, width: 196),
                const SizedBox(height: 10),
                _box(height: 14, width: 142),
                const SizedBox(height: 10),
                _box(height: 14, width: 108),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _box(height: 17, width: 116),
                    const Spacer(),
                    _box(height: 42, width: 112, radius: 21),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
