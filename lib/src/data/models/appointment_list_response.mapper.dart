// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'appointment_list_response.dart';

class AppointmentListResponseMapper
    extends ClassMapperBase<AppointmentListResponse> {
  AppointmentListResponseMapper._();

  static AppointmentListResponseMapper? _instance;
  static AppointmentListResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = AppointmentListResponseMapper._(),
      );
      AppointmentModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AppointmentListResponse';

  static List<AppointmentModel> _$items(AppointmentListResponse v) => v.items;
  static const Field<AppointmentListResponse, List<AppointmentModel>> _f$items =
      Field('items', _$items);
  static String? _$nextCursor(AppointmentListResponse v) => v.nextCursor;
  static const Field<AppointmentListResponse, String> _f$nextCursor = Field(
    'nextCursor',
    _$nextCursor,
    opt: true,
  );

  @override
  final MappableFields<AppointmentListResponse> fields = const {
    #items: _f$items,
    #nextCursor: _f$nextCursor,
  };

  static AppointmentListResponse _instantiate(DecodingData data) {
    return AppointmentListResponse(
      items: data.dec(_f$items),
      nextCursor: data.dec(_f$nextCursor),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppointmentListResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppointmentListResponse>(map);
  }

  static AppointmentListResponse fromJson(String json) {
    return ensureInitialized().decodeJson<AppointmentListResponse>(json);
  }
}

mixin AppointmentListResponseMappable {
  String toJson() {
    return AppointmentListResponseMapper.ensureInitialized()
        .encodeJson<AppointmentListResponse>(this as AppointmentListResponse);
  }

  Map<String, dynamic> toMap() {
    return AppointmentListResponseMapper.ensureInitialized()
        .encodeMap<AppointmentListResponse>(this as AppointmentListResponse);
  }

  AppointmentListResponseCopyWith<
    AppointmentListResponse,
    AppointmentListResponse,
    AppointmentListResponse
  >
  get copyWith =>
      _AppointmentListResponseCopyWithImpl<
        AppointmentListResponse,
        AppointmentListResponse
      >(this as AppointmentListResponse, $identity, $identity);
  @override
  String toString() {
    return AppointmentListResponseMapper.ensureInitialized().stringifyValue(
      this as AppointmentListResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppointmentListResponseMapper.ensureInitialized().equalsValue(
      this as AppointmentListResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return AppointmentListResponseMapper.ensureInitialized().hashValue(
      this as AppointmentListResponse,
    );
  }
}

extension AppointmentListResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppointmentListResponse, $Out> {
  AppointmentListResponseCopyWith<$R, AppointmentListResponse, $Out>
  get $asAppointmentListResponse => $base.as(
    (v, t, t2) => _AppointmentListResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AppointmentListResponseCopyWith<
  $R,
  $In extends AppointmentListResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    AppointmentModel,
    AppointmentModelCopyWith<$R, AppointmentModel, AppointmentModel>
  >
  get items;
  $R call({List<AppointmentModel>? items, String? nextCursor});
  AppointmentListResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppointmentListResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppointmentListResponse, $Out>
    implements
        AppointmentListResponseCopyWith<$R, AppointmentListResponse, $Out> {
  _AppointmentListResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppointmentListResponse> $mapper =
      AppointmentListResponseMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    AppointmentModel,
    AppointmentModelCopyWith<$R, AppointmentModel, AppointmentModel>
  >
  get items => ListCopyWith(
    $value.items,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(items: v),
  );
  @override
  $R call({List<AppointmentModel>? items, Object? nextCursor = $none}) =>
      $apply(
        FieldCopyWithData({
          if (items != null) #items: items,
          if (nextCursor != $none) #nextCursor: nextCursor,
        }),
      );
  @override
  AppointmentListResponse $make(CopyWithData data) => AppointmentListResponse(
    items: data.get(#items, or: $value.items),
    nextCursor: data.get(#nextCursor, or: $value.nextCursor),
  );

  @override
  AppointmentListResponseCopyWith<$R2, AppointmentListResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AppointmentListResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

