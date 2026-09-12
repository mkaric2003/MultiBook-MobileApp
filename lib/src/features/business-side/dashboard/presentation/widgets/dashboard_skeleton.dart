import 'package:flutter/material.dart';
import 'package:multibook/src/global_widgets/skeleton_shimmer.dart';

class DashboardSkeleton extends StatelessWidget {
  const DashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    bottom: false,
    child: SkeletonShimmer(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _box(width: 44, height: 40, radius: 10),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _box(width: 168, height: 19),
                      const SizedBox(height: 7),
                      _box(width: 104, height: 13),
                    ],
                  ),
                ),
                _box(width: 32, height: 32, radius: 16),
              ],
            ),
            const SizedBox(height: 20),
            _metricCard(titleWidth: 124, valueWidth: 42),
            const SizedBox(height: 14),
            _metricCard(titleWidth: 148, valueWidth: 105),
            const SizedBox(height: 14),
            _metricCard(titleWidth: 112, valueWidth: 76),
            const SizedBox(height: 20),
            _chartCard(showBars: false),
            const SizedBox(height: 20),
            _chartCard(showBars: true),
          ],
        ),
      ),
    ),
  );

  Widget _metricCard({
    required double titleWidth,
    required double valueWidth,
  }) => Container(
    height: 83,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white, width: 2),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _box(width: titleWidth, height: 14),
              const SizedBox(height: 8),
              _box(width: valueWidth, height: 23),
            ],
          ),
        ),
        _box(width: 48, height: 48, radius: 12),
      ],
    ),
  );

  Widget _chartCard({required bool showBars}) => Container(
    height: 270,
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 22),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white, width: 2),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _box(width: 142, height: 18),
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) {
            final height = showBars
                ? <double>[72, 118, 91, 145][index]
                : <double>[52, 94, 75, 126][index];
            return _box(width: showBars ? 30 : 18, height: height, radius: 5);
          }),
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
