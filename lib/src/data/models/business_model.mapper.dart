// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'business_model.dart';

class BusinessModelMapper extends ClassMapperBase<BusinessModel> {
  BusinessModelMapper._();

  static BusinessModelMapper? _instance;
  static BusinessModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BusinessModelMapper._());
      BusinessTypeMapper.ensureInitialized();
      BusinessLocationModelMapper.ensureInitialized();
      StayDetailsModelMapper.ensureInitialized();
      ServiceDetailsModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BusinessModel';

  static String _$id(BusinessModel v) => v.id;
  static const Field<BusinessModel, String> _f$id = Field('id', _$id);
  static String _$ownerId(BusinessModel v) => v.ownerId;
  static const Field<BusinessModel, String> _f$ownerId = Field(
    'ownerId',
    _$ownerId,
  );
  static BusinessType _$type(BusinessModel v) => v.type;
  static const Field<BusinessModel, BusinessType> _f$type = Field(
    'type',
    _$type,
  );
  static String _$name(BusinessModel v) => v.name;
  static const Field<BusinessModel, String> _f$name = Field('name', _$name);
  static String _$categoryId(BusinessModel v) => v.categoryId;
  static const Field<BusinessModel, String> _f$categoryId = Field(
    'categoryId',
    _$categoryId,
  );
  static BusinessLocationModel _$location(BusinessModel v) => v.location;
  static const Field<BusinessModel, BusinessLocationModel> _f$location = Field(
    'location',
    _$location,
  );
  static CurrencyCode _$currency(BusinessModel v) => v.currency;
  static const Field<BusinessModel, CurrencyCode> _f$currency = Field(
    'currency',
    _$currency,
    opt: true,
    def: CurrencyCode.bam,
  );
  static String? _$shortDescription(BusinessModel v) => v.shortDescription;
  static const Field<BusinessModel, String> _f$shortDescription = Field(
    'shortDescription',
    _$shortDescription,
    opt: true,
  );
  static String? _$logoUrl(BusinessModel v) => v.logoUrl;
  static const Field<BusinessModel, String> _f$logoUrl = Field(
    'logoUrl',
    _$logoUrl,
    opt: true,
  );
  static String? _$coverPhotoUrl(BusinessModel v) => v.coverPhotoUrl;
  static const Field<BusinessModel, String> _f$coverPhotoUrl = Field(
    'coverPhotoUrl',
    _$coverPhotoUrl,
    opt: true,
  );
  static List<String> _$photoUrls(BusinessModel v) => v.photoUrls;
  static const Field<BusinessModel, List<String>> _f$photoUrls = Field(
    'photoUrls',
    _$photoUrls,
    opt: true,
    def: const [],
  );
  static List<String> _$featuredCollectionIds(BusinessModel v) =>
      v.featuredCollectionIds;
  static const Field<BusinessModel, List<String>> _f$featuredCollectionIds =
      Field(
        'featuredCollectionIds',
        _$featuredCollectionIds,
        opt: true,
        def: const [],
      );
  static bool _$isActive(BusinessModel v) => v.isActive;
  static const Field<BusinessModel, bool> _f$isActive = Field(
    'isActive',
    _$isActive,
    opt: true,
    def: true,
  );
  static double _$averageRating(BusinessModel v) => v.averageRating;
  static const Field<BusinessModel, double> _f$averageRating = Field(
    'averageRating',
    _$averageRating,
    opt: true,
    def: 0,
  );
  static int _$reviewCount(BusinessModel v) => v.reviewCount;
  static const Field<BusinessModel, int> _f$reviewCount = Field(
    'reviewCount',
    _$reviewCount,
    opt: true,
    def: 0,
  );
  static StayDetailsModel? _$stayDetails(BusinessModel v) => v.stayDetails;
  static const Field<BusinessModel, StayDetailsModel> _f$stayDetails = Field(
    'stayDetails',
    _$stayDetails,
    opt: true,
  );
  static ServiceDetailsModel? _$serviceDetails(BusinessModel v) =>
      v.serviceDetails;
  static const Field<BusinessModel, ServiceDetailsModel> _f$serviceDetails =
      Field('serviceDetails', _$serviceDetails, opt: true);
  static DateTime? _$createdAt(BusinessModel v) => v.createdAt;
  static const Field<BusinessModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );
  static DateTime? _$updatedAt(BusinessModel v) => v.updatedAt;
  static const Field<BusinessModel, DateTime> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );

  @override
  final MappableFields<BusinessModel> fields = const {
    #id: _f$id,
    #ownerId: _f$ownerId,
    #type: _f$type,
    #name: _f$name,
    #categoryId: _f$categoryId,
    #location: _f$location,
    #currency: _f$currency,
    #shortDescription: _f$shortDescription,
    #logoUrl: _f$logoUrl,
    #coverPhotoUrl: _f$coverPhotoUrl,
    #photoUrls: _f$photoUrls,
    #featuredCollectionIds: _f$featuredCollectionIds,
    #isActive: _f$isActive,
    #averageRating: _f$averageRating,
    #reviewCount: _f$reviewCount,
    #stayDetails: _f$stayDetails,
    #serviceDetails: _f$serviceDetails,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static BusinessModel _instantiate(DecodingData data) {
    return BusinessModel(
      id: data.dec(_f$id),
      ownerId: data.dec(_f$ownerId),
      type: data.dec(_f$type),
      name: data.dec(_f$name),
      categoryId: data.dec(_f$categoryId),
      location: data.dec(_f$location),
      currency: data.dec(_f$currency),
      shortDescription: data.dec(_f$shortDescription),
      logoUrl: data.dec(_f$logoUrl),
      coverPhotoUrl: data.dec(_f$coverPhotoUrl),
      photoUrls: data.dec(_f$photoUrls),
      featuredCollectionIds: data.dec(_f$featuredCollectionIds),
      isActive: data.dec(_f$isActive),
      averageRating: data.dec(_f$averageRating),
      reviewCount: data.dec(_f$reviewCount),
      stayDetails: data.dec(_f$stayDetails),
      serviceDetails: data.dec(_f$serviceDetails),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BusinessModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BusinessModel>(map);
  }

  static BusinessModel fromJson(String json) {
    return ensureInitialized().decodeJson<BusinessModel>(json);
  }
}

mixin BusinessModelMappable {
  String toJson() {
    return BusinessModelMapper.ensureInitialized().encodeJson<BusinessModel>(
      this as BusinessModel,
    );
  }

  Map<String, dynamic> toMap() {
    return BusinessModelMapper.ensureInitialized().encodeMap<BusinessModel>(
      this as BusinessModel,
    );
  }

  BusinessModelCopyWith<BusinessModel, BusinessModel, BusinessModel>
  get copyWith => _BusinessModelCopyWithImpl<BusinessModel, BusinessModel>(
    this as BusinessModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return BusinessModelMapper.ensureInitialized().stringifyValue(
      this as BusinessModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return BusinessModelMapper.ensureInitialized().equalsValue(
      this as BusinessModel,
      other,
    );
  }

  @override
  int get hashCode {
    return BusinessModelMapper.ensureInitialized().hashValue(
      this as BusinessModel,
    );
  }
}

extension BusinessModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BusinessModel, $Out> {
  BusinessModelCopyWith<$R, BusinessModel, $Out> get $asBusinessModel =>
      $base.as((v, t, t2) => _BusinessModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BusinessModelCopyWith<$R, $In extends BusinessModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  BusinessLocationModelCopyWith<
    $R,
    BusinessLocationModel,
    BusinessLocationModel
  >
  get location;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get photoUrls;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get featuredCollectionIds;
  StayDetailsModelCopyWith<$R, StayDetailsModel, StayDetailsModel>?
  get stayDetails;
  ServiceDetailsModelCopyWith<$R, ServiceDetailsModel, ServiceDetailsModel>?
  get serviceDetails;
  $R call({
    String? id,
    String? ownerId,
    BusinessType? type,
    String? name,
    String? categoryId,
    BusinessLocationModel? location,
    CurrencyCode? currency,
    String? shortDescription,
    String? logoUrl,
    String? coverPhotoUrl,
    List<String>? photoUrls,
    List<String>? featuredCollectionIds,
    bool? isActive,
    double? averageRating,
    int? reviewCount,
    StayDetailsModel? stayDetails,
    ServiceDetailsModel? serviceDetails,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  BusinessModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BusinessModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BusinessModel, $Out>
    implements BusinessModelCopyWith<$R, BusinessModel, $Out> {
  _BusinessModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BusinessModel> $mapper =
      BusinessModelMapper.ensureInitialized();
  @override
  BusinessLocationModelCopyWith<
    $R,
    BusinessLocationModel,
    BusinessLocationModel
  >
  get location => $value.location.copyWith.$chain((v) => call(location: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get photoUrls =>
      ListCopyWith(
        $value.photoUrls,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(photoUrls: v),
      );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get featuredCollectionIds => ListCopyWith(
    $value.featuredCollectionIds,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(featuredCollectionIds: v),
  );
  @override
  StayDetailsModelCopyWith<$R, StayDetailsModel, StayDetailsModel>?
  get stayDetails =>
      $value.stayDetails?.copyWith.$chain((v) => call(stayDetails: v));
  @override
  ServiceDetailsModelCopyWith<$R, ServiceDetailsModel, ServiceDetailsModel>?
  get serviceDetails =>
      $value.serviceDetails?.copyWith.$chain((v) => call(serviceDetails: v));
  @override
  $R call({
    String? id,
    String? ownerId,
    BusinessType? type,
    String? name,
    String? categoryId,
    BusinessLocationModel? location,
    CurrencyCode? currency,
    Object? shortDescription = $none,
    Object? logoUrl = $none,
    Object? coverPhotoUrl = $none,
    List<String>? photoUrls,
    List<String>? featuredCollectionIds,
    bool? isActive,
    double? averageRating,
    int? reviewCount,
    Object? stayDetails = $none,
    Object? serviceDetails = $none,
    Object? createdAt = $none,
    Object? updatedAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (ownerId != null) #ownerId: ownerId,
      if (type != null) #type: type,
      if (name != null) #name: name,
      if (categoryId != null) #categoryId: categoryId,
      if (location != null) #location: location,
      if (currency != null) #currency: currency,
      if (shortDescription != $none) #shortDescription: shortDescription,
      if (logoUrl != $none) #logoUrl: logoUrl,
      if (coverPhotoUrl != $none) #coverPhotoUrl: coverPhotoUrl,
      if (photoUrls != null) #photoUrls: photoUrls,
      if (featuredCollectionIds != null)
        #featuredCollectionIds: featuredCollectionIds,
      if (isActive != null) #isActive: isActive,
      if (averageRating != null) #averageRating: averageRating,
      if (reviewCount != null) #reviewCount: reviewCount,
      if (stayDetails != $none) #stayDetails: stayDetails,
      if (serviceDetails != $none) #serviceDetails: serviceDetails,
      if (createdAt != $none) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
    }),
  );
  @override
  BusinessModel $make(CopyWithData data) => BusinessModel(
    id: data.get(#id, or: $value.id),
    ownerId: data.get(#ownerId, or: $value.ownerId),
    type: data.get(#type, or: $value.type),
    name: data.get(#name, or: $value.name),
    categoryId: data.get(#categoryId, or: $value.categoryId),
    location: data.get(#location, or: $value.location),
    currency: data.get(#currency, or: $value.currency),
    shortDescription: data.get(#shortDescription, or: $value.shortDescription),
    logoUrl: data.get(#logoUrl, or: $value.logoUrl),
    coverPhotoUrl: data.get(#coverPhotoUrl, or: $value.coverPhotoUrl),
    photoUrls: data.get(#photoUrls, or: $value.photoUrls),
    featuredCollectionIds: data.get(
      #featuredCollectionIds,
      or: $value.featuredCollectionIds,
    ),
    isActive: data.get(#isActive, or: $value.isActive),
    averageRating: data.get(#averageRating, or: $value.averageRating),
    reviewCount: data.get(#reviewCount, or: $value.reviewCount),
    stayDetails: data.get(#stayDetails, or: $value.stayDetails),
    serviceDetails: data.get(#serviceDetails, or: $value.serviceDetails),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  BusinessModelCopyWith<$R2, BusinessModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BusinessModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

