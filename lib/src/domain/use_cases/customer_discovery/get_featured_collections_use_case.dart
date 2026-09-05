import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/featured_collection_model.dart';
import 'package:multibook/src/domain/repositories/customer_discovery_repository.dart';

@injectable
class GetFeaturedCollectionsUseCase {
  GetFeaturedCollectionsUseCase(this._repository);
  final CustomerDiscoveryRepository _repository;

  Future<Result<List<FeaturedCollectionModel>>> execute(BusinessType type) =>
      _repository.listFeaturedCollections(type);
}
