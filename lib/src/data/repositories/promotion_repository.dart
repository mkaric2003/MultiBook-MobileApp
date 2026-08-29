import 'package:multibook/src/data/data_sources/authentication_data_source.dart';
import 'package:multibook/src/data/data_sources/firestore_data_source.dart';
import 'package:multibook/src/features/business-side/promotions/domain/enums/promotion_type.dart';
import 'package:multibook/src/features/business-side/promotions/domain/models/promotion_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PromotionRepository {
  PromotionRepository(this._auth, this._firestore);
  static const _collection = 'promotions';
  final AuthenticationDataSource _auth;
  final FirestoreDataSource _firestore;

  Stream<List<PromotionModel>> watchForBusiness(String businessId) => _firestore
      .watchDocumentsWhere(
        collection: _collection,
        field: 'businessId',
        value: businessId,
        orderBy: 'createdAt',
        descending: true,
      )
      .map((items) => items.map(_map).toList());

  Future<void> create({
    required String businessId,
    required String name,
    required PromotionType type,
    required int value,
    required DateTime startsAt,
    required DateTime endsAt,
    String? code,
    required int minimumAmount,
    required int minimumNights,
    int? usageLimit,
  }) async {
    final ownerId = _auth.currentUser!.uid;
    final id = _firestore.createDocumentId(collection: _collection);
    await _firestore.setDocument(
      collection: _collection,
      documentId: id,
      data: {
        'id': id,
        'businessId': businessId,
        'ownerId': ownerId,
        'name': name.trim(),
        'type': type.name,
        'value': value,
        'startsAt': Timestamp.fromDate(startsAt),
        'endsAt': Timestamp.fromDate(endsAt),
        'isActive': true,
        'code': (code?.trim().isEmpty ?? true) ? null : code!.trim(),
        'minimumAmount': minimumAmount,
        'minimumNights': minimumNights,
        'usageLimit': usageLimit,
        'usageCount': 0,
        'createdAt': _firestore.serverTimestamp,
      },
    );
    await _refreshBusinessPromotion(businessId);
  }

  Future<void> setActive(PromotionModel promotion, bool isActive) async {
    await _firestore.updateDocument(
      collection: _collection,
      documentId: promotion.id,
      data: {'isActive': isActive},
    );
    await _refreshBusinessPromotion(promotion.businessId);
  }

  Future<void> delete(PromotionModel promotion) async {
    await _firestore.deleteDocument(
      collection: _collection,
      documentId: promotion.id,
    );
    await _refreshBusinessPromotion(promotion.businessId);
  }

  Future<void> _refreshBusinessPromotion(String businessId) async {
    final now = DateTime.now();
    final promotions =
        (await _firestore.getDocumentsWhere(
              collection: _collection,
              field: 'businessId',
              value: businessId,
            ))
            .map(_map)
            .where(
              (promotion) =>
                  promotion.isActive &&
                  !promotion.startsAt.isAfter(now) &&
                  !promotion.endsAt.isBefore(now),
            )
            .toList()
          ..sort((a, b) => b.value.compareTo(a.value));
    await _firestore.updateDocument(
      collection: 'businesses',
      documentId: businessId,
      data: {'isPromotionActive': promotions.isNotEmpty},
    );
  }

  Future<PromotionModel?> getActiveForBusiness(
    String businessId, {
    String? promoCode,
  }) async {
    final now = DateTime.now();
    final promotions =
        (await _firestore.getDocumentsWhere(
              collection: _collection,
              field: 'businessId',
              value: businessId,
            ))
            .map(_map)
            .where(
              (promotion) =>
                  promotion.isActive &&
                  !promotion.startsAt.isAfter(now) &&
                  !promotion.endsAt.isBefore(now),
            )
            .toList()
          ..sort((a, b) => b.value.compareTo(a.value));
    final automatic = promotions
        .where((promotion) => promotion.type != PromotionType.couponCode)
        .toList();
    final normalizedCode = promoCode?.trim().toUpperCase();
    final matchingCode = promotions
        .where(
          (promotion) =>
              promotion.type == PromotionType.couponCode &&
              promotion.code?.toUpperCase() == normalizedCode,
        )
        .toList();
    if (normalizedCode?.isNotEmpty == true) {
      return matchingCode.isEmpty ? null : matchingCode.first;
    }
    return automatic.isEmpty ? null : automatic.first;
  }

  PromotionModel _map(Map<String, dynamic> item) {
    final map = Map<String, dynamic>.from(item);
    for (final key in ['startsAt', 'endsAt', 'createdAt']) {
      if (map[key] is Timestamp) {
        map[key] = (map[key] as Timestamp).millisecondsSinceEpoch;
      }
    }
    return PromotionModelMapper.fromMap(map);
  }
}
