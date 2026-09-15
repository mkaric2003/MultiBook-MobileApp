import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/data/models/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    required this.message,
    required this.isMine,
    this.isSeen = false,
    super.key,
  });

  final ChatMessageModel message;
  final bool isMine;
  final bool isSeen;

  @override
  Widget build(BuildContext context) => Align(
    alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isMine
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 290),
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(
            color: isMine ? AppColors.primary : context.appPalette.surface,
            borderRadius: BorderRadius.circular(16).copyWith(
              bottomRight: isMine ? const Radius.circular(3) : null,
              bottomLeft: isMine ? null : const Radius.circular(3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message.text,
                style: TextStyle(
                  color: isMine ? AppColors.white : null,
                  fontSize: 15,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('h:mm a').format(message.createdAt),
                style: TextStyle(
                  color: isMine ? Colors.white70 : context.appPalette.muted,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        if (isSeen)
          Padding(
            padding: EdgeInsets.only(bottom: 7),
            child: Text(
              context.l10n.seen,
              style: TextStyle(color: context.appPalette.muted, fontSize: 10),
            ),
          )
        else
          const SizedBox(height: 5),
      ],
    ),
  );
}
