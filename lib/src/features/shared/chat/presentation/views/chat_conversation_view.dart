import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/shared/chat/cubit/chat_conversation_cubit.dart';
import 'package:multibook/src/features/shared/chat/cubit/chat_conversation_state.dart';
import 'package:multibook/src/features/shared/chat/domain/models/chat_conversation_arguments.dart';
import 'package:multibook/src/features/shared/chat/presentation/widgets/chat_composer.dart';
import 'package:multibook/src/features/shared/chat/presentation/widgets/chat_message_bubble.dart';
import 'package:multibook/src/features/shared/chat/presentation/widgets/chat_typing_indicator.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:toastification/toastification.dart';

class ChatConversationView extends HookWidget {
  const ChatConversationView({required this.arguments, super.key});

  final ChatConversationArguments arguments;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return BlocProvider(
      create: (_) => getIt<ChatConversationCubit>()..open(arguments),
      child: BlocConsumer<ChatConversationCubit, ChatConversationState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage &&
            current.errorMessage != null,
        listener: (context, state) => toastification.show(
          context: context,
          alignment: Alignment.bottomCenter,
          autoCloseDuration: const Duration(seconds: 3),
          type: ToastificationType.error,
          title: Text(state.errorMessage!),
        ),
        builder: (context, state) {
          final conversation = state.conversation;
          final isCustomer =
              conversation != null &&
              state.currentUserId == conversation.customerId;
          final title = isCustomer
              ? conversation.businessName
              : conversation?.customerName ?? arguments.businessName;
          final isOtherUserTyping =
              conversation?.typingUserId != null &&
              conversation!.typingUserId != state.currentUserId &&
              (conversation.typingExpiresAt?.isAfter(DateTime.now()) ?? false);
          final typingName = isCustomer
              ? conversation.businessName
              : conversation?.customerName ?? arguments.customerName ?? 'User';
          final otherParticipantReadAt = isCustomer
              ? conversation.lastReadAtBusiness
              : conversation?.lastReadAtCustomer;
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: Column(
                children: [
                  CustomAppBar(title: title),
                  Expanded(
                    child: state.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : state.messages.isEmpty && !isOtherUserTyping
                        ? const Center(
                            child: Text(
                              'Start the conversation.',
                              style: TextStyle(color: AppColors.muted),
                            ),
                          )
                        : ListView.builder(
                            reverse: true,
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                            itemCount:
                                state.messages.length +
                                (isOtherUserTyping ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (isOtherUserTyping && index == 0) {
                                return ChatTypingIndicator(name: typingName);
                              }
                              final message =
                                  state.messages[index -
                                      (isOtherUserTyping ? 1 : 0)];
                              final messageIndex =
                                  index - (isOtherUserTyping ? 1 : 0);
                              final isSeen =
                                  messageIndex == 0 &&
                                  message.senderId == state.currentUserId &&
                                  message.createdAt != null &&
                                  otherParticipantReadAt != null &&
                                  !otherParticipantReadAt.isBefore(
                                    message.createdAt!,
                                  );
                              return ChatMessageBubble(
                                message: message,
                                isMine: message.senderId == state.currentUserId,
                                isSeen: isSeen,
                              );
                            },
                          ),
                  ),
                  ChatComposer(
                    controller: controller,
                    isSending: state.isSending,
                    onChanged: context
                        .read<ChatConversationCubit>()
                        .onComposerChanged,
                    onSend: () {
                      final message = controller.text;
                      if (message.trim().isEmpty) return;
                      controller.clear();
                      context.read<ChatConversationCubit>().send(message);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
