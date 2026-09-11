import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/chat_repository.dart';

@injectable
class SetChatTypingUseCase {
  SetChatTypingUseCase(this._repository);

  final ChatRepository _repository;

  Future<Result<void>> execute({
    required String conversationId,
    required bool active,
  }) => _repository.setTyping(conversationId: conversationId, active: active);
}
