// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'saved_card_brand.dart';

class SavedCardBrandMapper extends EnumMapper<SavedCardBrand> {
  SavedCardBrandMapper._();

  static SavedCardBrandMapper? _instance;
  static SavedCardBrandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SavedCardBrandMapper._());
    }
    return _instance!;
  }

  static SavedCardBrand fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SavedCardBrand decode(dynamic value) {
    switch (value) {
      case r'visa':
        return SavedCardBrand.visa;
      case r'mastercard':
        return SavedCardBrand.mastercard;
      case r'amex':
        return SavedCardBrand.amex;
      case r'other':
        return SavedCardBrand.other;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SavedCardBrand self) {
    switch (self) {
      case SavedCardBrand.visa:
        return r'visa';
      case SavedCardBrand.mastercard:
        return r'mastercard';
      case SavedCardBrand.amex:
        return r'amex';
      case SavedCardBrand.other:
        return r'other';
    }
  }
}

extension SavedCardBrandMapperExtension on SavedCardBrand {
  String toValue() {
    SavedCardBrandMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SavedCardBrand>(this) as String;
  }
}

