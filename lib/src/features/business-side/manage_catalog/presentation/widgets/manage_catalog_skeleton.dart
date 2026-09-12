import 'package:flutter/material.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:multibook/src/global_widgets/skeleton_shimmer.dart';

class ManageCatalogSkeleton extends StatelessWidget {
  const ManageCatalogSkeleton({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          CustomAppBar(title: context.l10n.saveChanges),
          Expanded(
            child: SkeletonShimmer(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(25, 24, 25, 30),
                children: [
                  _box(width: double.infinity, height: 15),
                  const SizedBox(height: 10),
                  _box(width: 245, height: 15),
                  const SizedBox(height: 30),
                  _label(width: 104),
                  const SizedBox(height: 12),
                  _box(width: double.infinity, height: 54, radius: 12),
                  const SizedBox(height: 12),
                  _box(width: 226, height: 13),
                  const SizedBox(height: 28),
                  _field(labelWidth: 138),
                  const SizedBox(height: 26),
                  _field(labelWidth: 164),
                  const SizedBox(height: 26),
                  _label(width: 132),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _box(
                          width: double.infinity,
                          height: 82,
                          radius: 13,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _box(
                          width: double.infinity,
                          height: 82,
                          radius: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  _field(labelWidth: 92),
                  const SizedBox(height: 26),
                  _field(labelWidth: 118),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _field({required double labelWidth}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _label(width: labelWidth),
      const SizedBox(height: 10),
      _box(width: double.infinity, height: 54, radius: 12),
    ],
  );

  Widget _label({required double width}) => _box(width: width, height: 15);

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
