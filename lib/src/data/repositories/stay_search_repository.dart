import 'dart:developer';

import 'package:aquabook/src/data/data_sources/stay_search_data_source.dart';
import 'package:aquabook/src/data/models/stay_search_page_model.dart';
import 'package:aquabook/src/data/models/stay_search_result_model.dart';
import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_filters.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class StaySearchRepository {
  StaySearchRepository(this._dataSource, this._businessRepository);

  final StaySearchDataSource _dataSource;
  final BusinessRepository _businessRepository;

  Future<StaySearchResultModel> search({
    required StayFilters filters,
    String? cursor,
  }) async {
    try {
      final page = await _dataSource.search(
        city: filters.city,
        checkIn: filters.checkIn,
        checkOut: filters.checkOut,
        adults: filters.adults,
        children: filters.children,
        minPrice: filters.minPrice,
        maxPrice: filters.maxPrice,
        minimumRating: filters.minimumRating,
        cursor: cursor,
      );
      return _mapPage(page);
    } catch (error, stackTrace) {
      log(
        'Could not search stays through the endpoint.',
        name: 'StaySearchRepository',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  StaySearchResultModel _mapPage(StaySearchPageModel page) =>
      StaySearchResultModel(
        stays: page.items.map(_businessRepository.deserializeBusiness).toList(),
        nextCursor: page.nextCursor,
      );
}
