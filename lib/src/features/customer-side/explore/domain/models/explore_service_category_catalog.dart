import 'package:multibook/src/features/customer-side/explore/domain/models/explore_service_category.dart';
import 'package:flutter/material.dart';

abstract final class ExploreServiceCategoryCatalog {
  static const primary = <ExploreServiceCategory>[
    ExploreServiceCategory(
      id: 'hair_salon',
      title: 'Hairdresser',
      icon: Icons.content_cut_rounded,
      color: Color(0xFFFFE5F1),
    ),
    ExploreServiceCategory(
      id: 'barbershop',
      title: 'Barber',
      icon: Icons.person_pin_rounded,
      color: Color(0xFFE4EEFF),
    ),
    ExploreServiceCategory(
      id: 'dental_clinic',
      title: 'Dentist',
      icon: Icons.medical_services_rounded,
      color: Color(0xFFE0F8E7),
    ),
    ExploreServiceCategory(
      id: 'automotive_service',
      title: 'Mechanic',
      icon: Icons.build_rounded,
      color: Color(0xFFFFECD7),
    ),
    ExploreServiceCategory(
      id: 'electrician',
      title: 'Electrician',
      icon: Icons.bolt_rounded,
      color: Color(0xFFFFF4BE),
    ),
    ExploreServiceCategory(
      id: 'massage_spa',
      title: 'Spa/Massage',
      icon: Icons.spa_rounded,
      color: Color(0xFFF2E7FF),
    ),
  ];

  static const additional = <ExploreServiceCategory>[
    ExploreServiceCategory(
      id: 'beauty_salon',
      title: 'Beauty salon',
      icon: Icons.face_retouching_natural_rounded,
      color: Color(0xFFFFE4EE),
    ),
    ExploreServiceCategory(
      id: 'nail_salon',
      title: 'Nail & pedicure',
      icon: Icons.brush_rounded,
      color: Color(0xFFFFE6DE),
    ),
    ExploreServiceCategory(
      id: 'massage_therapy',
      title: 'Massage',
      icon: Icons.self_improvement_rounded,
      color: Color(0xFFEDE0FF),
    ),
    ExploreServiceCategory(
      id: 'spa_wellness',
      title: 'Spa & wellness',
      icon: Icons.hot_tub_rounded,
      color: Color(0xFFDDF8F4),
    ),
    ExploreServiceCategory(
      id: 'physiotherapy',
      title: 'Physiotherapy',
      icon: Icons.accessibility_new_rounded,
      color: Color(0xFFE1F0FF),
    ),
    ExploreServiceCategory(
      id: 'personal_training',
      title: 'Personal trainer',
      icon: Icons.fitness_center_rounded,
      color: Color(0xFFFFEBC9),
    ),
    ExploreServiceCategory(
      id: 'tutoring',
      title: 'Lessons & tutoring',
      icon: Icons.menu_book_rounded,
      color: Color(0xFFE5ECFF),
    ),
    ExploreServiceCategory(
      id: 'plumber',
      title: 'Plumber',
      icon: Icons.plumbing_rounded,
      color: Color(0xFFDDF4FF),
    ),
    ExploreServiceCategory(
      id: 'cleaning_service',
      title: 'Cleaning service',
      icon: Icons.cleaning_services_rounded,
      color: Color(0xFFE3F8E7),
    ),
    ExploreServiceCategory(
      id: 'car_wash_detailing',
      title: 'Car wash & detailing',
      icon: Icons.local_car_wash_rounded,
      color: Color(0xFFDCEBFF),
    ),
    ExploreServiceCategory(
      id: 'tattoo_piercing',
      title: 'Tattoo & piercing',
      icon: Icons.draw_rounded,
      color: Color(0xFFF1E1FF),
    ),
    ExploreServiceCategory(
      id: 'veterinary_pet_care',
      title: 'Vet & pet care',
      icon: Icons.pets_rounded,
      color: Color(0xFFFFE8D4),
    ),
    ExploreServiceCategory(
      id: 'photography_videography',
      title: 'Photo & video',
      icon: Icons.photo_camera_rounded,
      color: Color(0xFFE4E7FF),
    ),
    ExploreServiceCategory(
      id: 'locksmith',
      title: 'Locksmith',
      icon: Icons.key_rounded,
      color: Color(0xFFFFF0C9),
    ),
    ExploreServiceCategory(
      id: 'hvac_service',
      title: 'Heating & cooling',
      icon: Icons.ac_unit_rounded,
      color: Color(0xFFDDF4F8),
    ),
    ExploreServiceCategory(
      id: 'painter_decorator',
      title: 'Painter & decorator',
      icon: Icons.format_paint_rounded,
      color: Color(0xFFFFE2EA),
    ),
    ExploreServiceCategory(
      id: 'legal_consultation',
      title: 'Legal consultation',
      icon: Icons.balance_rounded,
      color: Color(0xFFE8E4FF),
    ),
    ExploreServiceCategory(
      id: 'accounting_consultation',
      title: 'Accounting',
      icon: Icons.calculate_rounded,
      color: Color(0xFFE1F4E5),
    ),
    ExploreServiceCategory(
      id: 'medical_clinic',
      title: 'Medical clinic',
      icon: Icons.local_hospital_rounded,
      color: Color(0xFFFFE4E4),
    ),
    ExploreServiceCategory(
      id: 'professional_service',
      title: 'Professional services',
      icon: Icons.business_center_rounded,
      color: Color(0xFFE7E9EF),
    ),
  ];

  static const all = <ExploreServiceCategory>[...primary, ...additional];
}
