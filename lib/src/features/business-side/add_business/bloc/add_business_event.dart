import 'package:aquabook/src/data/enums/business_type.dart';
import 'package:aquabook/src/data/enums/stay_amenity.dart';
import 'package:aquabook/src/data/enums/stay_extra_type.dart';
import 'package:aquabook/src/data/models/stay_room_model.dart';
import 'package:aquabook/src/data/models/stay_extra_model.dart';
import 'package:aquabook/src/data/models/service_availability_slot_model.dart';
import 'package:aquabook/src/data/models/service_offering_model.dart';
import 'package:aquabook/src/features/business-side/add_business/domain/enums/business_image_type.dart';
import 'package:image_picker/image_picker.dart';

sealed class AddBusinessEvent {
  const AddBusinessEvent();
}

class BusinessTypeChanged extends AddBusinessEvent {
  const BusinessTypeChanged(this.type);

  final BusinessType type;
}

class BusinessCategoryChanged extends AddBusinessEvent {
  const BusinessCategoryChanged(this.categoryId);

  final String? categoryId;
}

class BusinessAmenityToggled extends AddBusinessEvent {
  const BusinessAmenityToggled(this.amenity);

  final StayAmenity amenity;
}

class BusinessExtraToggled extends AddBusinessEvent {
  const BusinessExtraToggled(this.extra);
  final StayExtraType extra;
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
}
