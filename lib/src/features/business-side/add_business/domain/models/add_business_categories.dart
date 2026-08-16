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
      id: 'salon',
      name: 'Salon',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'clinic',
      name: 'Clinic',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'professional_service',
      name: 'Professional service',
      type: BusinessType.services,
    ),
  ];

  static List<BusinessCategoryModel> forType(BusinessType type) =>
      all.where((category) => category.type == type).toList();
}
