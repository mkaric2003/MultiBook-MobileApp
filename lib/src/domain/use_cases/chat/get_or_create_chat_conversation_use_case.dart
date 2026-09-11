import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/chat_conversation_model.dart';
import 'package:multibook/src/domain/repositories/chat_repository.dart';

@injectable
class GetOrCreateChatConversationUseCase {
  GetOrCreateChatConversationUseCase(this._repository);

  final ChatRepository _repository;

  Future<Result<ChatConversationModel>> execute({
    required String businessId,
    String? customerId,
  }) => _repository.getOrCreateConversation(
    businessId: businessId,
    customerId: customerId,
  );
}
