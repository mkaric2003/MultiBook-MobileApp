// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'legal_document_audience.dart';

class LegalDocumentAudienceMapper extends EnumMapper<LegalDocumentAudience> {
  LegalDocumentAudienceMapper._();

  static LegalDocumentAudienceMapper? _instance;
  static LegalDocumentAudienceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LegalDocumentAudienceMapper._());
    }
    return _instance!;
  }

  static LegalDocumentAudience fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  LegalDocumentAudience decode(dynamic value) {
    switch (value) {
      case r'customer':
        return LegalDocumentAudience.customer;
      case r'provider':
        return LegalDocumentAudience.provider;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(LegalDocumentAudience self) {
    switch (self) {
      case LegalDocumentAudience.customer:
        return r'customer';
      case LegalDocumentAudience.provider:
        return r'provider';
    }
  }
}

extension LegalDocumentAudienceMapperExtension on LegalDocumentAudience {
  String toValue() {
    LegalDocumentAudienceMapper.ensureInitialized();
    return MapperContainer.globals.toValue<LegalDocumentAudience>(this)
        as String;
  }
}

