// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'stay_amenity.dart';

class StayAmenityMapper extends EnumMapper<StayAmenity> {
  StayAmenityMapper._();

  static StayAmenityMapper? _instance;
  static StayAmenityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StayAmenityMapper._());
    }
    return _instance!;
  }

  static StayAmenity fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  StayAmenity decode(dynamic value) {
    switch (value) {
      case r'wifi':
        return StayAmenity.wifi;
      case r'parking':
        return StayAmenity.parking;
      case r'pool':
        return StayAmenity.pool;
      case r'spa':
        return StayAmenity.spa;
      case r'petFriendly':
        return StayAmenity.petFriendly;
      case r'gym':
        return StayAmenity.gym;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(StayAmenity self) {
    switch (self) {
      case StayAmenity.wifi:
        return r'wifi';
      case StayAmenity.parking:
        return r'parking';
      case StayAmenity.pool:
        return r'pool';
      case StayAmenity.spa:
        return r'spa';
      case StayAmenity.petFriendly:
        return r'petFriendly';
      case StayAmenity.gym:
        return r'gym';
    }
  }
}

extension StayAmenityMapperExtension on StayAmenity {
  String toValue() {
    StayAmenityMapper.ensureInitialized();
    return MapperContainer.globals.toValue<StayAmenity>(this) as String;
  }
}

