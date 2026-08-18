import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class DataCursor<T> {
  DataCursor(this._query, this._listSerializer);

  bool isLoading = false;
  bool isEverythingLoaded = false;

  final Query<Map<String, dynamic>> _query;
  final FutureOr<List<T>> Function(List<Map<String, dynamic>> documents)
  _listSerializer;
  DocumentSnapshot? _lastVisible;

  Future<List<T>> fetchNextPage() async {
    if (isLoading || isEverythingLoaded) {
      return const [];
    }

    isLoading = true;
    final nextQuery = _lastVisible == null
        ? _query
        : _query.startAfterDocument(_lastVisible!);

    try {
      final response = await nextQuery.get();
      if (response.docs.isEmpty) {
        isEverythingLoaded = true;
        return const [];
      }

      _lastVisible = response.docs.last;
      return _listSerializer(
        response.docs.map((document) => document.data()).toList(),
      );
    } finally {
      isLoading = false;
    }
  }
}
