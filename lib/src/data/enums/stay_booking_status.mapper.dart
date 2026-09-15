// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'stay_booking_status.dart';

class StayBookingStatusMapper extends EnumMapper<StayBookingStatus> {
  StayBookingStatusMapper._();

  static StayBookingStatusMapper? _instance;
  static StayBookingStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StayBookingStatusMapper._());
    }
    return _instance!;
  }

  static StayBookingStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  StayBookingStatus decode(dynamic value) {
    switch (value) {
      case r'pending':
        return StayBookingStatus.pending;
      case r'confirmed':
        return StayBookingStatus.confirmed;
      case r'cancelled':
        return StayBookingStatus.cancelled;
      case r'completed':
        return StayBookingStatus.completed;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(StayBookingStatus self) {
    switch (self) {
      case StayBookingStatus.pending:
        return r'pending';
      case StayBookingStatus.confirmed:
        return r'confirmed';
      case StayBookingStatus.cancelled:
        return r'cancelled';
      case StayBookingStatus.completed:
        return r'completed';
    }
  }
}

extension StayBookingStatusMapperExtension on StayBookingStatus {
  String toValue() {
    StayBookingStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<StayBookingStatus>(this) as String;
  }
}

