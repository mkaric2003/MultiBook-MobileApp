import 'package:flutter_test/flutter_test.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/user_type.dart';
import 'package:multibook/src/data/models/user_model.dart';
import 'package:multibook/src/domain/repositories/users_repository.dart';
import 'package:multibook/src/domain/use_cases/users/get_current_user_use_case.dart';
import 'package:multibook/src/domain/use_cases/users/update_user_profile_use_case.dart';
import 'package:multibook/src/domain/use_cases/users/update_user_role_use_case.dart';

void main() {
  late _FakeUsersRepository repository;

  setUp(() {
    repository = _FakeUsersRepository();
  });

  test('loads a user through the repository contract', () async {
    final user = await GetCurrentUserUseCase(repository).execute();

    expect(repository.getCurrentUserCalls, 1);
    expect((user as Success<UserModel>).value.id, 'user-id');
  });

  test('updates a profile through the repository contract', () async {
    final user = UserModel(id: 'user-id', firstName: 'Mirza');

    await UpdateUserProfileUseCase(
      repository,
    ).execute(user, storagePath: 'profiles/user-id/profile.webp');

    expect(repository.updatedUser, user);
    expect(repository.storagePath, 'profiles/user-id/profile.webp');
  });

  test('updates a role through the repository contract', () async {
    await UpdateUserRoleUseCase(repository).execute(UserType.customer);

    expect(repository.updatedRole, UserType.customer);
  });
}

class _FakeUsersRepository implements UsersRepository {
  var getCurrentUserCalls = 0;
  UserModel? updatedUser;
  String? storagePath;
  UserType? updatedRole;

  @override
  Future<Result<UserModel>> getCurrentUser() async {
    getCurrentUserCalls++;
    return Success(UserModel(id: 'user-id'));
  }

  @override
  Future<Result<UserModel>> updateProfile(
    UserModel user, {
    String? storagePath,
  }) async {
    updatedUser = user;
    this.storagePath = storagePath;
    return Success(user);
  }

  @override
  Future<Result<UserModel>> updateRole(UserType role) async {
    updatedRole = role;
    return Success(UserModel(id: 'user-id', type: role));
  }

  @override
  Future<Result<void>> setSelectedBusiness(String businessId) async =>
      const Success(null);
}
