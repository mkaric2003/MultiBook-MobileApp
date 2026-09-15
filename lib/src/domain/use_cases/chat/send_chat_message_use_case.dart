import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/chat_message_model.dart';
import 'package:multibook/src/domain/repositories/chat_repository.dart';

@injectable
class SendChatMessageUseCase {
  SendChatMessageUseCase(this._repository);

  final ChatRepository _repository;

  Future<Result<ChatMessageModel>> execute({
    required String conversationId,
    required String text,
  }) => _repository.sendMessage(conversationId: conversationId, text: text);
}
