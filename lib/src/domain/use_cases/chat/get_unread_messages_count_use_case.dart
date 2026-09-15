import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/chat_repository.dart';

@injectable
class GetUnreadMessagesCountUseCase {
  GetUnreadMessagesCountUseCase(this._repository);

  final ChatRepository _repository;

  Future<Result<int>> execute() => _repository.getUnreadMessagesCount();
}
