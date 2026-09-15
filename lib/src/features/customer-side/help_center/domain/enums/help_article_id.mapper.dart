// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'help_article_id.dart';

class HelpArticleIdMapper extends EnumMapper<HelpArticleId> {
  HelpArticleIdMapper._();

  static HelpArticleIdMapper? _instance;
  static HelpArticleIdMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HelpArticleIdMapper._());
    }
    return _instance!;
  }

  static HelpArticleId fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  HelpArticleId decode(dynamic value) {
    switch (value) {
      case r'findingAndBookingStay':
        return HelpArticleId.findingAndBookingStay;
      case r'stayDatesGuestsAndRooms':
        return HelpArticleId.stayDatesGuestsAndRooms;
      case r'bookingAndAppointmentStatuses':
        return HelpArticleId.bookingAndAppointmentStatuses;
      case r'reschedulingAndCancelling':
        return HelpArticleId.reschedulingAndCancelling;
      case r'paymentsCashAndNoShows':
        return HelpArticleId.paymentsCashAndNoShows;
      case r'paymentSecurityAndReceipts':
        return HelpArticleId.paymentSecurityAndReceipts;
      case r'profileAndPersonalData':
        return HelpArticleId.profileAndPersonalData;
      case r'messagesNotificationsAndSupport':
        return HelpArticleId.messagesNotificationsAndSupport;
      case r'locationAndSearch':
        return HelpArticleId.locationAndSearch;
      case r'reportingAndStayingSafe':
        return HelpArticleId.reportingAndStayingSafe;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(HelpArticleId self) {
    switch (self) {
      case HelpArticleId.findingAndBookingStay:
        return r'findingAndBookingStay';
      case HelpArticleId.stayDatesGuestsAndRooms:
        return r'stayDatesGuestsAndRooms';
      case HelpArticleId.bookingAndAppointmentStatuses:
        return r'bookingAndAppointmentStatuses';
      case HelpArticleId.reschedulingAndCancelling:
        return r'reschedulingAndCancelling';
      case HelpArticleId.paymentsCashAndNoShows:
        return r'paymentsCashAndNoShows';
      case HelpArticleId.paymentSecurityAndReceipts:
        return r'paymentSecurityAndReceipts';
      case HelpArticleId.profileAndPersonalData:
        return r'profileAndPersonalData';
      case HelpArticleId.messagesNotificationsAndSupport:
        return r'messagesNotificationsAndSupport';
      case HelpArticleId.locationAndSearch:
        return r'locationAndSearch';
      case HelpArticleId.reportingAndStayingSafe:
        return r'reportingAndStayingSafe';
    }
  }
}

extension HelpArticleIdMapperExtension on HelpArticleId {
  String toValue() {
    HelpArticleIdMapper.ensureInitialized();
    return MapperContainer.globals.toValue<HelpArticleId>(this) as String;
  }
}

