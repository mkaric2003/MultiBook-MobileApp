import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/chat_repository.dart';
import 'package:multibook/src/features/shared/chat/domain/models/chat_conversation_snapshot.dart';

@injectable
class WatchChatConversationUseCase {
  WatchChatConversationUseCase(this._repository);

  final ChatRepository _repository;

  Stream<Result<ChatConversationSnapshot>> execute(String conversationId) =>
      _repository.watchConversation(conversationId);
}
