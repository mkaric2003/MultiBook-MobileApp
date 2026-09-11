import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/chat_conversation_model.dart';
import 'package:multibook/src/domain/repositories/chat_repository.dart';

@injectable
class WatchChatConversationsUseCase {
  WatchChatConversationsUseCase(this._repository);

  final ChatRepository _repository;

  Stream<Result<List<ChatConversationModel>>> execute() =>
      _repository.watchConversations();
}
