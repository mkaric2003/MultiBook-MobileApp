import 'package:aquabook/src/data/enums/business_type.dart';
import 'package:aquabook/src/data/enums/stay_amenity.dart';
import 'package:aquabook/src/data/enums/stay_extra_type.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'add_business_state.mapper.dart';

@MappableClass()
class AddBusinessState with AddBusinessStateMappable {
  const AddBusinessState({
    this.businessType = BusinessType.stays,
    this.categoryId,
    this.selectedAmenities = const [],
    this.selectedExtras = const [],
    this.latitude,
    this.longitude,
    this.resolvedCity,
    this.resolvedAddress,
    this.isResolvingLocation = false,
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
  final List<StayExtraType> selectedExtras;
  final double? latitude;
  final double? longitude;
  final String? resolvedCity;
  final String? resolvedAddress;
  final bool isResolvingLocation;
  final String? logoPath;
  final String? coverPhotoPath;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? successMessage;
  final bool hasExistingBusiness;
}
