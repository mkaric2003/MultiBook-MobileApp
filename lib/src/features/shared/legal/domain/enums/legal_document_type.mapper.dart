// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'legal_document_type.dart';

class LegalDocumentTypeMapper extends EnumMapper<LegalDocumentType> {
  LegalDocumentTypeMapper._();

  static LegalDocumentTypeMapper? _instance;
  static LegalDocumentTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LegalDocumentTypeMapper._());
    }
    return _instance!;
  }

  static LegalDocumentType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  LegalDocumentType decode(dynamic value) {
    switch (value) {
      case r'termsOfService':
        return LegalDocumentType.termsOfService;
      case r'privacyPolicy':
        return LegalDocumentType.privacyPolicy;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(LegalDocumentType self) {
    switch (self) {
      case LegalDocumentType.termsOfService:
        return r'termsOfService';
      case LegalDocumentType.privacyPolicy:
        return r'privacyPolicy';
    }
  }
}

extension LegalDocumentTypeMapperExtension on LegalDocumentType {
  String toValue() {
    LegalDocumentTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<LegalDocumentType>(this) as String;
  }
}

