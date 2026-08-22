import 'package:flutter/widgets.dart';

import 'app_localizations.dart';
import '../src/data/enums/stay_amenity.dart';
import '../src/data/enums/stay_collection.dart';

extension L10nBuildContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension StayAmenityL10n on AppLocalizations {
  String stayAmenity(StayAmenity amenity) => switch (amenity) {
    StayAmenity.wifi => amenityWifi,
    StayAmenity.parking => amenityParking,
    StayAmenity.pool => amenityPool,
    StayAmenity.spa => amenitySpa,
    StayAmenity.petFriendly => amenityPetFriendly,
    StayAmenity.gym => amenityGym,
    StayAmenity.airConditioning => amenityAirConditioning,
    StayAmenity.heating => amenityHeating,
    StayAmenity.kitchen => amenityKitchen,
    StayAmenity.washer => amenityWasher,
    StayAmenity.balcony => amenityBalcony,
    StayAmenity.seaView => amenitySeaView,
    StayAmenity.mountainView => amenityMountainView,
    StayAmenity.workspace => amenityWorkspace,
    StayAmenity.elevator => amenityElevator,
    StayAmenity.skiInSkiOut => amenitySkiInSkiOut,
    StayAmenity.skiStorage => amenitySkiStorage,
    StayAmenity.skiRental => amenitySkiRental,
    StayAmenity.skiShuttle => amenitySkiShuttle,
  };
}

extension BusinessCategoryL10n on AppLocalizations {
  String businessCategoryName(String id) => switch (id) {
    'hotel' => categoryHotel,
    'apartment' => categoryApartment,
    'villa' => categoryVilla,
    'beach_villa' => categoryBeachVilla,
    'pool_villa' => categoryPoolVilla,
    'cabin' => categoryCabin,
    'mountain_cabin' => categoryMountainCabin,
    'cottage' => categoryCottage,
    'resort' => categoryResort,
    'guesthouse' => categoryGuesthouse,
    'hostel' => categoryHostel,
    'aparthotel' => categoryAparthotel,
    'glamping' => categoryGlamping,
    'vacation_home' => categoryVacationHome,
    'hair_salon' => categoryHairSalon,
    'barbershop' => categoryBarbershop,
    'beauty_salon' => categoryBeautySalon,
    'nail_salon' => categoryNailSalon,
    'dental_clinic' => categoryDentalClinic,
    'medical_clinic' => categoryMedicalClinic,
    'physiotherapy' => categoryPhysiotherapy,
    'massage_spa' => categoryMassageSpa,
    'massage_therapy' => categoryMassageTherapy,
    'spa_wellness' => categorySpaWellness,
    'personal_training' => categoryPersonalTraining,
    'tutoring' => categoryTutoring,
    'electrician' => categoryElectrician,
    'plumber' => categoryPlumber,
    'cleaning_service' => categoryCleaningService,
    'automotive_service' => categoryAutomotiveService,
    'car_wash_detailing' => categoryCarWashDetailing,
    'tattoo_piercing' => categoryTattooPiercing,
    'veterinary_pet_care' => categoryVeterinaryPetCare,
    'photography_videography' => categoryPhotographyVideography,
    'locksmith' => categoryLocksmith,
    'hvac_service' => categoryHvacService,
    'painter_decorator' => categoryPainterDecorator,
    'legal_consultation' => categoryLegalConsultation,
    'accounting_consultation' => categoryAccountingConsultation,
    'professional_service' => categoryProfessionalService,
    _ => id,
  };
}

extension StayCollectionL10n on AppLocalizations {
  String stayCollectionName(StayCollection collection) => switch (collection) {
    StayCollection.romanticGetaways => romanticGetaways,
    StayCollection.familyFriendly => familyFriendly,
    StayCollection.weekendEscapes => weekendEscapes,
    StayCollection.beachfrontStays => beachfrontStays,
    StayCollection.petFriendly => petFriendlyStays,
    StayCollection.poolStays => poolStays,
    StayCollection.mountainEscapes => mountainEscapes,
    StayCollection.cityBreaks => cityBreaks,
  };
}
