import 'dart:developer';

import 'package:aquabook/src/data/data_sources/authentication_data_source.dart';
import 'package:aquabook/src/data/data_sources/firebase_storage_data_source.dart';
import 'package:aquabook/src/data/data_sources/firestore_data_source.dart';
import 'package:aquabook/src/data/enums/user_type.dart';
import 'package:aquabook/src/data/models/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aquabook/utils/image_utils.dart';

class UserException implements Exception {
  const UserException(this.message);

  final String message;
}

@lazySingleton
class UserRepository {
  UserRepository(
    this._authenticationDataSource,
    this._firestoreDataSource,
    this._storageDataSource,
  );

  static const _usersCollection = 'users';

  final AuthenticationDataSource _authenticationDataSource;
  final FirestoreDataSource _firestoreDataSource;
  final FirebaseStorageDataSource _storageDataSource;

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

  Future<void> setUserType({required UserType type}) async {
    final userId = _authenticationDataSource.currentUser?.uid;
    if (userId == null) {
      return;
    }

    await _firestoreDataSource.updateDocument(
      collection: _usersCollection,
      documentId: userId,
      data: {
        'type': type.name,
        'updatedAt': _firestoreDataSource.serverTimestamp,
      },
    );
  }

  Future<UserModel> updateProfile({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? profileImagePath,
  }) async {
    final currentUser = _authenticationDataSource.currentUser;
    if (currentUser == null) {
      throw const UserException('You need to sign in to update your profile.');
    }

    final user = await getCurrentUser();
    if (user == null) {
      throw const UserException('We could not find your profile.');
    }

    final trimmedFirstName = firstName.trim();
    final trimmedLastName = lastName.trim();
    final trimmedPhoneNumber = phoneNumber.trim();
    final fullName = [
      trimmedFirstName,
      trimmedLastName,
    ].where((name) => name.isNotEmpty).join(' ');

    try {
      var profileImageUrl = user.profileImageUrl;
      if (profileImagePath != null) {
        final compressedImageBytes = await compressImage(
          XFile(profileImagePath),
        );
        profileImageUrl = await _storageDataSource.uploadImage(
          storagePath: 'profiles/${currentUser.uid}/profile.webp',
          imageBytes: compressedImageBytes,
          contentType: 'image/webp',
        );
      }

      await _authenticationDataSource.updateDisplayName(
        user: currentUser,
        displayName: fullName,
      );
      await _firestoreDataSource.updateDocument(
        collection: _usersCollection,
        documentId: currentUser.uid,
        data: {
          'firstName': trimmedFirstName,
          'lastName': trimmedLastName,
          'fullName': fullName,
          'phoneNumber': trimmedPhoneNumber.isEmpty ? null : trimmedPhoneNumber,
          'profileImageUrl': profileImageUrl,
          'updatedAt': _firestoreDataSource.serverTimestamp,
        },
      );

      return user.copyWith(
        firstName: trimmedFirstName,
        lastName: trimmedLastName,
        fullName: fullName,
        phoneNumber: trimmedPhoneNumber.isEmpty ? null : trimmedPhoneNumber,
        profileImageUrl: profileImageUrl,
      );
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Could not update the user profile: ${error.code}',
        name: 'UserRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw const UserException('We could not update your profile.');
    }
  }
}
