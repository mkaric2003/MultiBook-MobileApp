import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/use_cases/businesses/get_owned_businesses_use_case.dart';

/// Resolves the provider's selected business entirely from REST data.
@injectable
class GetSelectedBusinessUseCase {
  GetSelectedBusinessUseCase(this._getOwnedBusinesses);

  final GetOwnedBusinessesUseCase _getOwnedBusinesses;

  Future<Result<BusinessModel?>> execute(String? selectedBusinessId) async {
    final result = await _getOwnedBusinesses.execute();
    return switch (result) {
      FailureResult() => FailureResult(result.failure),
      Success(value: final businesses) => Success(
        selectedBusinessId == null
            ? (businesses.isEmpty ? null : businesses.first)
            : businesses
                  .where((business) => business.id == selectedBusinessId)
                  .firstOrNull,
      ),
    };
  }
}
