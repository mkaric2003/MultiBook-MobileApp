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
      StayInventoryTypeMapper.ensureInitialized();
      StayAmenityMapper.ensureInitialized();
      StayExtraTypeMapper.ensureInitialized();
      ServiceOfferingModelMapper.ensureInitialized();
      ServiceAvailabilitySlotModelMapper.ensureInitialized();
      ServiceProviderModelMapper.ensureInitialized();
      StayRoomModelMapper.ensureInitialized();
      BusinessModelMapper.ensureInitialized();
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
  static StayInventoryType _$stayInventoryType(AddBusinessState v) =>
      v.stayInventoryType;
  static const Field<AddBusinessState, StayInventoryType> _f$stayInventoryType =
      Field(
        'stayInventoryType',
        _$stayInventoryType,
        opt: true,
        def: StayInventoryType.singleUnit,
      );
  static List<StayAmenity> _$selectedAmenities(AddBusinessState v) =>
      v.selectedAmenities;
  static const Field<AddBusinessState, List<StayAmenity>> _f$selectedAmenities =
      Field('selectedAmenities', _$selectedAmenities, opt: true, def: const []);
  static List<String> _$selectedCollectionIds(AddBusinessState v) =>
      v.selectedCollectionIds;
  static const Field<AddBusinessState, List<String>> _f$selectedCollectionIds =
      Field(
        'selectedCollectionIds',
        _$selectedCollectionIds,
        opt: true,
        def: const [],
      );
  static List<StayExtraType> _$selectedExtras(AddBusinessState v) =>
      v.selectedExtras;
  static const Field<AddBusinessState, List<StayExtraType>> _f$selectedExtras =
      Field('selectedExtras', _$selectedExtras, opt: true, def: const []);
  static Map<String, int> _$extraPrices(AddBusinessState v) => v.extraPrices;
  static const Field<AddBusinessState, Map<String, int>> _f$extraPrices = Field(
    'extraPrices',
    _$extraPrices,
    opt: true,
    def: const {},
  );
  static List<ServiceOfferingModel> _$serviceOfferings(AddBusinessState v) =>
      v.serviceOfferings;
  static const Field<AddBusinessState, List<ServiceOfferingModel>>
  _f$serviceOfferings = Field(
    'serviceOfferings',
    _$serviceOfferings,
    opt: true,
    def: const [],
  );
  static List<ServiceAvailabilitySlotModel> _$availabilitySlots(
    AddBusinessState v,
  ) => v.availabilitySlots;
  static const Field<AddBusinessState, List<ServiceAvailabilitySlotModel>>
  _f$availabilitySlots = Field(
    'availabilitySlots',
    _$availabilitySlots,
    opt: true,
    def: const [],
  );
  static List<ServiceProviderModel> _$serviceProviders(AddBusinessState v) =>
      v.serviceProviders;
  static const Field<AddBusinessState, List<ServiceProviderModel>>
  _f$serviceProviders = Field(
    'serviceProviders',
    _$serviceProviders,
    opt: true,
    def: const [],
  );
  static List<StayRoomModel> _$stayRooms(AddBusinessState v) => v.stayRooms;
  static const Field<AddBusinessState, List<StayRoomModel>> _f$stayRooms =
      Field('stayRooms', _$stayRooms, opt: true, def: const []);
  static BusinessModel? _$editingBusiness(AddBusinessState v) =>
      v.editingBusiness;
  static const Field<AddBusinessState, BusinessModel> _f$editingBusiness =
      Field('editingBusiness', _$editingBusiness, opt: true);
  static double? _$latitude(AddBusinessState v) => v.latitude;
  static const Field<AddBusinessState, double> _f$latitude = Field(
    'latitude',
    _$latitude,
    opt: true,
  );
  static double? _$longitude(AddBusinessState v) => v.longitude;
  static const Field<AddBusinessState, double> _f$longitude = Field(
    'longitude',
    _$longitude,
    opt: true,
  );
  static String? _$resolvedCity(AddBusinessState v) => v.resolvedCity;
  static const Field<AddBusinessState, String> _f$resolvedCity = Field(
    'resolvedCity',
    _$resolvedCity,
    opt: true,
  );
  static String? _$resolvedAddress(AddBusinessState v) => v.resolvedAddress;
  static const Field<AddBusinessState, String> _f$resolvedAddress = Field(
    'resolvedAddress',
    _$resolvedAddress,
    opt: true,
  );
  static bool _$isResolvingLocation(AddBusinessState v) =>
      v.isResolvingLocation;
  static const Field<AddBusinessState, bool> _f$isResolvingLocation = Field(
    'isResolvingLocation',
    _$isResolvingLocation,
    opt: true,
    def: false,
  );
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
  static List<String> _$businessPhotoPaths(AddBusinessState v) =>
      v.businessPhotoPaths;
  static const Field<AddBusinessState, List<String>> _f$businessPhotoPaths =
      Field(
        'businessPhotoPaths',
        _$businessPhotoPaths,
        opt: true,
        def: const [],
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
  static bool _$isCheckingExistingBusiness(AddBusinessState v) =>
      v.isCheckingExistingBusiness;
  static const Field<AddBusinessState, bool> _f$isCheckingExistingBusiness =
      Field(
        'isCheckingExistingBusiness',
        _$isCheckingExistingBusiness,
        opt: true,
        def: true,
      );

  @override
  final MappableFields<AddBusinessState> fields = const {
    #businessType: _f$businessType,
    #categoryId: _f$categoryId,
    #stayInventoryType: _f$stayInventoryType,
    #selectedAmenities: _f$selectedAmenities,
    #selectedCollectionIds: _f$selectedCollectionIds,
    #selectedExtras: _f$selectedExtras,
    #extraPrices: _f$extraPrices,
    #serviceOfferings: _f$serviceOfferings,
    #availabilitySlots: _f$availabilitySlots,
    #serviceProviders: _f$serviceProviders,
    #stayRooms: _f$stayRooms,
    #editingBusiness: _f$editingBusiness,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
    #resolvedCity: _f$resolvedCity,
    #resolvedAddress: _f$resolvedAddress,
    #isResolvingLocation: _f$isResolvingLocation,
    #logoPath: _f$logoPath,
    #coverPhotoPath: _f$coverPhotoPath,
    #businessPhotoPaths: _f$businessPhotoPaths,
    #isLoading: _f$isLoading,
    #isSuccess: _f$isSuccess,
    #errorMessage: _f$errorMessage,
    #successMessage: _f$successMessage,
    #hasExistingBusiness: _f$hasExistingBusiness,
    #isCheckingExistingBusiness: _f$isCheckingExistingBusiness,
  };

  static AddBusinessState _instantiate(DecodingData data) {
    return AddBusinessState(
      businessType: data.dec(_f$businessType),
      categoryId: data.dec(_f$categoryId),
      stayInventoryType: data.dec(_f$stayInventoryType),
      selectedAmenities: data.dec(_f$selectedAmenities),
      selectedCollectionIds: data.dec(_f$selectedCollectionIds),
      selectedExtras: data.dec(_f$selectedExtras),
      extraPrices: data.dec(_f$extraPrices),
      serviceOfferings: data.dec(_f$serviceOfferings),
      availabilitySlots: data.dec(_f$availabilitySlots),
      serviceProviders: data.dec(_f$serviceProviders),
      stayRooms: data.dec(_f$stayRooms),
      editingBusiness: data.dec(_f$editingBusiness),
      latitude: data.dec(_f$latitude),
      longitude: data.dec(_f$longitude),
      resolvedCity: data.dec(_f$resolvedCity),
      resolvedAddress: data.dec(_f$resolvedAddress),
      isResolvingLocation: data.dec(_f$isResolvingLocation),
      logoPath: data.dec(_f$logoPath),
      coverPhotoPath: data.dec(_f$coverPhotoPath),
      businessPhotoPaths: data.dec(_f$businessPhotoPaths),
      isLoading: data.dec(_f$isLoading),
      isSuccess: data.dec(_f$isSuccess),
      errorMessage: data.dec(_f$errorMessage),
      successMessage: data.dec(_f$successMessage),
      hasExistingBusiness: data.dec(_f$hasExistingBusiness),
      isCheckingExistingBusiness: data.dec(_f$isCheckingExistingBusiness),
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
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get selectedCollectionIds;
  ListCopyWith<
    $R,
    StayExtraType,
    ObjectCopyWith<$R, StayExtraType, StayExtraType>
  >
  get selectedExtras;
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>> get extraPrices;
  ListCopyWith<
    $R,
    ServiceOfferingModel,
    ServiceOfferingModelCopyWith<$R, ServiceOfferingModel, ServiceOfferingModel>
  >
  get serviceOfferings;
  ListCopyWith<
    $R,
    ServiceAvailabilitySlotModel,
    ServiceAvailabilitySlotModelCopyWith<
      $R,
      ServiceAvailabilitySlotModel,
      ServiceAvailabilitySlotModel
    >
  >
  get availabilitySlots;
  ListCopyWith<
    $R,
    ServiceProviderModel,
    ServiceProviderModelCopyWith<$R, ServiceProviderModel, ServiceProviderModel>
  >
  get serviceProviders;
  ListCopyWith<
    $R,
    StayRoomModel,
    StayRoomModelCopyWith<$R, StayRoomModel, StayRoomModel>
  >
  get stayRooms;
  BusinessModelCopyWith<$R, BusinessModel, BusinessModel>? get editingBusiness;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get businessPhotoPaths;
  $R call({
    BusinessType? businessType,
    String? categoryId,
    StayInventoryType? stayInventoryType,
    List<StayAmenity>? selectedAmenities,
    List<String>? selectedCollectionIds,
    List<StayExtraType>? selectedExtras,
    Map<String, int>? extraPrices,
    List<ServiceOfferingModel>? serviceOfferings,
    List<ServiceAvailabilitySlotModel>? availabilitySlots,
    List<ServiceProviderModel>? serviceProviders,
    List<StayRoomModel>? stayRooms,
    BusinessModel? editingBusiness,
    double? latitude,
    double? longitude,
    String? resolvedCity,
    String? resolvedAddress,
    bool? isResolvingLocation,
    String? logoPath,
    String? coverPhotoPath,
    List<String>? businessPhotoPaths,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? successMessage,
    bool? hasExistingBusiness,
    bool? isCheckingExistingBusiness,
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
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get selectedCollectionIds => ListCopyWith(
    $value.selectedCollectionIds,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(selectedCollectionIds: v),
  );
  @override
  ListCopyWith<
    $R,
    StayExtraType,
    ObjectCopyWith<$R, StayExtraType, StayExtraType>
  >
  get selectedExtras => ListCopyWith(
    $value.selectedExtras,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(selectedExtras: v),
  );
  @override
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>> get extraPrices =>
      MapCopyWith(
        $value.extraPrices,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(extraPrices: v),
      );
  @override
  ListCopyWith<
    $R,
    ServiceOfferingModel,
    ServiceOfferingModelCopyWith<$R, ServiceOfferingModel, ServiceOfferingModel>
  >
  get serviceOfferings => ListCopyWith(
    $value.serviceOfferings,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(serviceOfferings: v),
  );
  @override
  ListCopyWith<
    $R,
    ServiceAvailabilitySlotModel,
    ServiceAvailabilitySlotModelCopyWith<
      $R,
      ServiceAvailabilitySlotModel,
      ServiceAvailabilitySlotModel
    >
  >
  get availabilitySlots => ListCopyWith(
    $value.availabilitySlots,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(availabilitySlots: v),
  );
  @override
  ListCopyWith<
    $R,
    ServiceProviderModel,
    ServiceProviderModelCopyWith<$R, ServiceProviderModel, ServiceProviderModel>
  >
  get serviceProviders => ListCopyWith(
    $value.serviceProviders,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(serviceProviders: v),
  );
  @override
  ListCopyWith<
    $R,
    StayRoomModel,
    StayRoomModelCopyWith<$R, StayRoomModel, StayRoomModel>
  >
  get stayRooms => ListCopyWith(
    $value.stayRooms,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(stayRooms: v),
  );
  @override
  BusinessModelCopyWith<$R, BusinessModel, BusinessModel>?
  get editingBusiness =>
      $value.editingBusiness?.copyWith.$chain((v) => call(editingBusiness: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get businessPhotoPaths => ListCopyWith(
    $value.businessPhotoPaths,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(businessPhotoPaths: v),
  );
  @override
  $R call({
    BusinessType? businessType,
    Object? categoryId = $none,
    StayInventoryType? stayInventoryType,
    List<StayAmenity>? selectedAmenities,
    List<String>? selectedCollectionIds,
    List<StayExtraType>? selectedExtras,
    Map<String, int>? extraPrices,
    List<ServiceOfferingModel>? serviceOfferings,
    List<ServiceAvailabilitySlotModel>? availabilitySlots,
    List<ServiceProviderModel>? serviceProviders,
    List<StayRoomModel>? stayRooms,
    Object? editingBusiness = $none,
    Object? latitude = $none,
    Object? longitude = $none,
    Object? resolvedCity = $none,
    Object? resolvedAddress = $none,
    bool? isResolvingLocation,
    Object? logoPath = $none,
    Object? coverPhotoPath = $none,
    List<String>? businessPhotoPaths,
    bool? isLoading,
    bool? isSuccess,
    Object? errorMessage = $none,
    Object? successMessage = $none,
    bool? hasExistingBusiness,
    bool? isCheckingExistingBusiness,
  }) => $apply(
    FieldCopyWithData({
      if (businessType != null) #businessType: businessType,
      if (categoryId != $none) #categoryId: categoryId,
      if (stayInventoryType != null) #stayInventoryType: stayInventoryType,
      if (selectedAmenities != null) #selectedAmenities: selectedAmenities,
      if (selectedCollectionIds != null)
        #selectedCollectionIds: selectedCollectionIds,
      if (selectedExtras != null) #selectedExtras: selectedExtras,
      if (extraPrices != null) #extraPrices: extraPrices,
      if (serviceOfferings != null) #serviceOfferings: serviceOfferings,
      if (availabilitySlots != null) #availabilitySlots: availabilitySlots,
      if (serviceProviders != null) #serviceProviders: serviceProviders,
      if (stayRooms != null) #stayRooms: stayRooms,
      if (editingBusiness != $none) #editingBusiness: editingBusiness,
      if (latitude != $none) #latitude: latitude,
      if (longitude != $none) #longitude: longitude,
      if (resolvedCity != $none) #resolvedCity: resolvedCity,
      if (resolvedAddress != $none) #resolvedAddress: resolvedAddress,
      if (isResolvingLocation != null)
        #isResolvingLocation: isResolvingLocation,
      if (logoPath != $none) #logoPath: logoPath,
      if (coverPhotoPath != $none) #coverPhotoPath: coverPhotoPath,
      if (businessPhotoPaths != null) #businessPhotoPaths: businessPhotoPaths,
      if (isLoading != null) #isLoading: isLoading,
      if (isSuccess != null) #isSuccess: isSuccess,
      if (errorMessage != $none) #errorMessage: errorMessage,
      if (successMessage != $none) #successMessage: successMessage,
      if (hasExistingBusiness != null)
        #hasExistingBusiness: hasExistingBusiness,
      if (isCheckingExistingBusiness != null)
        #isCheckingExistingBusiness: isCheckingExistingBusiness,
    }),
  );
  @override
  AddBusinessState $make(CopyWithData data) => AddBusinessState(
    businessType: data.get(#businessType, or: $value.businessType),
    categoryId: data.get(#categoryId, or: $value.categoryId),
    stayInventoryType: data.get(
      #stayInventoryType,
      or: $value.stayInventoryType,
    ),
    selectedAmenities: data.get(
      #selectedAmenities,
      or: $value.selectedAmenities,
    ),
    selectedCollectionIds: data.get(
      #selectedCollectionIds,
      or: $value.selectedCollectionIds,
    ),
    selectedExtras: data.get(#selectedExtras, or: $value.selectedExtras),
    extraPrices: data.get(#extraPrices, or: $value.extraPrices),
    serviceOfferings: data.get(#serviceOfferings, or: $value.serviceOfferings),
    availabilitySlots: data.get(
      #availabilitySlots,
      or: $value.availabilitySlots,
    ),
    serviceProviders: data.get(#serviceProviders, or: $value.serviceProviders),
    stayRooms: data.get(#stayRooms, or: $value.stayRooms),
    editingBusiness: data.get(#editingBusiness, or: $value.editingBusiness),
    latitude: data.get(#latitude, or: $value.latitude),
    longitude: data.get(#longitude, or: $value.longitude),
    resolvedCity: data.get(#resolvedCity, or: $value.resolvedCity),
    resolvedAddress: data.get(#resolvedAddress, or: $value.resolvedAddress),
    isResolvingLocation: data.get(
      #isResolvingLocation,
      or: $value.isResolvingLocation,
    ),
    logoPath: data.get(#logoPath, or: $value.logoPath),
    coverPhotoPath: data.get(#coverPhotoPath, or: $value.coverPhotoPath),
    businessPhotoPaths: data.get(
      #businessPhotoPaths,
      or: $value.businessPhotoPaths,
    ),
    isLoading: data.get(#isLoading, or: $value.isLoading),
    isSuccess: data.get(#isSuccess, or: $value.isSuccess),
    errorMessage: data.get(#errorMessage, or: $value.errorMessage),
    successMessage: data.get(#successMessage, or: $value.successMessage),
    hasExistingBusiness: data.get(
      #hasExistingBusiness,
      or: $value.hasExistingBusiness,
    ),
    isCheckingExistingBusiness: data.get(
      #isCheckingExistingBusiness,
      or: $value.isCheckingExistingBusiness,
    ),
  );

  @override
  AddBusinessStateCopyWith<$R2, AddBusinessState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AddBusinessStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

