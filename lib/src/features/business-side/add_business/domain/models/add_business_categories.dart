import 'package:aquabook/src/data/enums/business_type.dart';
import 'package:aquabook/src/data/models/business_category_model.dart';

abstract final class AddBusinessCategories {
  static const all = <BusinessCategoryModel>[
    BusinessCategoryModel(id: 'hotel', name: 'Hotel', type: BusinessType.stays),
    BusinessCategoryModel(
      id: 'apartment',
      name: 'Apartment',
      type: BusinessType.stays,
    ),
    BusinessCategoryModel(id: 'cabin', name: 'Cabin', type: BusinessType.stays),
    BusinessCategoryModel(
      id: 'hair_salon',
      name: 'Hair salon',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'barbershop',
      name: 'Barbershop',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'beauty_salon',
      name: 'Beauty salon',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'nail_salon',
      name: 'Nail & pedicure salon',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'dental_clinic',
      name: 'Dental clinic',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'medical_clinic',
      name: 'Medical clinic',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'physiotherapy',
      name: 'Physiotherapy',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'massage_spa',
      name: 'Massage & spa',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'personal_training',
      name: 'Personal training',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'tutoring',
      name: 'Tutoring & lessons',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'electrician',
      name: 'Electrician',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'plumber',
      name: 'Plumber',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'cleaning_service',
      name: 'Cleaning service',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'automotive_service',
      name: 'Automotive service',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'professional_service',
      name: 'Other professional service',
      type: BusinessType.services,
    ),
  ];

  static List<BusinessCategoryModel> forType(BusinessType type) =>
      all.where((category) => category.type == type).toList();
}
