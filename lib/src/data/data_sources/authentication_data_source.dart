import 'package:multibook/src/core/config/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

abstract class AuthenticationDataSource {
  User? get currentUser;

  /// Emits whenever Firebase Auth changes its authenticated user.
  ///
  /// The app router listens to this stream so protected screens are removed
  /// before their Firestore listeners can outlive an authenticated session.
  Stream<User?> get authStateChanges;

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserCredential> signInWithGoogle();

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> sendPasswordResetEmail({required String email});

  Future<void> reauthenticateAndUpdatePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<void> updateDisplayName({
    required User user,
    required String displayName,
  });

  Future<void> deleteUser(User user);

  Future<void> signOut();
}

@LazySingleton(as: AuthenticationDataSource)
class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  AuthenticationDataSourceImpl(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;
  late final Future<void> _googleSignInInitialization = GoogleSignIn.instance
      .initialize(serverClientId: AppConfig.googleServerClientId);

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) {
      throw FirebaseAuthException(
        code: 'user-creation-failed',
        message: 'Unable to create your account. Please try again.',
      );
    }

    return credential.user!;
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      return _firebaseAuth.signInWithPopup(GoogleAuthProvider());
    }

    await _googleSignInInitialization;
    final googleUser = await GoogleSignIn.instance.authenticate();
    final credential = GoogleAuthProvider.credential(
      idToken: googleUser.authentication.idToken,
    );

    return _firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) => _firebaseAuth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  @override
  Future<void> sendPasswordResetEmail({required String email}) =>
      _firebaseAuth.sendPasswordResetEmail(email: email);

  @override
  Future<void> reauthenticateAndUpdatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _firebaseAuth.currentUser;
    final email = user?.email;
    final supportsPassword =
        user?.providerData.any(
          (provider) => provider.providerId == EmailAuthProvider.PROVIDER_ID,
        ) ??
        false;
    if (user == null || email == null || !supportsPassword) {
      throw FirebaseAuthException(
        code: 'password-change-not-supported',
        message: 'Password changes are available for email/password accounts.',
      );
    }
    final credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);
  }

  @override
  Future<void> updateDisplayName({
    required User user,
    required String displayName,
  }) => user.updateDisplayName(displayName);

  @override
  Future<void> deleteUser(User user) => user.delete();

  @override
  Future<void> signOut() => _firebaseAuth.signOut();
}
