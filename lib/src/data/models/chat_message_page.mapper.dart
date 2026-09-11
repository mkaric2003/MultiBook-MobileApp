// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'chat_message_page.dart';

class ChatMessagePageMapper extends ClassMapperBase<ChatMessagePage> {
  ChatMessagePageMapper._();

  static ChatMessagePageMapper? _instance;
  static ChatMessagePageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChatMessagePageMapper._());
      ChatMessageModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ChatMessagePage';

  static List<ChatMessageModel> _$items(ChatMessagePage v) => v.items;
  static const Field<ChatMessagePage, List<ChatMessageModel>> _f$items = Field(
    'items',
    _$items,
  );
  static String? _$nextCursor(ChatMessagePage v) => v.nextCursor;
  static const Field<ChatMessagePage, String> _f$nextCursor = Field(
    'nextCursor',
    _$nextCursor,
    opt: true,
  );

  @override
  final MappableFields<ChatMessagePage> fields = const {
    #items: _f$items,
    #nextCursor: _f$nextCursor,
  };

  static ChatMessagePage _instantiate(DecodingData data) {
    return ChatMessagePage(
      items: data.dec(_f$items),
      nextCursor: data.dec(_f$nextCursor),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ChatMessagePage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChatMessagePage>(map);
  }

  static ChatMessagePage fromJson(String json) {
    return ensureInitialized().decodeJson<ChatMessagePage>(json);
  }
}
mixin ChatMessagePageMappable {
  String toJson() {
    return ChatMessagePageMapper.ensureInitialized()
        .encodeJson<ChatMessagePage>(this as ChatMessagePage);
  }

  Map<String, dynamic> toMap() {
    return ChatMessagePageMapper.ensureInitialized().encodeMap<ChatMessagePage>(
      this as ChatMessagePage,
    );
  }

  ChatMessagePageCopyWith<ChatMessagePage, ChatMessagePage, ChatMessagePage>
  get copyWith =>
      _ChatMessagePageCopyWithImpl<ChatMessagePage, ChatMessagePage>(
        this as ChatMessagePage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ChatMessagePageMapper.ensureInitialized().stringifyValue(
      this as ChatMessagePage,
    );
  }

  @override
  bool operator ==(Object other) {
    return ChatMessagePageMapper.ensureInitialized().equalsValue(
      this as ChatMessagePage,
      other,
    );
  }

  @override
  int get hashCode {
    return ChatMessagePageMapper.ensureInitialized().hashValue(
      this as ChatMessagePage,
    );
  }
}

extension ChatMessagePageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChatMessagePage, $Out> {
  ChatMessagePageCopyWith<$R, ChatMessagePage, $Out> get $asChatMessagePage =>
      $base.as((v, t, t2) => _ChatMessagePageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ChatMessagePageCopyWith<$R, $In extends ChatMessagePage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    ChatMessageModel,
    ChatMessageModelCopyWith<$R, ChatMessageModel, ChatMessageModel>
  >
  get items;
  $R call({List<ChatMessageModel>? items, String? nextCursor});
  ChatMessagePageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ChatMessagePageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChatMessagePage, $Out>
    implements ChatMessagePageCopyWith<$R, ChatMessagePage, $Out> {
  _ChatMessagePageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChatMessagePage> $mapper =
      ChatMessagePageMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    ChatMessageModel,
    ChatMessageModelCopyWith<$R, ChatMessageModel, ChatMessageModel>
  >
  get items => ListCopyWith(
    $value.items,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(items: v),
  );
  @override
  $R call({List<ChatMessageModel>? items, Object? nextCursor = $none}) =>
      $apply(
        FieldCopyWithData({
          if (items != null) #items: items,
          if (nextCursor != $none) #nextCursor: nextCursor,
        }),
      );
  @override
  ChatMessagePage $make(CopyWithData data) => ChatMessagePage(
    items: data.get(#items, or: $value.items),
    nextCursor: data.get(#nextCursor, or: $value.nextCursor),
  );

  @override
  ChatMessagePageCopyWith<$R2, ChatMessagePage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ChatMessagePageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
