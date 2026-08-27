// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'currency_code.dart';

class CurrencyCodeMapper extends EnumMapper<CurrencyCode> {
  CurrencyCodeMapper._();

  static CurrencyCodeMapper? _instance;
  static CurrencyCodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CurrencyCodeMapper._());
    }
    return _instance!;
  }

  static CurrencyCode fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  CurrencyCode decode(dynamic value) {
    switch (value) {
      case r'bam':
        return CurrencyCode.bam;
      case r'usd':
        return CurrencyCode.usd;
      case r'eur':
        return CurrencyCode.eur;
      case r'chf':
        return CurrencyCode.chf;
      case r'gbp':
        return CurrencyCode.gbp;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(CurrencyCode self) {
    switch (self) {
      case CurrencyCode.bam:
        return r'bam';
      case CurrencyCode.usd:
        return r'usd';
      case CurrencyCode.eur:
        return r'eur';
      case CurrencyCode.chf:
        return r'chf';
      case CurrencyCode.gbp:
        return r'gbp';
    }
  }
}

extension CurrencyCodeMapperExtension on CurrencyCode {
  String toValue() {
    CurrencyCodeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<CurrencyCode>(this) as String;
  }
}

