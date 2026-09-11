import 'dart:developer';

import 'package:multibook/src/data/data_sources/stay_search_data_source.dart';
import 'package:multibook/src/data/models/stay_search_page_model.dart';
import 'package:multibook/src/data/models/stay_search_result_model.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_filters.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class StaySearchRepository {
  StaySearchRepository(this._dataSource);

  final StaySearchDataSource _dataSource;

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
        categoryIds: filters.categoryIds,
        collectionIds: filters.collectionIds,
        amenities: filters.amenities.map((amenity) => amenity.name).toList(),
        inventoryType: filters.inventoryType?.name,
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
        stays: page.items.map(BusinessModel.fromMap).toList(),
        nextCursor: page.nextCursor,
      );
}
