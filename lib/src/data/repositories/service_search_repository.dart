import 'package:multibook/src/data/data_sources/service_search_data_source.dart';
import 'package:multibook/src/data/models/service_search_result_model.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_filters.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ServiceSearchRepository {
  ServiceSearchRepository(this._dataSource);

  final ServiceSearchDataSource _dataSource;

  Future<ServiceSearchResultModel> search({
    required ServiceFilters filters,
    String? cursor,
  }) async {
    final page = await _dataSource.search(
      date: filters.date,
      timeMinutes: filters.timeMinutes,
      categoryId: filters.categoryId,
      collectionId: filters.collectionId,
      city: filters.city,
      minPrice: filters.minPrice,
      maxPrice: filters.maxPrice,
      sortOption: filters.sortOption.name,
      cursor: cursor,
    );
    return ServiceSearchResultModel(
      services: page.items.map(BusinessModel.fromMap).toList(),
      nextCursor: page.nextCursor,
    );
  }
}
