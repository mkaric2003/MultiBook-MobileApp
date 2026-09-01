// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'app_notification_model.dart';

class AppNotificationModelMapper extends ClassMapperBase<AppNotificationModel> {
  AppNotificationModelMapper._();

  static AppNotificationModelMapper? _instance;
  static AppNotificationModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppNotificationModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AppNotificationModel';

  static String _$id(AppNotificationModel v) => v.id;
  static const Field<AppNotificationModel, String> _f$id = Field('id', _$id);
  static String _$kind(AppNotificationModel v) => v.kind;
  static const Field<AppNotificationModel, String> _f$kind = Field(
    'kind',
    _$kind,
  );
  static String _$title(AppNotificationModel v) => v.title;
  static const Field<AppNotificationModel, String> _f$title = Field(
    'title',
    _$title,
  );
  static String _$body(AppNotificationModel v) => v.body;
  static const Field<AppNotificationModel, String> _f$body = Field(
    'body',
    _$body,
  );
  static Map<String, String> _$data(AppNotificationModel v) => v.data;
  static const Field<AppNotificationModel, Map<String, String>> _f$data = Field(
    'data',
    _$data,
  );
  static DateTime _$createdAt(AppNotificationModel v) => v.createdAt;
  static const Field<AppNotificationModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static DateTime? _$readAt(AppNotificationModel v) => v.readAt;
  static const Field<AppNotificationModel, DateTime> _f$readAt = Field(
    'readAt',
    _$readAt,
    opt: true,
  );

  @override
  final MappableFields<AppNotificationModel> fields = const {
    #id: _f$id,
    #kind: _f$kind,
    #title: _f$title,
    #body: _f$body,
    #data: _f$data,
    #createdAt: _f$createdAt,
    #readAt: _f$readAt,
  };

  static AppNotificationModel _instantiate(DecodingData data) {
    return AppNotificationModel(
      id: data.dec(_f$id),
      kind: data.dec(_f$kind),
      title: data.dec(_f$title),
      body: data.dec(_f$body),
      data: data.dec(_f$data),
      createdAt: data.dec(_f$createdAt),
      readAt: data.dec(_f$readAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppNotificationModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppNotificationModel>(map);
  }

  static AppNotificationModel fromJson(String json) {
    return ensureInitialized().decodeJson<AppNotificationModel>(json);
  }
}

mixin AppNotificationModelMappable {
  String toJson() {
    return AppNotificationModelMapper.ensureInitialized()
        .encodeJson<AppNotificationModel>(this as AppNotificationModel);
  }

  Map<String, dynamic> toMap() {
    return AppNotificationModelMapper.ensureInitialized()
        .encodeMap<AppNotificationModel>(this as AppNotificationModel);
  }

  AppNotificationModelCopyWith<
    AppNotificationModel,
    AppNotificationModel,
    AppNotificationModel
  >
  get copyWith =>
      _AppNotificationModelCopyWithImpl<
        AppNotificationModel,
        AppNotificationModel
      >(this as AppNotificationModel, $identity, $identity);
  @override
  String toString() {
    return AppNotificationModelMapper.ensureInitialized().stringifyValue(
      this as AppNotificationModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppNotificationModelMapper.ensureInitialized().equalsValue(
      this as AppNotificationModel,
      other,
    );
  }

  @override
  int get hashCode {
    return AppNotificationModelMapper.ensureInitialized().hashValue(
      this as AppNotificationModel,
    );
  }
}

extension AppNotificationModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppNotificationModel, $Out> {
  AppNotificationModelCopyWith<$R, AppNotificationModel, $Out>
  get $asAppNotificationModel => $base.as(
    (v, t, t2) => _AppNotificationModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AppNotificationModelCopyWith<
  $R,
  $In extends AppNotificationModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>> get data;
  $R call({
    String? id,
    String? kind,
    String? title,
    String? body,
    Map<String, String>? data,
    DateTime? createdAt,
    DateTime? readAt,
  });
  AppNotificationModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppNotificationModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppNotificationModel, $Out>
    implements AppNotificationModelCopyWith<$R, AppNotificationModel, $Out> {
  _AppNotificationModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppNotificationModel> $mapper =
      AppNotificationModelMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>
  get data => MapCopyWith(
    $value.data,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(data: v),
  );
  @override
  $R call({
    String? id,
    String? kind,
    String? title,
    String? body,
    Map<String, String>? data,
    DateTime? createdAt,
    Object? readAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (kind != null) #kind: kind,
      if (title != null) #title: title,
      if (body != null) #body: body,
      if (data != null) #data: data,
      if (createdAt != null) #createdAt: createdAt,
      if (readAt != $none) #readAt: readAt,
    }),
  );
  @override
  AppNotificationModel $make(CopyWithData data) => AppNotificationModel(
    id: data.get(#id, or: $value.id),
    kind: data.get(#kind, or: $value.kind),
    title: data.get(#title, or: $value.title),
    body: data.get(#body, or: $value.body),
    data: data.get(#data, or: $value.data),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    readAt: data.get(#readAt, or: $value.readAt),
  );

  @override
  AppNotificationModelCopyWith<$R2, AppNotificationModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AppNotificationModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

