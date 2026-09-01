// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'app_notification_list_response.dart';

class AppNotificationListResponseMapper
    extends ClassMapperBase<AppNotificationListResponse> {
  AppNotificationListResponseMapper._();

  static AppNotificationListResponseMapper? _instance;
  static AppNotificationListResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = AppNotificationListResponseMapper._(),
      );
      AppNotificationModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AppNotificationListResponse';

  static List<AppNotificationModel> _$items(AppNotificationListResponse v) =>
      v.items;
  static const Field<AppNotificationListResponse, List<AppNotificationModel>>
  _f$items = Field('items', _$items);
  static String? _$nextCursor(AppNotificationListResponse v) => v.nextCursor;
  static const Field<AppNotificationListResponse, String> _f$nextCursor = Field(
    'nextCursor',
    _$nextCursor,
    opt: true,
  );

  @override
  final MappableFields<AppNotificationListResponse> fields = const {
    #items: _f$items,
    #nextCursor: _f$nextCursor,
  };

  static AppNotificationListResponse _instantiate(DecodingData data) {
    return AppNotificationListResponse(
      items: data.dec(_f$items),
      nextCursor: data.dec(_f$nextCursor),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppNotificationListResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppNotificationListResponse>(map);
  }

  static AppNotificationListResponse fromJson(String json) {
    return ensureInitialized().decodeJson<AppNotificationListResponse>(json);
  }
}

mixin AppNotificationListResponseMappable {
  String toJson() {
    return AppNotificationListResponseMapper.ensureInitialized()
        .encodeJson<AppNotificationListResponse>(
          this as AppNotificationListResponse,
        );
  }

  Map<String, dynamic> toMap() {
    return AppNotificationListResponseMapper.ensureInitialized()
        .encodeMap<AppNotificationListResponse>(
          this as AppNotificationListResponse,
        );
  }

  AppNotificationListResponseCopyWith<
    AppNotificationListResponse,
    AppNotificationListResponse,
    AppNotificationListResponse
  >
  get copyWith =>
      _AppNotificationListResponseCopyWithImpl<
        AppNotificationListResponse,
        AppNotificationListResponse
      >(this as AppNotificationListResponse, $identity, $identity);
  @override
  String toString() {
    return AppNotificationListResponseMapper.ensureInitialized().stringifyValue(
      this as AppNotificationListResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppNotificationListResponseMapper.ensureInitialized().equalsValue(
      this as AppNotificationListResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return AppNotificationListResponseMapper.ensureInitialized().hashValue(
      this as AppNotificationListResponse,
    );
  }
}

extension AppNotificationListResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppNotificationListResponse, $Out> {
  AppNotificationListResponseCopyWith<$R, AppNotificationListResponse, $Out>
  get $asAppNotificationListResponse => $base.as(
    (v, t, t2) => _AppNotificationListResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AppNotificationListResponseCopyWith<
  $R,
  $In extends AppNotificationListResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    AppNotificationModel,
    AppNotificationModelCopyWith<$R, AppNotificationModel, AppNotificationModel>
  >
  get items;
  $R call({List<AppNotificationModel>? items, String? nextCursor});
  AppNotificationListResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppNotificationListResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppNotificationListResponse, $Out>
    implements
        AppNotificationListResponseCopyWith<
          $R,
          AppNotificationListResponse,
          $Out
        > {
  _AppNotificationListResponseCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<AppNotificationListResponse> $mapper =
      AppNotificationListResponseMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    AppNotificationModel,
    AppNotificationModelCopyWith<$R, AppNotificationModel, AppNotificationModel>
  >
  get items => ListCopyWith(
    $value.items,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(items: v),
  );
  @override
  $R call({List<AppNotificationModel>? items, Object? nextCursor = $none}) =>
      $apply(
        FieldCopyWithData({
          if (items != null) #items: items,
          if (nextCursor != $none) #nextCursor: nextCursor,
        }),
      );
  @override
  AppNotificationListResponse $make(CopyWithData data) =>
      AppNotificationListResponse(
        items: data.get(#items, or: $value.items),
        nextCursor: data.get(#nextCursor, or: $value.nextCursor),
      );

  @override
  AppNotificationListResponseCopyWith<$R2, AppNotificationListResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AppNotificationListResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

