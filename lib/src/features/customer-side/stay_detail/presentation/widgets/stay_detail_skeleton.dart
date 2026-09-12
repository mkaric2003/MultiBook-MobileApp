import 'package:flutter/material.dart';
import 'package:multibook/src/features/customer-side/stay_detail/presentation/widgets/stay_detail_action_button.dart';
import 'package:multibook/src/global_widgets/skeleton_shimmer.dart';

class StayDetailSkeleton extends StatelessWidget {
  const StayDetailSkeleton({required this.onBack, super.key});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            SkeletonShimmer(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 362, color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 26, 22, 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _line(width: 240, height: 27),
                          const SizedBox(height: 14),
                          _line(width: 185, height: 16),
                          const SizedBox(height: 16),
                          _line(width: 130, height: 16),
                          const SizedBox(height: 24),
                          _line(width: 105, height: 27),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: _field()),
                              const SizedBox(width: 12),
                              Expanded(child: _field()),
                            ],
                          ),
                          const SizedBox(height: 14),
                          _field(),
                          const SizedBox(height: 18),
                          Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 22, 22, 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _line(width: 150, height: 22),
                          const SizedBox(height: 18),
                          Container(
                            height: 112,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          const SizedBox(height: 28),
                          _line(width: 120, height: 22),
                          const SizedBox(height: 18),
                          Row(
                            children: List.generate(
                              4,
                              (_) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Container(
                                    height: 58,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 45,
              left: 18,
              child: StayDetailActionButton(
                icon: Icons.arrow_back,
                onPressed: onBack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field() => Container(
    height: 66,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
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
