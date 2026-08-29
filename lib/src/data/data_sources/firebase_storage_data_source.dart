import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

abstract class FirebaseStorageDataSource {
  Future<String> uploadImage({
    required String storagePath,
    required Uint8List imageBytes,
    required String contentType,
  });

  Future<void> deleteFile({required String storagePath});

  Future<void> deleteFileByUrl({required String downloadUrl});

  Future<String> getDownloadUrl({required String storagePath});
}

@LazySingleton(as: FirebaseStorageDataSource)
class FirebaseStorageDataSourceImpl implements FirebaseStorageDataSource {
  FirebaseStorageDataSourceImpl(this._storage);

  final FirebaseStorage _storage;

  @override
  Future<String> uploadImage({
    required String storagePath,
    required Uint8List imageBytes,
    required String contentType,
  }) async {
    final reference = _storage.ref(storagePath);

    await reference.putData(
      imageBytes,
      SettableMetadata(contentType: contentType),
    );

    return reference.getDownloadURL();
  }

  @override
  Future<void> deleteFile({required String storagePath}) =>
      _storage.ref(storagePath).delete();

  @override
  Future<void> deleteFileByUrl({required String downloadUrl}) =>
      _storage.refFromURL(downloadUrl).delete();

  @override
  Future<String> getDownloadUrl({required String storagePath}) =>
      _storage.ref(storagePath).getDownloadURL();
}
