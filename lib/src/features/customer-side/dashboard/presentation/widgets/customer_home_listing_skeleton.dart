import 'package:flutter/material.dart';
import 'package:multibook/src/global_widgets/skeleton_shimmer.dart';

class CustomerHomeListingSkeleton extends StatelessWidget {
  const CustomerHomeListingSkeleton.horizontal({
    required this.itemHeight,
    required this.imageHeight,
    super.key,
  }) : isGrid = false,
       isFullWidth = false;

  const CustomerHomeListingSkeleton.featured({super.key})
    : itemHeight = 300,
      imageHeight = 175,
      isGrid = false,
      isFullWidth = true;

  const CustomerHomeListingSkeleton.grid({
    required this.itemHeight,
    required this.imageHeight,
    super.key,
  }) : isGrid = true,
       isFullWidth = false;

  final double itemHeight;
  final double imageHeight;
  final bool isGrid;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    if (isGrid) {
      return SkeletonShimmer(
        child: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            mainAxisExtent: itemHeight,
          ),
          itemBuilder: (_, _) => _card(),
        ),
      );
    }

    if (isFullWidth) {
      return SizedBox(
        height: itemHeight,
        width: double.infinity,
        child: SkeletonShimmer(child: _card()),
      );
    }

    return SizedBox(
      height: itemHeight,
      child: SkeletonShimmer(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (_, _) => const SizedBox(width: 14),
          itemBuilder: (_, _) => SizedBox(width: 180, child: _card()),
        ),
      ),
    );
  }

  Widget _card() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: imageHeight,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(13, 12, 13, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _line(width: isFullWidth ? 210 : 125, height: 16),
            const SizedBox(height: 10),
            _line(width: isFullWidth ? 150 : 95, height: 12),
            const SizedBox(height: 8),
            _line(width: isFullWidth ? 180 : 110, height: 12),
            const SizedBox(height: 12),
            _line(width: isFullWidth ? 120 : 82, height: 14),
          ],
        ),
      ),
    ],
  );

  Widget _line({required double width, required double height}) => Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(height / 2),
    ),
  );
}
