// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'service_weekday.dart';

class ServiceWeekdayMapper extends EnumMapper<ServiceWeekday> {
  ServiceWeekdayMapper._();

  static ServiceWeekdayMapper? _instance;
  static ServiceWeekdayMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServiceWeekdayMapper._());
    }
    return _instance!;
  }

  static ServiceWeekday fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ServiceWeekday decode(dynamic value) {
    switch (value) {
      case r'monday':
        return ServiceWeekday.monday;
      case r'tuesday':
        return ServiceWeekday.tuesday;
      case r'wednesday':
        return ServiceWeekday.wednesday;
      case r'thursday':
        return ServiceWeekday.thursday;
      case r'friday':
        return ServiceWeekday.friday;
      case r'saturday':
        return ServiceWeekday.saturday;
      case r'sunday':
        return ServiceWeekday.sunday;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ServiceWeekday self) {
    switch (self) {
      case ServiceWeekday.monday:
        return r'monday';
      case ServiceWeekday.tuesday:
        return r'tuesday';
      case ServiceWeekday.wednesday:
        return r'wednesday';
      case ServiceWeekday.thursday:
        return r'thursday';
      case ServiceWeekday.friday:
        return r'friday';
      case ServiceWeekday.saturday:
        return r'saturday';
      case ServiceWeekday.sunday:
        return r'sunday';
    }
  }
}

extension ServiceWeekdayMapperExtension on ServiceWeekday {
  String toValue() {
    ServiceWeekdayMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ServiceWeekday>(this) as String;
  }
}

