import 'package:multibook/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  @preResolve
  @Singleton(order: -1)
  Future<FirebaseApp> get firebaseApp async {
    final app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return app;
  }

  @singleton
  FirebaseAuth firebaseAuth(FirebaseApp app) => FirebaseAuth.instance;

  @singleton
  FirebaseStorage firebaseStorage(FirebaseApp app) => FirebaseStorage.instance;

  @singleton
  FirebaseFirestore firebaseFirestore(FirebaseApp app) =>
      FirebaseFirestore.instance;

  @singleton
  FirebaseMessaging firebaseMessaging(FirebaseApp app) =>
      FirebaseMessaging.instance;
}
