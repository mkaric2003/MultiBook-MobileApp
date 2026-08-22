import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

abstract class ReviewDataSource {
  Future<void> createReview({
    required String businessId,
    required String sourceId,
    required String type,
    required int rating,
    String? comment,
  });
}

@LazySingleton(as: ReviewDataSource)
class ReviewDataSourceImpl implements ReviewDataSource {
  ReviewDataSourceImpl(this._functions);

  final FirebaseFunctions _functions;

  @override
  Future<void> createReview({
    required String businessId,
    required String sourceId,
    required String type,
    required int rating,
    String? comment,
  }) async {
    try {
      await _functions.httpsCallable('createReview').call({
        'businessId': businessId,
        'sourceId': sourceId,
        'type': type,
        'rating': rating,
        'comment': comment,
      });
    } on FirebaseFunctionsException catch (error, stackTrace) {
      log(
        'Callable review creation failed: ${error.code}',
        name: 'ReviewDataSource',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
