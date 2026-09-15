// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'saved_payment_method_model.dart';

class SavedPaymentMethodModelMapper
    extends ClassMapperBase<SavedPaymentMethodModel> {
  SavedPaymentMethodModelMapper._();

  static SavedPaymentMethodModelMapper? _instance;
  static SavedPaymentMethodModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = SavedPaymentMethodModelMapper._(),
      );
      SavedCardBrandMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SavedPaymentMethodModel';

  static String _$id(SavedPaymentMethodModel v) => v.id;
  static const Field<SavedPaymentMethodModel, String> _f$id = Field('id', _$id);
  static String _$userId(SavedPaymentMethodModel v) => v.userId;
  static const Field<SavedPaymentMethodModel, String> _f$userId = Field(
    'userId',
    _$userId,
  );
  static SavedCardBrand _$brand(SavedPaymentMethodModel v) => v.brand;
  static const Field<SavedPaymentMethodModel, SavedCardBrand> _f$brand = Field(
    'brand',
    _$brand,
  );
  static String _$last4(SavedPaymentMethodModel v) => v.last4;
  static const Field<SavedPaymentMethodModel, String> _f$last4 = Field(
    'last4',
    _$last4,
  );
  static int _$expiryMonth(SavedPaymentMethodModel v) => v.expiryMonth;
  static const Field<SavedPaymentMethodModel, int> _f$expiryMonth = Field(
    'expiryMonth',
    _$expiryMonth,
  );
  static int _$expiryYear(SavedPaymentMethodModel v) => v.expiryYear;
  static const Field<SavedPaymentMethodModel, int> _f$expiryYear = Field(
    'expiryYear',
    _$expiryYear,
  );
  static String _$holderName(SavedPaymentMethodModel v) => v.holderName;
  static const Field<SavedPaymentMethodModel, String> _f$holderName = Field(
    'holderName',
    _$holderName,
  );
  static bool _$isDefault(SavedPaymentMethodModel v) => v.isDefault;
  static const Field<SavedPaymentMethodModel, bool> _f$isDefault = Field(
    'isDefault',
    _$isDefault,
  );
  static DateTime? _$createdAt(SavedPaymentMethodModel v) => v.createdAt;
  static const Field<SavedPaymentMethodModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );

  @override
  final MappableFields<SavedPaymentMethodModel> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #brand: _f$brand,
    #last4: _f$last4,
    #expiryMonth: _f$expiryMonth,
    #expiryYear: _f$expiryYear,
    #holderName: _f$holderName,
    #isDefault: _f$isDefault,
    #createdAt: _f$createdAt,
  };

  static SavedPaymentMethodModel _instantiate(DecodingData data) {
    return SavedPaymentMethodModel(
      id: data.dec(_f$id),
      userId: data.dec(_f$userId),
      brand: data.dec(_f$brand),
      last4: data.dec(_f$last4),
      expiryMonth: data.dec(_f$expiryMonth),
      expiryYear: data.dec(_f$expiryYear),
      holderName: data.dec(_f$holderName),
      isDefault: data.dec(_f$isDefault),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SavedPaymentMethodModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SavedPaymentMethodModel>(map);
  }

  static SavedPaymentMethodModel fromJson(String json) {
    return ensureInitialized().decodeJson<SavedPaymentMethodModel>(json);
  }
}

mixin SavedPaymentMethodModelMappable {
  String toJson() {
    return SavedPaymentMethodModelMapper.ensureInitialized()
        .encodeJson<SavedPaymentMethodModel>(this as SavedPaymentMethodModel);
  }

  Map<String, dynamic> toMap() {
    return SavedPaymentMethodModelMapper.ensureInitialized()
        .encodeMap<SavedPaymentMethodModel>(this as SavedPaymentMethodModel);
  }

  SavedPaymentMethodModelCopyWith<
    SavedPaymentMethodModel,
    SavedPaymentMethodModel,
    SavedPaymentMethodModel
  >
  get copyWith =>
      _SavedPaymentMethodModelCopyWithImpl<
        SavedPaymentMethodModel,
        SavedPaymentMethodModel
      >(this as SavedPaymentMethodModel, $identity, $identity);
  @override
  String toString() {
    return SavedPaymentMethodModelMapper.ensureInitialized().stringifyValue(
      this as SavedPaymentMethodModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return SavedPaymentMethodModelMapper.ensureInitialized().equalsValue(
      this as SavedPaymentMethodModel,
      other,
    );
  }

  @override
  int get hashCode {
    return SavedPaymentMethodModelMapper.ensureInitialized().hashValue(
      this as SavedPaymentMethodModel,
    );
  }
}

extension SavedPaymentMethodModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SavedPaymentMethodModel, $Out> {
  SavedPaymentMethodModelCopyWith<$R, SavedPaymentMethodModel, $Out>
  get $asSavedPaymentMethodModel => $base.as(
    (v, t, t2) => _SavedPaymentMethodModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class SavedPaymentMethodModelCopyWith<
  $R,
  $In extends SavedPaymentMethodModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? userId,
    SavedCardBrand? brand,
    String? last4,
    int? expiryMonth,
    int? expiryYear,
    String? holderName,
    bool? isDefault,
    DateTime? createdAt,
  });
  SavedPaymentMethodModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SavedPaymentMethodModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SavedPaymentMethodModel, $Out>
    implements
        SavedPaymentMethodModelCopyWith<$R, SavedPaymentMethodModel, $Out> {
  _SavedPaymentMethodModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SavedPaymentMethodModel> $mapper =
      SavedPaymentMethodModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? userId,
    SavedCardBrand? brand,
    String? last4,
    int? expiryMonth,
    int? expiryYear,
    String? holderName,
    bool? isDefault,
    Object? createdAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (userId != null) #userId: userId,
      if (brand != null) #brand: brand,
      if (last4 != null) #last4: last4,
      if (expiryMonth != null) #expiryMonth: expiryMonth,
      if (expiryYear != null) #expiryYear: expiryYear,
      if (holderName != null) #holderName: holderName,
      if (isDefault != null) #isDefault: isDefault,
      if (createdAt != $none) #createdAt: createdAt,
    }),
  );
  @override
  SavedPaymentMethodModel $make(CopyWithData data) => SavedPaymentMethodModel(
    id: data.get(#id, or: $value.id),
    userId: data.get(#userId, or: $value.userId),
    brand: data.get(#brand, or: $value.brand),
    last4: data.get(#last4, or: $value.last4),
    expiryMonth: data.get(#expiryMonth, or: $value.expiryMonth),
    expiryYear: data.get(#expiryYear, or: $value.expiryYear),
    holderName: data.get(#holderName, or: $value.holderName),
    isDefault: data.get(#isDefault, or: $value.isDefault),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  SavedPaymentMethodModelCopyWith<$R2, SavedPaymentMethodModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SavedPaymentMethodModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

