import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/user_type.dart';
import 'package:multibook/src/data/models/user_model.dart';

/// Contract for REST-backed operations on the authenticated user.
///
/// Use cases depend on this abstraction; HTTP details remain in the data layer.
abstract class UsersRepository {
  Future<Result<UserModel>> getCurrentUser();

  Future<Result<UserModel>> updateProfile(
    UserModel user, {
    String? storagePath,
  });

  Future<Result<UserModel>> updateRole(UserType role);

  Future<Result<void>> setSelectedBusiness(String businessId);
}
