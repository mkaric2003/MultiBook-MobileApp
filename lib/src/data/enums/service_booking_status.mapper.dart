// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'service_booking_status.dart';

class ServiceBookingStatusMapper extends EnumMapper<ServiceBookingStatus> {
  ServiceBookingStatusMapper._();

  static ServiceBookingStatusMapper? _instance;
  static ServiceBookingStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServiceBookingStatusMapper._());
    }
    return _instance!;
  }

  static ServiceBookingStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ServiceBookingStatus decode(dynamic value) {
    switch (value) {
      case r'pending':
        return ServiceBookingStatus.pending;
      case r'confirmed':
        return ServiceBookingStatus.confirmed;
      case r'cancelled':
        return ServiceBookingStatus.cancelled;
      case r'completed':
        return ServiceBookingStatus.completed;
      case r'noShow':
        return ServiceBookingStatus.noShow;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ServiceBookingStatus self) {
    switch (self) {
      case ServiceBookingStatus.pending:
        return r'pending';
      case ServiceBookingStatus.confirmed:
        return r'confirmed';
      case ServiceBookingStatus.cancelled:
        return r'cancelled';
      case ServiceBookingStatus.completed:
        return r'completed';
      case ServiceBookingStatus.noShow:
        return r'noShow';
    }
  }
}

extension ServiceBookingStatusMapperExtension on ServiceBookingStatus {
  String toValue() {
    ServiceBookingStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ServiceBookingStatus>(this)
        as String;
  }
}

