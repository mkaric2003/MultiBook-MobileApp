import 'package:aquabook/src/data/enums/business_type.dart';
import 'package:aquabook/src/data/enums/stay_amenity.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'add_business_state.mapper.dart';

@MappableClass()
class AddBusinessState with AddBusinessStateMappable {
  const AddBusinessState({
    this.businessType = BusinessType.stays,
    this.categoryId,
    this.selectedAmenities = const [],
    this.logoPath,
    this.coverPhotoPath,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.successMessage,
    this.hasExistingBusiness = false,
  });

  final BusinessType businessType;
  final String? categoryId;
  final List<StayAmenity> selectedAmenities;
  final String? logoPath;
  final String? coverPhotoPath;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? successMessage;
  final bool hasExistingBusiness;
}
