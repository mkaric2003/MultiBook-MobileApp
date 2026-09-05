import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/models/featured_collection_model.dart';

abstract class CustomerDiscoveryRepository {
  Future<Result<BusinessModel>> getBusinessDetail(String businessId);
  Future<Result<List<String>>> listCities();
  Future<Result<List<FeaturedCollectionModel>>> listFeaturedCollections(
    BusinessType type,
  );
  Future<Result<List<BusinessModel>>> recommendedStays();
  Future<Result<List<BusinessModel>>> listBusinesses({
    required BusinessType type,
    required int offset,
    int limit = 10,
  });
  Future<Result<List<BusinessModel>>> searchBusinesses({
    required BusinessType type,
    required String query,
    int limit = 20,
  });
  Future<Result<List<BusinessModel>>> popularNearCity({
    required BusinessType type,
    required String city,
    required int offset,
    int limit = 10,
  });
}
