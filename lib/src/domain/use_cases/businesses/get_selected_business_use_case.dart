import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/use_cases/businesses/get_owned_business_use_case.dart';

/// Resolves the provider's selected business entirely from REST data.
@injectable
class GetSelectedBusinessUseCase {
  GetSelectedBusinessUseCase(this._getOwnedBusiness);

  final GetOwnedBusinessUseCase _getOwnedBusiness;

  Future<Result<BusinessModel?>> execute(String? selectedBusinessId) async {
    if (selectedBusinessId == null) {
      return const Success(null);
    }

    final result = await _getOwnedBusiness.execute(selectedBusinessId);
    return switch (result) {
      FailureResult() => FailureResult(result.failure),
      Success(value: final business) => Success(business),
    };
  }
}
