import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/repositories/businesses_repository.dart';

@lazySingleton
class GetOwnedBusinessesUseCase {
  GetOwnedBusinessesUseCase(this._repository);

  final BusinessesRepository _repository;
  Result<List<BusinessModel>>? _cachedResult;
  Future<Result<List<BusinessModel>>>? _pendingRequest;

  Future<Result<List<BusinessModel>>> execute({bool forceRefresh = false}) {
    if (!forceRefresh) {
      final cachedResult = _cachedResult;
      if (cachedResult != null) return Future.value(cachedResult);
      final pendingRequest = _pendingRequest;
      if (pendingRequest != null) return pendingRequest;
    }
    final request = _repository.getOwnedBusinesses();
    _pendingRequest = request;
    return request
        .then((result) {
          _cachedResult = result;
          return result;
        })
        .whenComplete(() {
          if (identical(_pendingRequest, request)) _pendingRequest = null;
        });
  }

  void invalidate() => _cachedResult = null;
}
