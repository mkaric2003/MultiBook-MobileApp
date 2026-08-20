import 'dart:developer';

import 'package:aquabook/src/data/data_sources/authentication_data_source.dart';
import 'package:aquabook/src/data/data_sources/firebase_storage_data_source.dart';
import 'package:aquabook/src/data/data_sources/firestore_data_source.dart';
import 'package:aquabook/src/data/enums/user_type.dart';
import 'package:aquabook/src/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aquabook/utils/image_utils.dart';
import 'package:flutter/foundation.dart';

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
  final ValueNotifier<String?> selectedBusinessId = ValueNotifier(null);

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

      final user = UserModelMapper.fromMap(_normalizeUserData(userData));
      selectedBusinessId.value = user.selectedBusinessId;
      return user;
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
    selectedBusinessId.value = businessId;
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
    String? countryCode,
    DateTime? dateOfBirth,
    String? address,
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
          minWidth: 512,
          minHeight: 512,
          quality: 38,
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
          'countryCode': countryCode,
          'dateOfBirth': dateOfBirth,
          'address': address?.trim().isEmpty ?? true ? null : address!.trim(),
          'updatedAt': _firestoreDataSource.serverTimestamp,
        },
      );

      return user.copyWith(
        firstName: trimmedFirstName,
        lastName: trimmedLastName,
        fullName: fullName,
        phoneNumber: trimmedPhoneNumber.isEmpty ? null : trimmedPhoneNumber,
        profileImageUrl: profileImageUrl,
        countryCode: countryCode,
        dateOfBirth: dateOfBirth,
        address: address?.trim().isEmpty ?? true ? null : address!.trim(),
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

  Map<String, dynamic> _normalizeUserData(Map<String, dynamic> userData) {
    final normalizedData = Map<String, dynamic>.from(userData);
    final dateOfBirth = normalizedData['dateOfBirth'];
    if (dateOfBirth is Timestamp) {
      normalizedData['dateOfBirth'] = dateOfBirth.millisecondsSinceEpoch;
    }
    return normalizedData;
  }
}
