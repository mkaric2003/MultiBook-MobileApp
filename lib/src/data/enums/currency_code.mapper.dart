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
      case 'BAM':
        return CurrencyCode.bam;
      case 'USD':
        return CurrencyCode.usd;
      case 'EUR':
        return CurrencyCode.eur;
      case 'CHF':
        return CurrencyCode.chf;
      case 'GBP':
        return CurrencyCode.gbp;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(CurrencyCode self) {
    switch (self) {
      case CurrencyCode.bam:
        return 'BAM';
      case CurrencyCode.usd:
        return 'USD';
      case CurrencyCode.eur:
        return 'EUR';
      case CurrencyCode.chf:
        return 'CHF';
      case CurrencyCode.gbp:
        return 'GBP';
    }
  }
}

extension CurrencyCodeMapperExtension on CurrencyCode {
  dynamic toValue() {
    CurrencyCodeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<CurrencyCode>(this);
  }
}

