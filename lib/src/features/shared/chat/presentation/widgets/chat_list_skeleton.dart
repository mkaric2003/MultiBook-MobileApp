import 'package:flutter/material.dart';
import 'package:multibook/src/global_widgets/skeleton_shimmer.dart';

class ChatListSkeleton extends StatelessWidget {
  const ChatListSkeleton({super.key});

  @override
  Widget build(BuildContext context) => SkeletonShimmer(
    child: ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemCount: 6,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.all(13),
        child: Row(
          children: [
            const CircleAvatar(radius: 25, backgroundColor: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _line(width: index.isEven ? 148 : 115, height: 16),
                  const SizedBox(height: 8),
                  _line(width: 82, height: 13),
                  const SizedBox(height: 8),
                  _line(width: index.isEven ? 192 : 154, height: 13),
                ],
              ),
            ),
            const SizedBox(width: 10),
            _line(width: 38, height: 11),
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
