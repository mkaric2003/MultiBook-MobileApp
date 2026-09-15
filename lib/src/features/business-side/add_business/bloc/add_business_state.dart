import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/enums/stay_amenity.dart';
import 'package:multibook/src/data/enums/stay_extra_type.dart';
import 'package:multibook/src/data/enums/stay_inventory_type.dart';
import 'package:multibook/src/data/models/service_availability_slot_model.dart';
import 'package:multibook/src/data/models/service_offering_model.dart';
import 'package:multibook/src/data/models/service_provider_model.dart';
import 'package:multibook/src/data/models/stay_room_model.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'add_business_state.mapper.dart';

@MappableClass()
class AddBusinessState with AddBusinessStateMappable {
  const AddBusinessState({
    this.businessType = BusinessType.stays,
    this.categoryId,
    this.stayInventoryType = StayInventoryType.singleUnit,
    this.selectedAmenities = const [],
    this.selectedCollectionIds = const [],
    this.selectedExtras = const [],
    this.extraPrices = const {},
    this.serviceOfferings = const [],
    this.availabilitySlots = const [],
    this.serviceProviders = const [],
    this.stayRooms = const [],
    this.editingBusiness,
    this.latitude,
    this.longitude,
    this.resolvedCity,
    this.resolvedAddress,
    this.isResolvingLocation = false,
    this.logoPath,
    this.coverPhotoPath,
    this.businessPhotoPaths = const [],
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.successMessage,
    this.hasExistingBusiness = false,
    this.isCheckingExistingBusiness = true,
  });

  final BusinessType businessType;
  final String? categoryId;
  final StayInventoryType stayInventoryType;
  final List<StayAmenity> selectedAmenities;
  final List<String> selectedCollectionIds;
  final List<StayExtraType> selectedExtras;
  final Map<String, int> extraPrices;
  final List<ServiceOfferingModel> serviceOfferings;
  final List<ServiceAvailabilitySlotModel> availabilitySlots;
  final List<ServiceProviderModel> serviceProviders;
  final List<StayRoomModel> stayRooms;
  final BusinessModel? editingBusiness;
  final double? latitude;
  final double? longitude;
  final String? resolvedCity;
  final String? resolvedAddress;
  final bool isResolvingLocation;
  final String? logoPath;
  final String? coverPhotoPath;
  final List<String> businessPhotoPaths;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? successMessage;
  final bool hasExistingBusiness;
  final bool isCheckingExistingBusiness;

  bool get isEditing => editingBusiness != null;
}
