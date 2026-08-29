import 'package:multibook/src/data/data_sources/authentication_data_source.dart';
import 'package:multibook/src/data/data_sources/firestore_data_source.dart';
import 'package:multibook/src/features/customer-side/payment_methods/domain/enums/saved_card_brand.dart';
import 'package:multibook/src/features/customer-side/payment_methods/domain/models/saved_payment_method_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PaymentMethodsRepository {
  PaymentMethodsRepository(this._auth, this._firestore);

  final AuthenticationDataSource _auth;
  final FirestoreDataSource _firestore;

  String get _userId => _auth.currentUser!.uid;
  String get _collection => 'users/$_userId/payment_methods';

  Stream<List<SavedPaymentMethodModel>> watch() => _firestore
      .watchDocumentsOrdered(
        collection: _collection,
        orderBy: 'createdAt',
        descending: true,
      )
      .map((items) => items.map(_map).toList());

  Future<void> save({
    required String cardNumber,
    required String expiry,
    required String holderName,
  }) async {
    final digits = cardNumber.replaceAll(RegExp(r'\D'), '');
    final expiryParts = expiry.split('/');
    final id = _firestore.createDocumentId(collection: _collection);
    final existing = await _firestore.getDocumentsWhere(
      collection: _collection,
      field: 'userId',
      value: _userId,
    );
    await _firestore.setDocument(
      collection: _collection,
      documentId: id,
      data: {
        'id': id,
        'userId': _userId,
        'brand': _brand(digits).name,
        'last4': digits.substring(digits.length - 4),
        'expiryMonth': int.parse(expiryParts.first),
        'expiryYear': 2000 + int.parse(expiryParts.last),
        'holderName': holderName.trim(),
        'isDefault': existing.isEmpty,
        'createdAt': _firestore.serverTimestamp,
      },
    );
  }

  Future<void> delete(String id) =>
      _firestore.deleteDocument(collection: _collection, documentId: id);

  Future<void> setDefault(SavedPaymentMethodModel method) async {
    final methods = await _firestore.getDocumentsWhere(
      collection: _collection,
      field: 'userId',
      value: _userId,
    );
    await Future.wait(
      methods.map(
        (item) => _firestore.updateDocument(
          collection: _collection,
          documentId: item['id'] as String,
          data: {'isDefault': item['id'] == method.id},
        ),
      ),
    );
  }

  SavedPaymentMethodModel _map(Map<String, dynamic> map) {
    final normalized = Map<String, dynamic>.from(map);
    if (normalized['createdAt'] is Timestamp) {
      normalized['createdAt'] =
          (normalized['createdAt'] as Timestamp).millisecondsSinceEpoch;
    }
    return SavedPaymentMethodModelMapper.fromMap(normalized);
  }

  SavedCardBrand _brand(String number) => number.startsWith('4')
      ? SavedCardBrand.visa
      : number.startsWith(RegExp(r'5[1-5]'))
      ? SavedCardBrand.mastercard
      : number.startsWith(RegExp(r'3[47]'))
      ? SavedCardBrand.amex
      : SavedCardBrand.other;
}
