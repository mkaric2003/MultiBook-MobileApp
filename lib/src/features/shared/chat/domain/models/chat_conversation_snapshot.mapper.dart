// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'chat_conversation_snapshot.dart';

class ChatConversationSnapshotMapper
    extends ClassMapperBase<ChatConversationSnapshot> {
  ChatConversationSnapshotMapper._();

  static ChatConversationSnapshotMapper? _instance;
  static ChatConversationSnapshotMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = ChatConversationSnapshotMapper._(),
      );
      ChatConversationModelMapper.ensureInitialized();
      ChatMessageModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ChatConversationSnapshot';

  static ChatConversationModel _$conversation(ChatConversationSnapshot v) =>
      v.conversation;
  static const Field<ChatConversationSnapshot, ChatConversationModel>
  _f$conversation = Field('conversation', _$conversation);
  static List<ChatMessageModel> _$messages(ChatConversationSnapshot v) =>
      v.messages;
  static const Field<ChatConversationSnapshot, List<ChatMessageModel>>
  _f$messages = Field('messages', _$messages);

  @override
  final MappableFields<ChatConversationSnapshot> fields = const {
    #conversation: _f$conversation,
    #messages: _f$messages,
  };

  static ChatConversationSnapshot _instantiate(DecodingData data) {
    return ChatConversationSnapshot(
      conversation: data.dec(_f$conversation),
      messages: data.dec(_f$messages),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ChatConversationSnapshot fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChatConversationSnapshot>(map);
  }

  static ChatConversationSnapshot fromJson(String json) {
    return ensureInitialized().decodeJson<ChatConversationSnapshot>(json);
  }
}
mixin ChatConversationSnapshotMappable {
  String toJson() {
    return ChatConversationSnapshotMapper.ensureInitialized()
        .encodeJson<ChatConversationSnapshot>(this as ChatConversationSnapshot);
  }

  Map<String, dynamic> toMap() {
    return ChatConversationSnapshotMapper.ensureInitialized()
        .encodeMap<ChatConversationSnapshot>(this as ChatConversationSnapshot);
  }

  ChatConversationSnapshotCopyWith<
    ChatConversationSnapshot,
    ChatConversationSnapshot,
    ChatConversationSnapshot
  >
  get copyWith =>
      _ChatConversationSnapshotCopyWithImpl<
        ChatConversationSnapshot,
        ChatConversationSnapshot
      >(this as ChatConversationSnapshot, $identity, $identity);
  @override
  String toString() {
    return ChatConversationSnapshotMapper.ensureInitialized().stringifyValue(
      this as ChatConversationSnapshot,
    );
  }

  @override
  bool operator ==(Object other) {
    return ChatConversationSnapshotMapper.ensureInitialized().equalsValue(
      this as ChatConversationSnapshot,
      other,
    );
  }

  @override
  int get hashCode {
    return ChatConversationSnapshotMapper.ensureInitialized().hashValue(
      this as ChatConversationSnapshot,
    );
  }
}

extension ChatConversationSnapshotValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChatConversationSnapshot, $Out> {
  ChatConversationSnapshotCopyWith<$R, ChatConversationSnapshot, $Out>
  get $asChatConversationSnapshot => $base.as(
    (v, t, t2) => _ChatConversationSnapshotCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ChatConversationSnapshotCopyWith<
  $R,
  $In extends ChatConversationSnapshot,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ChatConversationModelCopyWith<
    $R,
    ChatConversationModel,
    ChatConversationModel
  >
  get conversation;
  ListCopyWith<
    $R,
    ChatMessageModel,
    ChatMessageModelCopyWith<$R, ChatMessageModel, ChatMessageModel>
  >
  get messages;
  $R call({
    ChatConversationModel? conversation,
    List<ChatMessageModel>? messages,
  });
  ChatConversationSnapshotCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ChatConversationSnapshotCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChatConversationSnapshot, $Out>
    implements
        ChatConversationSnapshotCopyWith<$R, ChatConversationSnapshot, $Out> {
  _ChatConversationSnapshotCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChatConversationSnapshot> $mapper =
      ChatConversationSnapshotMapper.ensureInitialized();
  @override
  ChatConversationModelCopyWith<
    $R,
    ChatConversationModel,
    ChatConversationModel
  >
  get conversation =>
      $value.conversation.copyWith.$chain((v) => call(conversation: v));
  @override
  ListCopyWith<
    $R,
    ChatMessageModel,
    ChatMessageModelCopyWith<$R, ChatMessageModel, ChatMessageModel>
  >
  get messages => ListCopyWith(
    $value.messages,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(messages: v),
  );
  @override
  $R call({
    ChatConversationModel? conversation,
    List<ChatMessageModel>? messages,
  }) => $apply(
    FieldCopyWithData({
      if (conversation != null) #conversation: conversation,
      if (messages != null) #messages: messages,
    }),
  );
  @override
  ChatConversationSnapshot $make(CopyWithData data) => ChatConversationSnapshot(
    conversation: data.get(#conversation, or: $value.conversation),
    messages: data.get(#messages, or: $value.messages),
  );

  @override
  ChatConversationSnapshotCopyWith<$R2, ChatConversationSnapshot, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ChatConversationSnapshotCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
