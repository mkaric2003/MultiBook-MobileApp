import 'package:flutter/material.dart';
import 'package:multibook/src/features/customer-side/service_detail/presentation/widgets/service_detail_action_button.dart';
import 'package:multibook/src/global_widgets/skeleton_shimmer.dart';

class ServiceDetailSkeleton extends StatelessWidget {
  const ServiceDetailSkeleton({required this.onBack, super.key});

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
                    Container(height: 315, color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 24, 22, 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _line(width: 235, height: 27),
                          const SizedBox(height: 12),
                          _line(width: 100, height: 28),
                          const SizedBox(height: 18),
                          _line(width: 132, height: 16),
                          const SizedBox(height: 14),
                          _line(width: 205, height: 16),
                          const SizedBox(height: 22),
                          _line(width: 150, height: 19),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 26, 22, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _line(width: 155, height: 22),
                          const SizedBox(height: 16),
                          _offeringCard(),
                          const SizedBox(height: 12),
                          _offeringCard(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 28, 22, 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _line(width: 82, height: 22),
                          const SizedBox(height: 16),
                          _line(width: double.infinity, height: 14),
                          const SizedBox(height: 10),
                          _line(width: double.infinity, height: 14),
                          const SizedBox(height: 10),
                          _line(width: 240, height: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 18,
              child: ServiceDetailActionButton(
                icon: Icons.arrow_back,
                onPressed: onBack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _offeringCard() => Container(
    height: 104,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
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
