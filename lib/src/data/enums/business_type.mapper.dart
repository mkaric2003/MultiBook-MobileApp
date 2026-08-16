// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'business_type.dart';

class BusinessTypeMapper extends EnumMapper<BusinessType> {
  BusinessTypeMapper._();

  static BusinessTypeMapper? _instance;
  static BusinessTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BusinessTypeMapper._());
    }
    return _instance!;
  }

  static BusinessType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  BusinessType decode(dynamic value) {
    switch (value) {
      case r'stays':
        return BusinessType.stays;
      case r'services':
        return BusinessType.services;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(BusinessType self) {
    switch (self) {
      case BusinessType.stays:
        return r'stays';
      case BusinessType.services:
        return r'services';
    }
  }
}

extension BusinessTypeMapperExtension on BusinessType {
  String toValue() {
    BusinessTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<BusinessType>(this) as String;
  }
}

