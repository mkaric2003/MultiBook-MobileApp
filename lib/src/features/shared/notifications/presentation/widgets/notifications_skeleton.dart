import 'package:flutter/material.dart';
import 'package:multibook/src/global_widgets/skeleton_shimmer.dart';

class NotificationsSkeleton extends StatelessWidget {
  const NotificationsSkeleton({super.key});

  @override
  Widget build(BuildContext context) => SkeletonShimmer(
    child: ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      itemCount: 6,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (_, index) => Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _line(width: index.isEven ? 150 : 118, height: 15),
                  const SizedBox(height: 8),
                  _line(width: double.infinity, height: 12),
                  const SizedBox(height: 7),
                  _line(width: index.isEven ? 175 : 138, height: 12),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _line(width: 38, height: 12),
          ],
        ),
      ),
    ),
  );

  Widget _line({required double width, required double height}) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(height / 2),
    ),
  );
}
