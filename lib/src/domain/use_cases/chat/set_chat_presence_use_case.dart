import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/chat_repository.dart';

@injectable
class SetChatPresenceUseCase {
  SetChatPresenceUseCase(this._repository);

  final ChatRepository _repository;

  Future<Result<void>> execute({
    required String conversationId,
    required bool active,
  }) => _repository.setPresence(conversationId: conversationId, active: active);
}
