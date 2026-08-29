import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/enums/stay_amenity.dart';
import 'package:multibook/src/data/enums/stay_extra_type.dart';
import 'package:multibook/src/data/enums/stay_inventory_type.dart';
import 'package:multibook/src/data/enums/stay_collection.dart';
import 'package:multibook/src/data/models/stay_room_model.dart';
import 'package:multibook/src/data/models/stay_extra_model.dart';
import 'package:multibook/src/data/models/service_availability_slot_model.dart';
import 'package:multibook/src/data/models/service_offering_model.dart';
import 'package:multibook/src/data/models/service_provider_model.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/features/business-side/add_business/domain/enums/business_image_type.dart';
import 'package:image_picker/image_picker.dart';

sealed class AddBusinessEvent {
  const AddBusinessEvent();
}

class BusinessTypeChanged extends AddBusinessEvent {
  const BusinessTypeChanged(this.type);

  final BusinessType type;
}

class BusinessEditLoaded extends AddBusinessEvent {
  const BusinessEditLoaded(this.business);

  final BusinessModel business;
}

class StayRoomAdded extends AddBusinessEvent {
  const StayRoomAdded(this.room);

  final StayRoomModel room;
}

class StayRoomRemoved extends AddBusinessEvent {
  const StayRoomRemoved(this.roomId);

  final String roomId;
}

class StayRoomUpdated extends AddBusinessEvent {
  const StayRoomUpdated(this.room);

  final StayRoomModel room;
}

class BusinessCategoryChanged extends AddBusinessEvent {
  const BusinessCategoryChanged(this.categoryId);

  final String? categoryId;
}

class StayInventoryTypeChanged extends AddBusinessEvent {
  const StayInventoryTypeChanged(this.inventoryType);

  final StayInventoryType inventoryType;
}

class BusinessAmenityToggled extends AddBusinessEvent {
  const BusinessAmenityToggled(this.amenity);

  final StayAmenity amenity;
}

class StayCollectionToggled extends AddBusinessEvent {
  const StayCollectionToggled(this.collection);

  final StayCollection collection;
}

class BusinessExtraToggled extends AddBusinessEvent {
  const BusinessExtraToggled(this.extra);
  final StayExtraType extra;
}

class BusinessExtraPriceChanged extends AddBusinessEvent {
  const BusinessExtraPriceChanged({required this.extra, required this.price});

  final StayExtraType extra;
  final int price;
}

class ServiceOfferingAdded extends AddBusinessEvent {
  const ServiceOfferingAdded(this.offering);

  final ServiceOfferingModel offering;
}

class ServiceOfferingRemoved extends AddBusinessEvent {
  const ServiceOfferingRemoved(this.offeringId);

  final String offeringId;
}

class ServiceAvailabilitySlotAdded extends AddBusinessEvent {
  const ServiceAvailabilitySlotAdded(this.slot);

  final ServiceAvailabilitySlotModel slot;
}

class ServiceAvailabilitySlotRemoved extends AddBusinessEvent {
  const ServiceAvailabilitySlotRemoved(this.slotId);

  final String slotId;
}

class ServiceProviderAdded extends AddBusinessEvent {
  const ServiceProviderAdded(this.provider);

  final ServiceProviderModel provider;
}

class ServiceProviderRemoved extends AddBusinessEvent {
  const ServiceProviderRemoved(this.providerId);

  final String providerId;
}

class ServiceProviderAvailabilitySlotAdded extends AddBusinessEvent {
  const ServiceProviderAvailabilitySlotAdded({
    required this.providerId,
    required this.slot,
  });

  final String providerId;
  final ServiceAvailabilitySlotModel slot;
}

class ServiceProviderAvailabilitySlotRemoved extends AddBusinessEvent {
  const ServiceProviderAvailabilitySlotRemoved({
    required this.providerId,
    required this.slotId,
  });

  final String providerId;
  final String slotId;
}

class BusinessLocationChanged extends AddBusinessEvent {
  const BusinessLocationChanged({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;
}

class BusinessImagePickRequested extends AddBusinessEvent {
  const BusinessImagePickRequested({
    required this.imageType,
    required this.source,
  });

  final BusinessImageType imageType;
  final ImageSource source;
}

class BusinessPhotoRemoved extends AddBusinessEvent {
  const BusinessPhotoRemoved(this.imagePath);

  final String imagePath;
}

class LostBusinessImageRestoreRequested extends AddBusinessEvent {
  const LostBusinessImageRestoreRequested();
}

class ExistingBusinessesLoadRequested extends AddBusinessEvent {
  const ExistingBusinessesLoadRequested();
}

class DemoStaysSeedRequested extends AddBusinessEvent {
  const DemoStaysSeedRequested();
}

class DemoServicesSeedRequested extends AddBusinessEvent {
  const DemoServicesSeedRequested();
}

class BusinessCreationRequested extends AddBusinessEvent {
  const BusinessCreationRequested({
    required this.name,
    required this.city,
    required this.address,
    required this.shortDescription,
    this.pricePerNight,
    this.amenities = const [],
    this.rooms = const [],
    this.extras = const [],
    this.serviceOfferings = const [],
    this.availabilitySlots = const [],
    this.serviceProviderName,
    this.serviceProviders = const [],
  });

  final String name;
  final String city;
  final String address;
  final String shortDescription;
  final int? pricePerNight;
  final List<StayAmenity> amenities;
  final List<StayRoomModel> rooms;
  final List<StayExtraModel> extras;
  final List<ServiceOfferingModel> serviceOfferings;
  final List<ServiceAvailabilitySlotModel> availabilitySlots;
  final String? serviceProviderName;
  final List<ServiceProviderModel> serviceProviders;
}
