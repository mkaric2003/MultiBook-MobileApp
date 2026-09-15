import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_category_filter_option.dart';

abstract final class ServiceCategoryFilterOptions {
  static const all = <ServiceCategoryFilterOption>[
    ServiceCategoryFilterOption(id: 'hair_salon', label: 'Hair salon'),
    ServiceCategoryFilterOption(id: 'barbershop', label: 'Barbershop'),
    ServiceCategoryFilterOption(id: 'beauty_salon', label: 'Beauty salon'),
    ServiceCategoryFilterOption(
      id: 'nail_salon',
      label: 'Nail & pedicure salon',
    ),
    ServiceCategoryFilterOption(id: 'dental_clinic', label: 'Dental clinic'),
    ServiceCategoryFilterOption(id: 'medical_clinic', label: 'Medical clinic'),
    ServiceCategoryFilterOption(id: 'physiotherapy', label: 'Physiotherapy'),
    ServiceCategoryFilterOption(id: 'massage_spa', label: 'Massage & spa'),
    ServiceCategoryFilterOption(
      id: 'massage_therapy',
      label: 'Massage therapy',
    ),
    ServiceCategoryFilterOption(id: 'spa_wellness', label: 'Spa & wellness'),
    ServiceCategoryFilterOption(
      id: 'personal_training',
      label: 'Personal training',
    ),
    ServiceCategoryFilterOption(id: 'tutoring', label: 'Tutoring & lessons'),
    ServiceCategoryFilterOption(id: 'electrician', label: 'Electrician'),
    ServiceCategoryFilterOption(id: 'plumber', label: 'Plumber'),
    ServiceCategoryFilterOption(
      id: 'cleaning_service',
      label: 'Cleaning service',
    ),
    ServiceCategoryFilterOption(
      id: 'automotive_service',
      label: 'Automotive service',
    ),
    ServiceCategoryFilterOption(
      id: 'car_wash_detailing',
      label: 'Car wash & detailing',
    ),
    ServiceCategoryFilterOption(
      id: 'tattoo_piercing',
      label: 'Tattoo & piercing studio',
    ),
    ServiceCategoryFilterOption(
      id: 'veterinary_pet_care',
      label: 'Veterinary & pet care',
    ),
    ServiceCategoryFilterOption(
      id: 'photography_videography',
      label: 'Photography & videography',
    ),
    ServiceCategoryFilterOption(id: 'locksmith', label: 'Locksmith'),
    ServiceCategoryFilterOption(
      id: 'hvac_service',
      label: 'Heating & air conditioning',
    ),
    ServiceCategoryFilterOption(
      id: 'painter_decorator',
      label: 'Painter & decorator',
    ),
    ServiceCategoryFilterOption(
      id: 'legal_consultation',
      label: 'Legal consultation',
    ),
    ServiceCategoryFilterOption(
      id: 'accounting_consultation',
      label: 'Accounting consultation',
    ),
    ServiceCategoryFilterOption(
      id: 'professional_service',
      label: 'Professional services',
    ),
  ];

  static ServiceCategoryFilterOption? byId(String? id) {
    for (final category in all) {
      if (category.id == id) return category;
    }
    return null;
  }

  static ServiceCategoryFilterOption? byLabel(String label) {
    for (final category in all) {
      if (category.label == label) return category;
    }
    return null;
  }
}
