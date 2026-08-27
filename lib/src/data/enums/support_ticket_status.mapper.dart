// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'support_ticket_status.dart';

class SupportTicketStatusMapper extends EnumMapper<SupportTicketStatus> {
  SupportTicketStatusMapper._();

  static SupportTicketStatusMapper? _instance;
  static SupportTicketStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SupportTicketStatusMapper._());
    }
    return _instance!;
  }

  static SupportTicketStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SupportTicketStatus decode(dynamic value) {
    switch (value) {
      case r'open':
        return SupportTicketStatus.open;
      case r'inProgress':
        return SupportTicketStatus.inProgress;
      case r'resolved':
        return SupportTicketStatus.resolved;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SupportTicketStatus self) {
    switch (self) {
      case SupportTicketStatus.open:
        return r'open';
      case SupportTicketStatus.inProgress:
        return r'inProgress';
      case SupportTicketStatus.resolved:
        return r'resolved';
    }
  }
}

extension SupportTicketStatusMapperExtension on SupportTicketStatus {
  String toValue() {
    SupportTicketStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SupportTicketStatus>(this) as String;
  }
}

