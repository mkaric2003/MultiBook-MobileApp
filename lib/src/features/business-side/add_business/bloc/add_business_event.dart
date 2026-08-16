import 'package:aquabook/src/data/enums/business_type.dart';
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

class BusinessCreationRequested extends AddBusinessEvent {
  const BusinessCreationRequested({
    required this.name,
    required this.address,
    required this.shortDescription,
    this.pricePerNight,
  });

  final String name;
  final String address;
  final String shortDescription;
  final int? pricePerNight;
}
