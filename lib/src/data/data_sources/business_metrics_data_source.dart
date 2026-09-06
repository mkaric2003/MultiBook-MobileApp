import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

abstract class BusinessMetricsDataSource {
  Future<void> initialize(String businessId);

  Stream<List<Map<String, dynamic>>> watchMonths({
    required String businessId,
    required String startMonthKey,
    required String endMonthKey,
  });

  Stream<List<Map<String, dynamic>>> watchProviderMonths({
    required String businessId,
    required String providerId,
    required String startMonthKey,
    required String endMonthKey,
  });
}

@LazySingleton(as: BusinessMetricsDataSource)
class BusinessMetricsDataSourceImpl implements BusinessMetricsDataSource {
  BusinessMetricsDataSourceImpl(this._firestore, this._functions);

  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;

  @override
  Future<void> initialize(String businessId) async {
    final summary = await _firestore
        .collection('business_metrics')
        .doc(businessId)
        .get();
    if (summary.exists && summary.data()?['metricsVersion'] == 4) {
      final now = DateTime.now();
      final monthKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';
      final currentMonth = await _firestore
          .collection('business_metrics')
          .doc(businessId)
          .collection('months')
          .doc(monthKey)
          .get();
      final data = currentMonth.data();
      if (data == null ||
          (data['onlineEarnings'] is num && data['cashEarnings'] is num)) {
        return;
      }
    }
    await _functions.httpsCallable('initializeBusinessMetrics').call({
      'businessId': businessId,
    });
  }

  @override
  Stream<List<Map<String, dynamic>>> watchMonths({
    required String businessId,
    required String startMonthKey,
    required String endMonthKey,
  }) => _firestore
      .collection('business_metrics')
      .doc(businessId)
      .collection('months')
      .orderBy(FieldPath.documentId)
      .startAt([startMonthKey])
      .endAt([endMonthKey])
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.map((document) => document.data()).toList(),
      );

  @override
  Stream<List<Map<String, dynamic>>> watchProviderMonths({
    required String businessId,
    required String providerId,
    required String startMonthKey,
    required String endMonthKey,
  }) => _firestore
      .collection('business_metrics')
      .doc(businessId)
      .collection('providers')
      .doc(providerId)
      .collection('months')
      .orderBy(FieldPath.documentId)
      .startAt([startMonthKey])
      .endAt([endMonthKey])
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.map((document) => document.data()).toList(),
      );
}
