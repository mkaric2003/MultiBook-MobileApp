// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'add_business_state.dart';

class AddBusinessStateMapper extends ClassMapperBase<AddBusinessState> {
  AddBusinessStateMapper._();

  static AddBusinessStateMapper? _instance;
  static AddBusinessStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AddBusinessStateMapper._());
      BusinessTypeMapper.ensureInitialized();
      StayAmenityMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AddBusinessState';

  static BusinessType _$businessType(AddBusinessState v) => v.businessType;
  static const Field<AddBusinessState, BusinessType> _f$businessType = Field(
    'businessType',
    _$businessType,
    opt: true,
    def: BusinessType.stays,
  );
  static String? _$categoryId(AddBusinessState v) => v.categoryId;
  static const Field<AddBusinessState, String> _f$categoryId = Field(
    'categoryId',
    _$categoryId,
    opt: true,
  );
  static List<StayAmenity> _$selectedAmenities(AddBusinessState v) =>
      v.selectedAmenities;
  static const Field<AddBusinessState, List<StayAmenity>> _f$selectedAmenities =
      Field('selectedAmenities', _$selectedAmenities, opt: true, def: const []);
  static String? _$logoPath(AddBusinessState v) => v.logoPath;
  static const Field<AddBusinessState, String> _f$logoPath = Field(
    'logoPath',
    _$logoPath,
    opt: true,
  );
  static String? _$coverPhotoPath(AddBusinessState v) => v.coverPhotoPath;
  static const Field<AddBusinessState, String> _f$coverPhotoPath = Field(
    'coverPhotoPath',
    _$coverPhotoPath,
    opt: true,
  );
  static bool _$isLoading(AddBusinessState v) => v.isLoading;
  static const Field<AddBusinessState, bool> _f$isLoading = Field(
    'isLoading',
    _$isLoading,
    opt: true,
    def: false,
  );
  static bool _$isSuccess(AddBusinessState v) => v.isSuccess;
  static const Field<AddBusinessState, bool> _f$isSuccess = Field(
    'isSuccess',
    _$isSuccess,
    opt: true,
    def: false,
  );
  static String? _$errorMessage(AddBusinessState v) => v.errorMessage;
  static const Field<AddBusinessState, String> _f$errorMessage = Field(
    'errorMessage',
    _$errorMessage,
    opt: true,
  );
  static String? _$successMessage(AddBusinessState v) => v.successMessage;
  static const Field<AddBusinessState, String> _f$successMessage = Field(
    'successMessage',
    _$successMessage,
    opt: true,
  );
  static bool _$hasExistingBusiness(AddBusinessState v) =>
      v.hasExistingBusiness;
  static const Field<AddBusinessState, bool> _f$hasExistingBusiness = Field(
    'hasExistingBusiness',
    _$hasExistingBusiness,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<AddBusinessState> fields = const {
    #businessType: _f$businessType,
    #categoryId: _f$categoryId,
    #selectedAmenities: _f$selectedAmenities,
    #logoPath: _f$logoPath,
    #coverPhotoPath: _f$coverPhotoPath,
    #isLoading: _f$isLoading,
    #isSuccess: _f$isSuccess,
    #errorMessage: _f$errorMessage,
    #successMessage: _f$successMessage,
    #hasExistingBusiness: _f$hasExistingBusiness,
  };

  static AddBusinessState _instantiate(DecodingData data) {
    return AddBusinessState(
      businessType: data.dec(_f$businessType),
      categoryId: data.dec(_f$categoryId),
      selectedAmenities: data.dec(_f$selectedAmenities),
      logoPath: data.dec(_f$logoPath),
      coverPhotoPath: data.dec(_f$coverPhotoPath),
      isLoading: data.dec(_f$isLoading),
      isSuccess: data.dec(_f$isSuccess),
      errorMessage: data.dec(_f$errorMessage),
      successMessage: data.dec(_f$successMessage),
      hasExistingBusiness: data.dec(_f$hasExistingBusiness),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AddBusinessState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AddBusinessState>(map);
  }

  static AddBusinessState fromJson(String json) {
    return ensureInitialized().decodeJson<AddBusinessState>(json);
  }
}

mixin AddBusinessStateMappable {
  String toJson() {
    return AddBusinessStateMapper.ensureInitialized()
        .encodeJson<AddBusinessState>(this as AddBusinessState);
  }

  Map<String, dynamic> toMap() {
    return AddBusinessStateMapper.ensureInitialized()
        .encodeMap<AddBusinessState>(this as AddBusinessState);
  }

  AddBusinessStateCopyWith<AddBusinessState, AddBusinessState, AddBusinessState>
  get copyWith =>
      _AddBusinessStateCopyWithImpl<AddBusinessState, AddBusinessState>(
        this as AddBusinessState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AddBusinessStateMapper.ensureInitialized().stringifyValue(
      this as AddBusinessState,
    );
  }

  @override
  bool operator ==(Object other) {
    return AddBusinessStateMapper.ensureInitialized().equalsValue(
      this as AddBusinessState,
      other,
    );
  }

  @override
  int get hashCode {
    return AddBusinessStateMapper.ensureInitialized().hashValue(
      this as AddBusinessState,
    );
  }
}

extension AddBusinessStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AddBusinessState, $Out> {
  AddBusinessStateCopyWith<$R, AddBusinessState, $Out>
  get $asAddBusinessState =>
      $base.as((v, t, t2) => _AddBusinessStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AddBusinessStateCopyWith<$R, $In extends AddBusinessState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, StayAmenity, ObjectCopyWith<$R, StayAmenity, StayAmenity>>
  get selectedAmenities;
  $R call({
    BusinessType? businessType,
    String? categoryId,
    List<StayAmenity>? selectedAmenities,
    String? logoPath,
    String? coverPhotoPath,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? successMessage,
    bool? hasExistingBusiness,
  });
  AddBusinessStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AddBusinessStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AddBusinessState, $Out>
    implements AddBusinessStateCopyWith<$R, AddBusinessState, $Out> {
  _AddBusinessStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AddBusinessState> $mapper =
      AddBusinessStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, StayAmenity, ObjectCopyWith<$R, StayAmenity, StayAmenity>>
  get selectedAmenities => ListCopyWith(
    $value.selectedAmenities,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(selectedAmenities: v),
  );
  @override
  $R call({
    BusinessType? businessType,
    Object? categoryId = $none,
    List<StayAmenity>? selectedAmenities,
    Object? logoPath = $none,
    Object? coverPhotoPath = $none,
    bool? isLoading,
    bool? isSuccess,
    Object? errorMessage = $none,
    Object? successMessage = $none,
    bool? hasExistingBusiness,
  }) => $apply(
    FieldCopyWithData({
      if (businessType != null) #businessType: businessType,
      if (categoryId != $none) #categoryId: categoryId,
      if (selectedAmenities != null) #selectedAmenities: selectedAmenities,
      if (logoPath != $none) #logoPath: logoPath,
      if (coverPhotoPath != $none) #coverPhotoPath: coverPhotoPath,
      if (isLoading != null) #isLoading: isLoading,
      if (isSuccess != null) #isSuccess: isSuccess,
      if (errorMessage != $none) #errorMessage: errorMessage,
      if (successMessage != $none) #successMessage: successMessage,
      if (hasExistingBusiness != null)
        #hasExistingBusiness: hasExistingBusiness,
    }),
  );
  @override
  AddBusinessState $make(CopyWithData data) => AddBusinessState(
    businessType: data.get(#businessType, or: $value.businessType),
    categoryId: data.get(#categoryId, or: $value.categoryId),
    selectedAmenities: data.get(
      #selectedAmenities,
      or: $value.selectedAmenities,
    ),
    logoPath: data.get(#logoPath, or: $value.logoPath),
    coverPhotoPath: data.get(#coverPhotoPath, or: $value.coverPhotoPath),
    isLoading: data.get(#isLoading, or: $value.isLoading),
    isSuccess: data.get(#isSuccess, or: $value.isSuccess),
    errorMessage: data.get(#errorMessage, or: $value.errorMessage),
    successMessage: data.get(#successMessage, or: $value.successMessage),
    hasExistingBusiness: data.get(
      #hasExistingBusiness,
      or: $value.hasExistingBusiness,
    ),
  );

  @override
  AddBusinessStateCopyWith<$R2, AddBusinessState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AddBusinessStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

