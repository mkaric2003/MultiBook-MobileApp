import 'package:aquabook/src/data/data_sources/service_search_data_source.dart';
import 'package:aquabook/src/data/models/service_search_result_model.dart';
import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_filters.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ServiceSearchRepository {
  ServiceSearchRepository(this._dataSource, this._businessRepository);

  final ServiceSearchDataSource _dataSource;
  final BusinessRepository _businessRepository;

  Future<ServiceSearchResultModel> search({
    required ServiceFilters filters,
    String? cursor,
  }) async {
    final page = await _dataSource.search(
      date: filters.date,
      timeMinutes: filters.timeMinutes,
      serviceName: filters.serviceName,
      city: filters.city,
      minPrice: filters.minPrice,
      maxPrice: filters.maxPrice,
      sortOption: filters.sortOption.name,
      cursor: cursor,
    );
    return ServiceSearchResultModel(
      services: page.items
          .map(_businessRepository.deserializeBusiness)
          .toList(),
      nextCursor: page.nextCursor,
    );
  }
}
