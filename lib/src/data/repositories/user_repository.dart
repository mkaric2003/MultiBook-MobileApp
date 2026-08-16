import 'dart:developer';

import 'package:aquabook/src/data/data_sources/authentication_data_source.dart';
import 'package:aquabook/src/data/data_sources/firestore_data_source.dart';
import 'package:aquabook/src/data/enums/user_type.dart';
import 'package:aquabook/src/data/models/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRepository {
  UserRepository(this._authenticationDataSource, this._firestoreDataSource);

  static const _usersCollection = 'users';

  final AuthenticationDataSource _authenticationDataSource;
  final FirestoreDataSource _firestoreDataSource;

  Future<UserModel?> getCurrentUser() async {
    final userId = _authenticationDataSource.currentUser?.uid;
    if (userId == null) {
      return null;
    }

    try {
      final userData = await _firestoreDataSource.getDocument(
        collection: _usersCollection,
        documentId: userId,
      );
      if (userData == null) {
        return null;
      }

      return UserModelMapper.fromMap(userData);
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Could not load the current user: ${error.code}',
        name: 'UserRepository',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<void> setSelectedBusiness({required String businessId}) async {
    final userId = _authenticationDataSource.currentUser?.uid;
    if (userId == null) {
      return;
    }

    await _firestoreDataSource.updateDocument(
      collection: _usersCollection,
      documentId: userId,
      data: {
        'type': UserType.provider.name,
        'selectedBusinessId': businessId,
        'updatedAt': _firestoreDataSource.serverTimestamp,
      },
    );
  }
}
