// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'stay_extra_type.dart';

class StayExtraTypeMapper extends EnumMapper<StayExtraType> {
  StayExtraTypeMapper._();

  static StayExtraTypeMapper? _instance;
  static StayExtraTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StayExtraTypeMapper._());
    }
    return _instance!;
  }

  static StayExtraType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  StayExtraType decode(dynamic value) {
    switch (value) {
      case r'breakfast':
        return StayExtraType.breakfast;
      case r'parking':
        return StayExtraType.parking;
      case r'spaAccess':
        return StayExtraType.spaAccess;
      case r'airportTransfer':
        return StayExtraType.airportTransfer;
      case r'lateCheckout':
        return StayExtraType.lateCheckout;
      case r'petStay':
        return StayExtraType.petStay;
      case r'extraBed':
        return StayExtraType.extraBed;
      case r'laundryService':
        return StayExtraType.laundryService;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(StayExtraType self) {
    switch (self) {
      case StayExtraType.breakfast:
        return r'breakfast';
      case StayExtraType.parking:
        return r'parking';
      case StayExtraType.spaAccess:
        return r'spaAccess';
      case StayExtraType.airportTransfer:
        return r'airportTransfer';
      case StayExtraType.lateCheckout:
        return r'lateCheckout';
      case StayExtraType.petStay:
        return r'petStay';
      case StayExtraType.extraBed:
        return r'extraBed';
      case StayExtraType.laundryService:
        return r'laundryService';
    }
  }
}

extension StayExtraTypeMapperExtension on StayExtraType {
  String toValue() {
    StayExtraTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<StayExtraType>(this) as String;
  }
}

