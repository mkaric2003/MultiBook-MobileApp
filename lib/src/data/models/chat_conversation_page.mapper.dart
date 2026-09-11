// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'chat_conversation_page.dart';

class ChatConversationPageMapper extends ClassMapperBase<ChatConversationPage> {
  ChatConversationPageMapper._();

  static ChatConversationPageMapper? _instance;
  static ChatConversationPageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChatConversationPageMapper._());
      ChatConversationModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ChatConversationPage';

  static List<ChatConversationModel> _$items(ChatConversationPage v) => v.items;
  static const Field<ChatConversationPage, List<ChatConversationModel>>
  _f$items = Field('items', _$items);
  static String? _$nextCursor(ChatConversationPage v) => v.nextCursor;
  static const Field<ChatConversationPage, String> _f$nextCursor = Field(
    'nextCursor',
    _$nextCursor,
    opt: true,
  );

  @override
  final MappableFields<ChatConversationPage> fields = const {
    #items: _f$items,
    #nextCursor: _f$nextCursor,
  };

  static ChatConversationPage _instantiate(DecodingData data) {
    return ChatConversationPage(
      items: data.dec(_f$items),
      nextCursor: data.dec(_f$nextCursor),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ChatConversationPage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChatConversationPage>(map);
  }

  static ChatConversationPage fromJson(String json) {
    return ensureInitialized().decodeJson<ChatConversationPage>(json);
  }
}
mixin ChatConversationPageMappable {
  String toJson() {
    return ChatConversationPageMapper.ensureInitialized()
        .encodeJson<ChatConversationPage>(this as ChatConversationPage);
  }

  Map<String, dynamic> toMap() {
    return ChatConversationPageMapper.ensureInitialized()
        .encodeMap<ChatConversationPage>(this as ChatConversationPage);
  }

  ChatConversationPageCopyWith<
    ChatConversationPage,
    ChatConversationPage,
    ChatConversationPage
  >
  get copyWith =>
      _ChatConversationPageCopyWithImpl<
        ChatConversationPage,
        ChatConversationPage
      >(this as ChatConversationPage, $identity, $identity);
  @override
  String toString() {
    return ChatConversationPageMapper.ensureInitialized().stringifyValue(
      this as ChatConversationPage,
    );
  }

  @override
  bool operator ==(Object other) {
    return ChatConversationPageMapper.ensureInitialized().equalsValue(
      this as ChatConversationPage,
      other,
    );
  }

  @override
  int get hashCode {
    return ChatConversationPageMapper.ensureInitialized().hashValue(
      this as ChatConversationPage,
    );
  }
}

extension ChatConversationPageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChatConversationPage, $Out> {
  ChatConversationPageCopyWith<$R, ChatConversationPage, $Out>
  get $asChatConversationPage => $base.as(
    (v, t, t2) => _ChatConversationPageCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ChatConversationPageCopyWith<
  $R,
  $In extends ChatConversationPage,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    ChatConversationModel,
    ChatConversationModelCopyWith<
      $R,
      ChatConversationModel,
      ChatConversationModel
    >
  >
  get items;
  $R call({List<ChatConversationModel>? items, String? nextCursor});
  ChatConversationPageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ChatConversationPageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChatConversationPage, $Out>
    implements ChatConversationPageCopyWith<$R, ChatConversationPage, $Out> {
  _ChatConversationPageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChatConversationPage> $mapper =
      ChatConversationPageMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    ChatConversationModel,
    ChatConversationModelCopyWith<
      $R,
      ChatConversationModel,
      ChatConversationModel
    >
  >
  get items => ListCopyWith(
    $value.items,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(items: v),
  );
  @override
  $R call({List<ChatConversationModel>? items, Object? nextCursor = $none}) =>
      $apply(
        FieldCopyWithData({
          if (items != null) #items: items,
          if (nextCursor != $none) #nextCursor: nextCursor,
        }),
      );
  @override
  ChatConversationPage $make(CopyWithData data) => ChatConversationPage(
    items: data.get(#items, or: $value.items),
    nextCursor: data.get(#nextCursor, or: $value.nextCursor),
  );

  @override
  ChatConversationPageCopyWith<$R2, ChatConversationPage, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ChatConversationPageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
