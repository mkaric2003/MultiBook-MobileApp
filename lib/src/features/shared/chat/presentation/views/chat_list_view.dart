import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
import 'package:aquabook/src/features/shared/chat/cubit/chat_list_cubit.dart';
import 'package:aquabook/src/features/shared/chat/cubit/chat_list_state.dart';
import 'package:aquabook/src/features/shared/chat/domain/models/chat_conversation_arguments.dart';
import 'package:aquabook/src/features/shared/chat/presentation/widgets/chat_conversation_tile.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class ChatListView extends HookWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = useFuture(
      useMemoized(getIt<UserRepository>().getCurrentUser),
    );
    return BlocProvider(
      create: (_) => getIt<ChatListCubit>()..load(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(title: 'Messages'),
              Expanded(
                child: BlocBuilder<ChatListCubit, ChatListState>(
                  builder: (context, state) {
                    if (state.isLoading ||
                        currentUser.connectionState ==
                            ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.errorMessage != null) {
                      return Center(child: Text(state.errorMessage!));
                    }
                    if (state.conversations.isEmpty) {
                      return const Center(
                        child: Text(
                          'No messages yet.',
                          style: TextStyle(color: AppColors.muted),
                        ),
                      );
                    }
                    final currentUserId = currentUser.data?.id ?? '';
                    return ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemCount: state.conversations.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final conversation = state.conversations[index];
                        return ChatConversationTile(
                          conversation: conversation,
                          currentUserId: currentUserId,
                          onTap: () => context.push(
                            AppRoutes.CHAT_CONVERSATION,
                            extra: ChatConversationArguments.fromConversation(
                              conversation,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
