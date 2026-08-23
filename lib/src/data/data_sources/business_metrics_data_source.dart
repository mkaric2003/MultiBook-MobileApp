import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

abstract class BusinessMetricsDataSource {
  Stream<Map<String, dynamic>?> watchSummary(String businessId);

  Future<void> initialize(String businessId);

  Stream<Map<String, dynamic>?> watchMonth({
    required String businessId,
    required String monthKey,
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
    if (summary.exists && summary.data()?['metricsVersion'] == 2) {
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
  Stream<Map<String, dynamic>?> watchSummary(String businessId) => _firestore
      .collection('business_metrics')
      .doc(businessId)
      .snapshots()
      .map((snapshot) => snapshot.data());

  @override
  Stream<Map<String, dynamic>?> watchMonth({
    required String businessId,
    required String monthKey,
  }) => _firestore
      .collection('business_metrics')
      .doc(businessId)
      .collection('months')
      .doc(monthKey)
      .snapshots()
      .map((snapshot) => snapshot.data());
}
