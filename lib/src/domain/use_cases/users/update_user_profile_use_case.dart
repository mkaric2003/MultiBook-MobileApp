import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/user_model.dart';
import 'package:multibook/src/domain/repositories/users_repository.dart';

/// Persists editable fields of the authenticated user's REST profile.
@injectable
class UpdateUserProfileUseCase {
  UpdateUserProfileUseCase(this._usersRepository);

  final UsersRepository _usersRepository;

  Future<Result<UserModel>> execute(UserModel user, {String? storagePath}) =>
      _usersRepository.updateProfile(user, storagePath: storagePath);
}
