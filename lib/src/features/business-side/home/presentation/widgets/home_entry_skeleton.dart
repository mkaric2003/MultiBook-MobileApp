import 'package:flutter/material.dart';
import 'package:multibook/src/global_widgets/skeleton_shimmer.dart';

class HomeEntrySkeleton extends StatelessWidget {
  const HomeEntrySkeleton({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
        child: SkeletonShimmer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _box(height: 46, width: 46, radius: 23),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _box(height: 15, width: 132),
                      const SizedBox(height: 8),
                      _box(height: 11, width: 86),
                    ],
                  ),
                  const Spacer(),
                  _box(height: 42, width: 42, radius: 21),
                ],
              ),
              const SizedBox(height: 28),
              _box(height: 56, width: double.infinity, radius: 14),
              const SizedBox(height: 16),
              _box(height: 48, width: double.infinity, radius: 12),
              const SizedBox(height: 28),
              _box(height: 19, width: 164),
              const SizedBox(height: 16),
              SizedBox(
                height: 280,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  separatorBuilder: (_, _) => const SizedBox(width: 14),
                  itemBuilder: (_, _) => SizedBox(
                    width: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _box(height: 134, width: 180, radius: 13),
                        const SizedBox(height: 12),
                        _box(height: 16, width: 132),
                        const SizedBox(height: 10),
                        _box(height: 12, width: 94),
                        const SizedBox(height: 8),
                        _box(height: 12, width: 116),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _box({
    required double height,
    required double width,
    double radius = 8,
  }) => Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}
