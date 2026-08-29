import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/user_type.dart';
import 'package:multibook/src/data/models/user_model.dart';
import 'package:multibook/src/domain/repositories/users_repository.dart';

/// Changes the role of the authenticated REST user.
@injectable
class UpdateUserRoleUseCase {
  UpdateUserRoleUseCase(this._usersRepository);

  final UsersRepository _usersRepository;

  Future<Result<UserModel>> execute(UserType role) =>
      _usersRepository.updateRole(role);
}
