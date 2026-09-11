// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'booking_status.dart';

class BookingStatusMapper extends EnumMapper<BookingStatus> {
  BookingStatusMapper._();

  static BookingStatusMapper? _instance;
  static BookingStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookingStatusMapper._());
    }
    return _instance!;
  }

  static BookingStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  BookingStatus decode(dynamic value) {
    switch (value) {
      case r'confirmed':
        return BookingStatus.confirmed;
      case r'declined':
        return BookingStatus.declined;
      case r'cancelled':
        return BookingStatus.cancelled;
      case r'completed':
        return BookingStatus.completed;
      case r'noShow':
        return BookingStatus.noShow;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(BookingStatus self) {
    switch (self) {
      case BookingStatus.confirmed:
        return r'confirmed';
      case BookingStatus.declined:
        return r'declined';
      case BookingStatus.cancelled:
        return r'cancelled';
      case BookingStatus.completed:
        return r'completed';
      case BookingStatus.noShow:
        return r'noShow';
    }
  }
}

extension BookingStatusMapperExtension on BookingStatus {
  String toValue() {
    BookingStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<BookingStatus>(this) as String;
  }
}

