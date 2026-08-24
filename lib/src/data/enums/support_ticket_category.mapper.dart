// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'support_ticket_category.dart';

class SupportTicketCategoryMapper extends EnumMapper<SupportTicketCategory> {
  SupportTicketCategoryMapper._();

  static SupportTicketCategoryMapper? _instance;
  static SupportTicketCategoryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SupportTicketCategoryMapper._());
    }
    return _instance!;
  }

  static SupportTicketCategory fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SupportTicketCategory decode(dynamic value) {
    switch (value) {
      case r'account':
        return SupportTicketCategory.account;
      case r'booking':
        return SupportTicketCategory.booking;
      case r'appointment':
        return SupportTicketCategory.appointment;
      case r'payment':
        return SupportTicketCategory.payment;
      case r'technical':
        return SupportTicketCategory.technical;
      case r'other':
        return SupportTicketCategory.other;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SupportTicketCategory self) {
    switch (self) {
      case SupportTicketCategory.account:
        return r'account';
      case SupportTicketCategory.booking:
        return r'booking';
      case SupportTicketCategory.appointment:
        return r'appointment';
      case SupportTicketCategory.payment:
        return r'payment';
      case SupportTicketCategory.technical:
        return r'technical';
      case SupportTicketCategory.other:
        return r'other';
    }
  }
}

extension SupportTicketCategoryMapperExtension on SupportTicketCategory {
  String toValue() {
    SupportTicketCategoryMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SupportTicketCategory>(this)
        as String;
  }
}

