import 'package:flutter/material.dart';
import 'package:multibook/src/global_widgets/skeleton_shimmer.dart';

class SupportTicketsSkeleton extends StatelessWidget {
  const SupportTicketsSkeleton({super.key});

  @override
  Widget build(BuildContext context) => SkeletonShimmer(
    child: ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      itemCount: 5,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, index) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _line(width: index.isEven ? 175 : 138, height: 16),
                ),
                const SizedBox(width: 16),
                _line(width: 68, height: 25, radius: 13),
              ],
            ),
            const SizedBox(height: 12),
            _line(width: 98, height: 13),
            const SizedBox(height: 11),
            _line(width: double.infinity, height: 14),
            const SizedBox(height: 8),
            _line(width: index.isEven ? 210 : 165, height: 14),
            const SizedBox(height: 14),
            _line(width: 76, height: 12),
          ],
        ),
      ),
    ),
  );

  Widget _line({
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
