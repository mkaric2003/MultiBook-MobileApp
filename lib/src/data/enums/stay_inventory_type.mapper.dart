// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'stay_inventory_type.dart';

class StayInventoryTypeMapper extends EnumMapper<StayInventoryType> {
  StayInventoryTypeMapper._();

  static StayInventoryTypeMapper? _instance;
  static StayInventoryTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StayInventoryTypeMapper._());
    }
    return _instance!;
  }

  static StayInventoryType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  StayInventoryType decode(dynamic value) {
    switch (value) {
      case r'singleUnit':
        return StayInventoryType.singleUnit;
      case r'multipleUnits':
        return StayInventoryType.multipleUnits;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(StayInventoryType self) {
    switch (self) {
      case StayInventoryType.singleUnit:
        return r'singleUnit';
      case StayInventoryType.multipleUnits:
        return r'multipleUnits';
    }
  }
}

extension StayInventoryTypeMapperExtension on StayInventoryType {
  String toValue() {
    StayInventoryTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<StayInventoryType>(this) as String;
  }
}

