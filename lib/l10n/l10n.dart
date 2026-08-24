import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'app_localizations.dart';
import '../src/core/injectable/injectable.dart';
import '../src/data/enums/currency_code.dart';
import '../src/data/enums/stay_amenity.dart';
import '../src/data/enums/stay_collection.dart';
import '../src/data/enums/stay_extra_type.dart';
import '../src/features/shared/localization/cubit/locale_cubit.dart';
import '../src/features/customer-side/help_center/domain/enums/help_article_id.dart';
import '../src/features/customer-side/help_center/domain/enums/help_center_topic.dart';

extension L10nBuildContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension CurrencyL10n on AppLocalizations {
  CurrencyCode get _currency => getIt<LocaleCubit>().state.currency;

  String get currencySymbol => _currency.symbol;

  String formatCurrency(num amount) {
    final hasFraction = amount % 100 != 0;
    final numberFormat = NumberFormat.decimalPattern(localeName)
      ..minimumFractionDigits = hasFraction ? 2 : 0
      ..maximumFractionDigits = hasFraction ? 2 : 0;
    final formattedAmount = numberFormat.format(amount / 100);

    return _currency == CurrencyCode.usd
        ? '${_currency.symbol}$formattedAmount'
        : '$formattedAmount${_currency.symbol}';
  }
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

extension StayExtraTypeL10n on AppLocalizations {
  String stayExtra(StayExtraType extra) => switch (extra) {
    StayExtraType.breakfast => extraBreakfast,
    StayExtraType.parking => extraParking,
    StayExtraType.spaAccess => extraSpaAccess,
    StayExtraType.airportTransfer => extraAirportTransfer,
    StayExtraType.lateCheckout => extraLateCheckout,
    StayExtraType.petStay => extraPetStay,
    StayExtraType.extraBed => extraBed,
    StayExtraType.laundryService => extraLaundryService,
    StayExtraType.quadBikeRental => extraQuadBikeRental,
    StayExtraType.guidedTour => extraGuidedTour,
    StayExtraType.hikingGuide => extraHikingGuide,
    StayExtraType.boatTour => extraBoatTour,
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

extension HelpCenterL10n on AppLocalizations {
  String helpTopicTitle(HelpCenterTopic topic) => switch (topic) {
    HelpCenterTopic.stays => helpTopicStays,
    HelpCenterTopic.appointments => helpTopicAppointments,
    HelpCenterTopic.changesAndCancellations => helpTopicChanges,
    HelpCenterTopic.payments => helpTopicPayments,
    HelpCenterTopic.accountAndPrivacy => helpTopicAccount,
    HelpCenterTopic.messagesAndNotifications => helpTopicMessages,
    HelpCenterTopic.technicalSupport => helpTopicTechnical,
    HelpCenterTopic.safetyAndSupport => helpTopicSafety,
  };

  String helpArticleTitle(HelpArticleId article) => switch (article) {
    HelpArticleId.findingAndBookingStay => helpFindingBookingStayTitle,
    HelpArticleId.stayDatesGuestsAndRooms => helpStayDatesRoomsTitle,
    HelpArticleId.bookingAndAppointmentStatuses => helpStatusesTitle,
    HelpArticleId.reschedulingAndCancelling => helpChangesTitle,
    HelpArticleId.paymentsCashAndNoShows => helpCashNoShowTitle,
    HelpArticleId.paymentSecurityAndReceipts => helpPaymentSecurityTitle,
    HelpArticleId.profileAndPersonalData => helpProfileDataTitle,
    HelpArticleId.messagesNotificationsAndSupport => helpMessagesTitle,
    HelpArticleId.locationAndSearch => helpLocationSearchTitle,
    HelpArticleId.reportingAndStayingSafe => helpSafetyTitle,
  };

  String helpArticleSummary(HelpArticleId article) => switch (article) {
    HelpArticleId.findingAndBookingStay => helpFindingBookingStaySummary,
    HelpArticleId.stayDatesGuestsAndRooms => helpStayDatesRoomsSummary,
    HelpArticleId.bookingAndAppointmentStatuses => helpStatusesSummary,
    HelpArticleId.reschedulingAndCancelling => helpChangesSummary,
    HelpArticleId.paymentsCashAndNoShows => helpCashNoShowSummary,
    HelpArticleId.paymentSecurityAndReceipts => helpPaymentSecuritySummary,
    HelpArticleId.profileAndPersonalData => helpProfileDataSummary,
    HelpArticleId.messagesNotificationsAndSupport => helpMessagesSummary,
    HelpArticleId.locationAndSearch => helpLocationSearchSummary,
    HelpArticleId.reportingAndStayingSafe => helpSafetySummary,
  };

  String helpArticleBody(HelpArticleId article) => switch (article) {
    HelpArticleId.findingAndBookingStay => helpFindingBookingStayBody,
    HelpArticleId.stayDatesGuestsAndRooms => helpStayDatesRoomsBody,
    HelpArticleId.bookingAndAppointmentStatuses => helpStatusesBody,
    HelpArticleId.reschedulingAndCancelling => helpChangesBody,
    HelpArticleId.paymentsCashAndNoShows => helpCashNoShowBody,
    HelpArticleId.paymentSecurityAndReceipts => helpPaymentSecurityBody,
    HelpArticleId.profileAndPersonalData => helpProfileDataBody,
    HelpArticleId.messagesNotificationsAndSupport => helpMessagesBody,
    HelpArticleId.locationAndSearch => helpLocationSearchBody,
    HelpArticleId.reportingAndStayingSafe => helpSafetyBody,
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
