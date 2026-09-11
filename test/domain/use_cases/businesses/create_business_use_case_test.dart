import 'package:flutter_test/flutter_test.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/enums/stay_amenity.dart';
import 'package:multibook/src/data/enums/stay_inventory_type.dart';
import 'package:multibook/src/data/models/business_location_model.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/models/stay_details_model.dart';
import 'package:multibook/src/domain/repositories/businesses_repository.dart';
import 'package:multibook/src/domain/use_cases/businesses/create_business_use_case.dart';

void main() {
  test('creates a business through the repository contract', () async {
    final repository = _FakeBusinessesRepository();
    final business = BusinessModel(
      id: 'client-draft-id',
      ownerId: 'provider-id',
      type: BusinessType.stays,
      name: 'Planinski dom',
      categoryId: 'chalet',
      location: const BusinessLocationModel(
        city: 'Sarajevo',
        address: 'Bjelašnica 1',
        latitude: 43.7,
        longitude: 18.2,
      ),
      stayDetails: const StayDetailsModel(
        inventoryType: StayInventoryType.singleUnit,
        amenities: [StayAmenity.wifi],
      ),
    );

    final result = await CreateBusinessUseCase(repository).execute(business);

    expect(repository.business, business);
    expect((result as Success<BusinessModel>).value.id, 'business-id');
  });
}

class _FakeBusinessesRepository implements BusinessesRepository {
  BusinessModel? business;

  @override
  Future<Result<BusinessModel>> createBusiness(BusinessModel business) async {
    this.business = business;
    return Success(business.copyWith(id: 'business-id'));
  }

  @override
  Future<Result<List<BusinessModel>>> getOwnedBusinesses() async =>
      const Success([]);

  @override
  Future<Result<BusinessModel>> getOwnedBusiness(String businessId) async =>
      Success(business!);

  @override
  Future<Result<BusinessModel>> updateBusiness(BusinessModel business) async =>
      Success(business);
}
