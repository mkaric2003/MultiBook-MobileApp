import 'package:flutter/material.dart';
import 'package:multibook/src/global_widgets/skeleton_shimmer.dart';

class AvailabilityCalendarSkeleton extends StatelessWidget {
  const AvailabilityCalendarSkeleton({super.key});

  @override
  Widget build(BuildContext context) => SkeletonShimmer(
    child: ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(25, 28, 25, 32),
      children: [
        _box(width: double.infinity, height: 54, radius: 12),
        const SizedBox(height: 28),
        Row(
          children: [
            _box(width: 38, height: 38, radius: 19),
            const Spacer(),
            _box(width: 154, height: 22),
            const Spacer(),
            _box(width: 38, height: 38, radius: 19),
          ],
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (_) => _box(width: 16, height: 12)),
              ),
              const SizedBox(height: 18),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 35,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1,
                ),
                itemBuilder: (_, index) => Center(
                  child: _box(
                    width: index == 17 ? 34 : 25,
                    height: index == 17 ? 34 : 25,
                    radius: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            3,
            (_) => Row(
              children: [
                _box(width: 10, height: 10, radius: 5),
                const SizedBox(width: 7),
                _box(width: 62, height: 12),
              ],
            ),
          ),
        ),
        const SizedBox(height: 38),
        _box(width: 176, height: 23),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              _box(width: 46, height: 46, radius: 12),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _box(width: 132, height: 15),
                    const SizedBox(height: 8),
                    _box(width: 174, height: 13),
                  ],
                ),
              ),
              _box(width: 54, height: 14),
            ],
          ),
        ),
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
