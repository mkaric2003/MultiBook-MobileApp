// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'promotion_type.dart';

class PromotionTypeMapper extends EnumMapper<PromotionType> {
  PromotionTypeMapper._();

  static PromotionTypeMapper? _instance;
  static PromotionTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PromotionTypeMapper._());
    }
    return _instance!;
  }

  static PromotionType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  PromotionType decode(dynamic value) {
    switch (value) {
      case r'percentage':
        return PromotionType.percentage;
      case r'fixedAmount':
        return PromotionType.fixedAmount;
      case r'couponCode':
        return PromotionType.couponCode;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(PromotionType self) {
    switch (self) {
      case PromotionType.percentage:
        return r'percentage';
      case PromotionType.fixedAmount:
        return r'fixedAmount';
      case PromotionType.couponCode:
        return r'couponCode';
    }
  }
}

extension PromotionTypeMapperExtension on PromotionType {
  String toValue() {
    PromotionTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<PromotionType>(this) as String;
  }
}

