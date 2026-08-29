import 'dart:developer';

import 'package:multibook/src/data/data_sources/authentication_data_source.dart';
import 'package:multibook/src/data/data_sources/firebase_storage_data_source.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/user_type.dart';
import 'package:multibook/src/data/enums/currency_code.dart';
import 'package:multibook/src/data/models/user_model.dart';
import 'package:multibook/src/domain/repositories/users_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multibook/utils/image_utils.dart';
import 'package:flutter/foundation.dart';

class UserException implements Exception {
  const UserException(this.message);

  final String message;
}

@lazySingleton
class UserProfileUseCase {
  UserProfileUseCase(
    this._authenticationDataSource,
    this._storageDataSource,
    this._usersRepository,
  );

  final AuthenticationDataSource _authenticationDataSource;
  final FirebaseStorageDataSource _storageDataSource;
  final UsersRepository _usersRepository;
  final ValueNotifier<String?> selectedBusinessId = ValueNotifier(null);

  Future<UserModel?> getCurrentUser() async {
    final userId = _authenticationDataSource.currentUser?.uid;
    if (userId == null) {
      return null;
    }

    final result = await _usersRepository.getCurrentUser();
    switch (result) {
      case Success(value: final user):
        selectedBusinessId.value = user.selectedBusinessId;
        return user;
      case FailureResult(failure: final failure):
        log(
          'Could not load the current user: $failure',
          name: 'UserProfileUseCase',
        );
        return null;
    }
  }

  Future<void> setSelectedBusiness({required String businessId}) async {
    final userId = _authenticationDataSource.currentUser?.uid;
    if (userId == null) {
      return;
    }

    final user = await getCurrentUser();
    if (user == null) {
      throw const UserException('We could not find your profile.');
    }
    _requireSuccess(
      await _usersRepository.updateProfile(
        user.copyWith(selectedBusinessId: businessId),
      ),
    );
    selectedBusinessId.value = businessId;
  }

  Future<void> setUserType({required UserType type}) async {
    final userId = _authenticationDataSource.currentUser?.uid;
    if (userId == null) {
      return;
    }

    _requireSuccess(await _usersRepository.updateRole(type));
  }

  Future<void> updateCurrentLocation({
    required String city,
    required String address,
  }) async {
    final userId = _authenticationDataSource.currentUser?.uid;
    if (userId == null) {
      throw const UserException('You need to sign in to save your location.');
    }

    final user = await getCurrentUser();
    if (user == null) {
      throw const UserException('We could not find your profile.');
    }
    _requireSuccess(
      await _usersRepository.updateProfile(
        user.copyWith(city: city.trim(), address: address.trim()),
      ),
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
    String? city,
    CurrencyCode? businessCurrency,
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
      final normalizedCity = city?.trim();
      final response = _requireSuccess(
        await _usersRepository.updateProfile(
          user.copyWith(
            firstName: trimmedFirstName,
            lastName: trimmedLastName,
            phoneNumber: trimmedPhoneNumber.isEmpty ? null : trimmedPhoneNumber,
            countryCode: countryCode ?? user.countryCode,
            dateOfBirth: dateOfBirth ?? user.dateOfBirth,
            address: address?.trim() ?? user.address,
            city: normalizedCity ?? user.city,
            businessCurrency: businessCurrency ?? user.businessCurrency,
          ),
          storagePath: profileImagePath == null
              ? null
              : 'profiles/${currentUser.uid}/profile.webp',
        ),
      );
      return response.copyWith(
        fullName: fullName,
        profileImageUrl: profileImageUrl,
      );
    } on UserException {
      rethrow;
    } catch (error, stackTrace) {
      log(
        'Could not update the user profile.',
        name: 'UserProfileUseCase',
        error: error,
        stackTrace: stackTrace,
      );
      throw const UserException('We could not update your profile.');
    }
  }

  UserModel _requireSuccess(Result<UserModel> result) => switch (result) {
    Success(value: final user) => user,
    FailureResult() => throw const UserException(
      'We could not update your profile. Please try again.',
    ),
  };
}
