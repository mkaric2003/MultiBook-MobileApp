import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/data/data_sources/users_api_data_source.dart';
import 'package:multibook/src/data/enums/user_type.dart';
import 'package:multibook/src/data/models/user_model.dart';
import 'package:multibook/src/domain/repositories/users_repository.dart';

/// Data-layer implementation of the users REST repository contract.
@LazySingleton(as: UsersRepository)
class UsersRepositoryImpl implements UsersRepository {
  UsersRepositoryImpl(this._usersApiDataSource, this._executor);

  final UsersApiDataSource _usersApiDataSource;
  final RestRepositoryExecutor _executor;

  @override
  Future<Result<UserModel>> getCurrentUser() =>
      _executor.execute(_usersApiDataSource.getMe);

  @override
  Future<Result<UserModel>> updateProfile(
    UserModel user, {
    String? storagePath,
  }) => _executor.execute(
    () => _usersApiDataSource.updateProfile(user, storagePath: storagePath),
  );

  @override
  Future<Result<UserModel>> updateRole(UserType role) =>
      _executor.execute(() => _usersApiDataSource.updateRole(role));
}
