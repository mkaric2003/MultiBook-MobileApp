import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/user_model.dart';
import 'package:multibook/src/domain/repositories/users_repository.dart';

/// Loads the authenticated user's REST profile.
@injectable
class GetCurrentUserUseCase {
  GetCurrentUserUseCase(this._usersRepository);

  final UsersRepository _usersRepository;

  Future<Result<UserModel>> execute() => _usersRepository.getCurrentUser();
}
