import 'package:flutter/material.dart';
import 'package:multibook/src/global_widgets/skeleton_shimmer.dart';

class ChatConversationSkeleton extends StatelessWidget {
  const ChatConversationSkeleton({super.key});

  static const _bubbleWidths = <double>[210, 248, 172, 232, 194, 260];

  @override
  Widget build(BuildContext context) => SkeletonShimmer(
    child: ListView.separated(
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      itemCount: _bubbleWidths.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (_, index) => Align(
        alignment: index.isEven ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          height: index == 1 || index == 4 ? 68 : 48,
          width: _bubbleWidths[index],
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    ),
  );
}
