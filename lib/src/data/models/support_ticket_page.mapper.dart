// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'support_ticket_page.dart';

class SupportTicketPageMapper extends ClassMapperBase<SupportTicketPage> {
  SupportTicketPageMapper._();

  static SupportTicketPageMapper? _instance;
  static SupportTicketPageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SupportTicketPageMapper._());
      SupportTicketModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SupportTicketPage';

  static List<SupportTicketModel> _$items(SupportTicketPage v) => v.items;
  static const Field<SupportTicketPage, List<SupportTicketModel>> _f$items =
      Field('items', _$items);
  static String? _$nextCursor(SupportTicketPage v) => v.nextCursor;
  static const Field<SupportTicketPage, String> _f$nextCursor = Field(
    'nextCursor',
    _$nextCursor,
    opt: true,
  );

  @override
  final MappableFields<SupportTicketPage> fields = const {
    #items: _f$items,
    #nextCursor: _f$nextCursor,
  };

  static SupportTicketPage _instantiate(DecodingData data) {
    return SupportTicketPage(
      items: data.dec(_f$items),
      nextCursor: data.dec(_f$nextCursor),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SupportTicketPage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SupportTicketPage>(map);
  }

  static SupportTicketPage fromJson(String json) {
    return ensureInitialized().decodeJson<SupportTicketPage>(json);
  }
}
mixin SupportTicketPageMappable {
  String toJson() {
    return SupportTicketPageMapper.ensureInitialized()
        .encodeJson<SupportTicketPage>(this as SupportTicketPage);
  }

  Map<String, dynamic> toMap() {
    return SupportTicketPageMapper.ensureInitialized()
        .encodeMap<SupportTicketPage>(this as SupportTicketPage);
  }

  SupportTicketPageCopyWith<
    SupportTicketPage,
    SupportTicketPage,
    SupportTicketPage
  >
  get copyWith =>
      _SupportTicketPageCopyWithImpl<SupportTicketPage, SupportTicketPage>(
        this as SupportTicketPage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SupportTicketPageMapper.ensureInitialized().stringifyValue(
      this as SupportTicketPage,
    );
  }

  @override
  bool operator ==(Object other) {
    return SupportTicketPageMapper.ensureInitialized().equalsValue(
      this as SupportTicketPage,
      other,
    );
  }

  @override
  int get hashCode {
    return SupportTicketPageMapper.ensureInitialized().hashValue(
      this as SupportTicketPage,
    );
  }
}

extension SupportTicketPageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SupportTicketPage, $Out> {
  SupportTicketPageCopyWith<$R, SupportTicketPage, $Out>
  get $asSupportTicketPage => $base.as(
    (v, t, t2) => _SupportTicketPageCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class SupportTicketPageCopyWith<
  $R,
  $In extends SupportTicketPage,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    SupportTicketModel,
    SupportTicketModelCopyWith<$R, SupportTicketModel, SupportTicketModel>
  >
  get items;
  $R call({List<SupportTicketModel>? items, String? nextCursor});
  SupportTicketPageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SupportTicketPageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SupportTicketPage, $Out>
    implements SupportTicketPageCopyWith<$R, SupportTicketPage, $Out> {
  _SupportTicketPageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SupportTicketPage> $mapper =
      SupportTicketPageMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    SupportTicketModel,
    SupportTicketModelCopyWith<$R, SupportTicketModel, SupportTicketModel>
  >
  get items => ListCopyWith(
    $value.items,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(items: v),
  );
  @override
  $R call({List<SupportTicketModel>? items, Object? nextCursor = $none}) =>
      $apply(
        FieldCopyWithData({
          if (items != null) #items: items,
          if (nextCursor != $none) #nextCursor: nextCursor,
        }),
      );
  @override
  SupportTicketPage $make(CopyWithData data) => SupportTicketPage(
    items: data.get(#items, or: $value.items),
    nextCursor: data.get(#nextCursor, or: $value.nextCursor),
  );

  @override
  SupportTicketPageCopyWith<$R2, SupportTicketPage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SupportTicketPageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
