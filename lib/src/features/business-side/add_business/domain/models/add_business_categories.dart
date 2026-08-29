import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/business_category_model.dart';

abstract final class AddBusinessCategories {
  static const all = <BusinessCategoryModel>[
    BusinessCategoryModel(id: 'hotel', name: 'Hotel', type: BusinessType.stays),
    BusinessCategoryModel(
      id: 'apartment',
      name: 'Apartment',
      type: BusinessType.stays,
    ),
    BusinessCategoryModel(id: 'cabin', name: 'Cabin', type: BusinessType.stays),
    BusinessCategoryModel(id: 'villa', name: 'Villa', type: BusinessType.stays),
    BusinessCategoryModel(
      id: 'beach_villa',
      name: 'Beach villa',
      type: BusinessType.stays,
    ),
    BusinessCategoryModel(
      id: 'mountain_cabin',
      name: 'Mountain cabin',
      type: BusinessType.stays,
    ),
    BusinessCategoryModel(
      id: 'cottage',
      name: 'Cottage / weekend house',
      type: BusinessType.stays,
    ),
    BusinessCategoryModel(
      id: 'pool_villa',
      name: 'Pool villa',
      type: BusinessType.stays,
    ),
    BusinessCategoryModel(
      id: 'resort',
      name: 'Resort',
      type: BusinessType.stays,
    ),
    BusinessCategoryModel(
      id: 'guesthouse',
      name: 'Guesthouse',
      type: BusinessType.stays,
    ),
    BusinessCategoryModel(
      id: 'hostel',
      name: 'Hostel',
      type: BusinessType.stays,
    ),
    BusinessCategoryModel(
      id: 'aparthotel',
      name: 'Aparthotel',
      type: BusinessType.stays,
    ),
    BusinessCategoryModel(
      id: 'glamping',
      name: 'Glamping',
      type: BusinessType.stays,
    ),
    BusinessCategoryModel(
      id: 'vacation_home',
      name: 'Vacation home',
      type: BusinessType.stays,
    ),
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
      id: 'massage_therapy',
      name: 'Massage therapy',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'spa_wellness',
      name: 'Spa & wellness',
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
      id: 'car_wash_detailing',
      name: 'Car wash & detailing',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'tattoo_piercing',
      name: 'Tattoo & piercing studio',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'veterinary_pet_care',
      name: 'Veterinary & pet care',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'photography_videography',
      name: 'Photography & videography',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'locksmith',
      name: 'Locksmith',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'hvac_service',
      name: 'Heating & air conditioning',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'painter_decorator',
      name: 'Painter & decorator',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'legal_consultation',
      name: 'Legal consultation',
      type: BusinessType.services,
    ),
    BusinessCategoryModel(
      id: 'accounting_consultation',
      name: 'Accounting consultation',
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
