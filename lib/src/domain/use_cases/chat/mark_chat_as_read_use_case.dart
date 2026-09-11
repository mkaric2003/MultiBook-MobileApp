import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/chat_repository.dart';

@injectable
class MarkChatAsReadUseCase {
  MarkChatAsReadUseCase(this._repository);

  final ChatRepository _repository;

  Future<Result<void>> execute(String conversationId) =>
      _repository.markAsRead(conversationId);
}
