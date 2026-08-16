import 'dart:developer';

import 'package:aquabook/src/data/data_sources/authentication_data_source.dart';
import 'package:aquabook/src/data/data_sources/firestore_data_source.dart';
import 'package:aquabook/src/data/enums/user_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

class AuthenticationException implements Exception {
  const AuthenticationException(this.message);

  final String message;
}

class AuthenticationCancelledException implements Exception {
  const AuthenticationCancelledException();
}

@lazySingleton
class AuthenticationRepository {
  AuthenticationRepository(
    this._authenticationDataSource,
    this._firestoreDataSource,
  );

  final AuthenticationDataSource _authenticationDataSource;
  final FirestoreDataSource _firestoreDataSource;

  bool get isSignedIn => _authenticationDataSource.currentUser != null;

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    log('Starting email sign-up flow.', name: 'AuthenticationRepository');

    User? createdUser;
    try {
      final trimmedFirstName = firstName.trim();
      final trimmedLastName = lastName.trim();
      final trimmedEmail = email.trim();
      final fullName = [
        trimmedFirstName,
        trimmedLastName,
      ].where((name) => name.isNotEmpty).join(' ');

      createdUser = await _authenticationDataSource
          .createUserWithEmailAndPassword(
            email: trimmedEmail,
            password: password,
          );
      log('Firebase Auth account created.', name: 'AuthenticationRepository');

      await _authenticationDataSource.updateDisplayName(
        user: createdUser,
        displayName: fullName,
      );
      await _createUserProfile(
        user: createdUser,
        firstName: trimmedFirstName,
        lastName: trimmedLastName,
        fullName: fullName,
        email: createdUser.email ?? trimmedEmail,
      );

      log('Firestore user profile created.', name: 'AuthenticationRepository');
    } on FirebaseAuthException catch (error, stackTrace) {
      log(
        'Firebase Auth sign-up failed: ${error.code}',
        name: 'AuthenticationRepository',
        error: error,
        stackTrace: stackTrace,
      );
      await _deleteIncompleteUser(createdUser);
      throw AuthenticationException(_authErrorMessage(error));
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Firestore user-profile creation failed: ${error.code}',
        name: 'AuthenticationRepository',
        error: error,
        stackTrace: stackTrace,
      );
      await _deleteIncompleteUser(createdUser);
      throw const AuthenticationException(
        'We could not save your profile. Please check your connection and try again.',
      );
    } catch (error, stackTrace) {
      log(
        'Unexpected sign-up failure.',
        name: 'AuthenticationRepository',
        error: error,
        stackTrace: stackTrace,
      );
      await _deleteIncompleteUser(createdUser);
      throw const AuthenticationException(
        'Something went wrong. Please try again.',
      );
    }
  }

  Future<bool> signInWithGoogle() async {
    log('Starting Google sign-in flow.', name: 'AuthenticationRepository');

    User? user;
    try {
      final credential = await _authenticationDataSource.signInWithGoogle();
      user = credential.user;

      if (user == null) {
        throw const AuthenticationException(
          'We could not sign you in with Google. Please try again.',
        );
      }

      final isNewUser = credential.additionalUserInfo?.isNewUser ?? false;
      if (isNewUser) {
        final fullName = user.displayName?.trim() ?? '';
        final nameParts = fullName.isEmpty
            ? const <String>[]
            : fullName.split(RegExp(r'\s+'));

        await _createUserProfile(
          user: user,
          firstName: nameParts.isEmpty ? '' : nameParts.first,
          lastName: nameParts.skip(1).join(' '),
          fullName: fullName,
          email: user.email ?? '',
        );
        log(
          'Firestore profile created for Google user.',
          name: 'AuthenticationRepository',
        );
      }

      log('Google sign-in completed.', name: 'AuthenticationRepository');
      return isNewUser;
    } on GoogleSignInException catch (error, stackTrace) {
      if (error.code == GoogleSignInExceptionCode.canceled) {
        log('Google sign-in cancelled.', name: 'AuthenticationRepository');
        throw const AuthenticationCancelledException();
      }

      log(
        'Google sign-in failed: ${error.code.name}',
        name: 'AuthenticationRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw const AuthenticationException(
        'We could not sign you in with Google. Please try again.',
      );
    } on FirebaseAuthException catch (error, stackTrace) {
      log(
        'Firebase Auth Google sign-in failed: ${error.code}',
        name: 'AuthenticationRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw AuthenticationException(_authErrorMessage(error));
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Firestore Google profile creation failed: ${error.code}',
        name: 'AuthenticationRepository',
        error: error,
        stackTrace: stackTrace,
      );
      await _deleteIncompleteUser(user);
      throw const AuthenticationException(
        'We could not save your profile. Please check your connection and try again.',
      );
    } on AuthenticationException {
      rethrow;
    } catch (error, stackTrace) {
      log(
        'Unexpected Google sign-in failure.',
        name: 'AuthenticationRepository',
        error: error,
        stackTrace: stackTrace,
      );
      await _deleteIncompleteUser(user);
      throw const AuthenticationException(
        'We could not sign you in with Google. Please try again.',
      );
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    log('Starting email sign-in flow.', name: 'AuthenticationRepository');

    try {
      await _authenticationDataSource.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      log('Email sign-in completed.', name: 'AuthenticationRepository');
    } on FirebaseAuthException catch (error, stackTrace) {
      log(
        'Firebase Auth email sign-in failed: ${error.code}',
        name: 'AuthenticationRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw AuthenticationException(_signInErrorMessage(error));
    } catch (error, stackTrace) {
      log(
        'Unexpected email sign-in failure.',
        name: 'AuthenticationRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw const AuthenticationException(
        'We could not sign you in. Please try again.',
      );
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    final trimmedEmail = email.trim();
    if (!_isValidEmail(trimmedEmail)) {
      throw const AuthenticationException('Enter a valid email address first.');
    }

    try {
      await _authenticationDataSource.sendPasswordResetEmail(
        email: trimmedEmail,
      );
      log('Password reset email requested.', name: 'AuthenticationRepository');
    } on FirebaseAuthException catch (error, stackTrace) {
      log(
        'Password reset request failed: ${error.code}',
        name: 'AuthenticationRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw AuthenticationException(
        error.message ?? 'We could not send the password reset email.',
      );
    } catch (error, stackTrace) {
      log(
        'Unexpected password reset failure.',
        name: 'AuthenticationRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw const AuthenticationException(
        'We could not send the password reset email.',
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _authenticationDataSource.signOut();
      log('User signed out.', name: 'AuthenticationRepository');
    } on FirebaseAuthException catch (error, stackTrace) {
      log(
        'Firebase Auth sign-out failed: ${error.code}',
        name: 'AuthenticationRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw AuthenticationException(
        error.message ?? 'We could not sign you out.',
      );
    } catch (error, stackTrace) {
      log(
        'Unexpected sign-out failure.',
        name: 'AuthenticationRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw const AuthenticationException('We could not sign you out.');
    }
  }

  Future<void> _deleteIncompleteUser(User? user) async {
    if (user == null) return;

    try {
      await _authenticationDataSource.deleteUser(user);
      log(
        'Incomplete Firebase Auth account removed.',
        name: 'AuthenticationRepository',
      );
    } catch (error, stackTrace) {
      log(
        'Failed to remove incomplete Firebase Auth account.',
        name: 'AuthenticationRepository',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _createUserProfile({
    required User user,
    required String firstName,
    required String lastName,
    required String fullName,
    required String email,
  }) => _firestoreDataSource.setDocument(
    collection: 'users',
    documentId: user.uid,
    data: {
      'id': user.uid,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'email': email,
      'type': UserType.provider.name,
      'selectedBusinessId': null,
      'createdAt': _firestoreDataSource.serverTimestamp,
    },
  );

  String _authErrorMessage(FirebaseAuthException error) {
    switch (error.code) {
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'invalid-email':
        return 'Enter a valid email address.';
      case 'weak-password':
        return 'Choose a stronger password.';
      case 'network-request-failed':
        return 'Check your internet connection and try again.';
      default:
        return error.message ?? 'We could not create your account.';
    }
  }

  String _signInErrorMessage(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-credential':
      case 'user-not-found':
      case 'wrong-password':
        return 'Incorrect email address or password.';
      case 'invalid-email':
        return 'Enter a valid email address.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Check your internet connection and try again.';
      default:
        return error.message ?? 'We could not sign you in.';
    }
  }

  bool _isValidEmail(String email) =>
      RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email);
}
