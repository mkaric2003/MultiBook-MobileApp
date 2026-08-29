import 'package:injectable/injectable.dart';
import 'package:multibook/src/data/data_sources/api_client.dart';
import 'package:multibook/src/data/data_sources/firebase_storage_data_source.dart';
import 'package:multibook/src/data/enums/user_type.dart';
import 'package:multibook/src/data/models/user_model.dart';

@lazySingleton
class UsersApiDataSource {
  UsersApiDataSource(this._client, this._storageDataSource);

  final ApiClient _client;
  final FirebaseStorageDataSource _storageDataSource;

  Future<UserModel> getMe() async =>
      _decode((await _client.get('/v1/users/me')).data!);

  Future<UserModel> updateRole(UserType role) async => _decode(
    (await _client.put('/v1/users/me/role', data: {'role': role.name})).data!,
  );

  Future<UserModel> updateProfile(UserModel user, {String? storagePath}) async {
    const editableFields = {
      'first_name',
      'last_name',
      'phone_e164',
      'country_code',
      'date_of_birth',
      'address',
      'city',
      'business_currency',
      'selected_business_id',
    };
    final data = Map<String, dynamic>.from(user.toMap())
      ..removeWhere((key, _) => !editableFields.contains(key));
    final dateOfBirth = user.dateOfBirth;
    if (dateOfBirth != null) {
      data['date_of_birth'] =
          '${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}';
    }
    if (storagePath != null) data['avatar_storage_path'] = storagePath;
    return _decode((await _client.patch('/v1/users/me', data: data)).data!);
  }

  Future<UserModel> _decode(Map<String, dynamic> data) async {
    final user = UserModel.fromMap(data);
    final storagePath = user.profileImageUrl;
    if (storagePath == null || storagePath.isEmpty) return user;
    return user.copyWith(
      profileImageUrl: await _storageDataSource.getDownloadUrl(
        storagePath: storagePath,
      ),
    );
  }
}
