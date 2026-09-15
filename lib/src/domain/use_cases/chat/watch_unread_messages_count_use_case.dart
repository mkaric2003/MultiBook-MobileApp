import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/chat_repository.dart';

@injectable
class WatchUnreadMessagesCountUseCase {
  WatchUnreadMessagesCountUseCase(this._repository);

  final ChatRepository _repository;

  Stream<Result<int>> execute() => _repository.watchUnreadMessagesCount();
}
