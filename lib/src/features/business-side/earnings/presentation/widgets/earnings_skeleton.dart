import 'package:flutter/material.dart';
import 'package:multibook/src/global_widgets/skeleton_shimmer.dart';

class EarningsSkeleton extends StatelessWidget {
  const EarningsSkeleton({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    bottom: false,
    child: SkeletonShimmer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: Row(
              children: [
                _box(width: 104, height: 24),
                const Spacer(),
                _box(width: 142, height: 42, radius: 12),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
              children: [
                _box(width: double.infinity, height: 50, radius: 12),
                const SizedBox(height: 14),
                Container(
                  height: 106,
                  padding: const EdgeInsets.all(20),
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
                            _box(width: 168, height: 15),
                            const SizedBox(height: 10),
                            _box(width: 126, height: 31),
                          ],
                        ),
                      ),
                      _box(width: 58, height: 58, radius: 13),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(child: _payoutCard(titleWidth: 92)),
                    const SizedBox(width: 12),
                    Expanded(child: _payoutCard(titleWidth: 78)),
                  ],
                ),
                const SizedBox(height: 20),
                _chartCard(showBars: false),
                const SizedBox(height: 20),
                _chartCard(showBars: true),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _payoutCard({required double titleWidth}) => Container(
    height: 88,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white, width: 2),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _box(width: titleWidth, height: 14),
        const SizedBox(height: 10),
        _box(width: 82, height: 22),
      ],
    ),
  );

  Widget _chartCard({required bool showBars}) => Container(
    height: 270,
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 22),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white, width: 2),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _box(width: 138, height: 18),
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) {
            final height = showBars
                ? <double>[76, 124, 94, 148][index]
                : <double>[54, 88, 72, 120][index];
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
