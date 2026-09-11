// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'chat_message_model.dart';

class ChatMessageModelMapper extends ClassMapperBase<ChatMessageModel> {
  ChatMessageModelMapper._();

  static ChatMessageModelMapper? _instance;
  static ChatMessageModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChatMessageModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ChatMessageModel';

  static String _$id(ChatMessageModel v) => v.id;
  static const Field<ChatMessageModel, String> _f$id = Field('id', _$id);
  static String _$conversationId(ChatMessageModel v) => v.conversationId;
  static const Field<ChatMessageModel, String> _f$conversationId = Field(
    'conversationId',
    _$conversationId,
  );
  static String _$senderId(ChatMessageModel v) => v.senderId;
  static const Field<ChatMessageModel, String> _f$senderId = Field(
    'senderId',
    _$senderId,
  );
  static String _$text(ChatMessageModel v) => v.text;
  static const Field<ChatMessageModel, String> _f$text = Field('text', _$text);
  static DateTime _$createdAt(ChatMessageModel v) => v.createdAt;
  static const Field<ChatMessageModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<ChatMessageModel> fields = const {
    #id: _f$id,
    #conversationId: _f$conversationId,
    #senderId: _f$senderId,
    #text: _f$text,
    #createdAt: _f$createdAt,
  };

  static ChatMessageModel _instantiate(DecodingData data) {
    return ChatMessageModel(
      id: data.dec(_f$id),
      conversationId: data.dec(_f$conversationId),
      senderId: data.dec(_f$senderId),
      text: data.dec(_f$text),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ChatMessageModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChatMessageModel>(map);
  }

  static ChatMessageModel fromJson(String json) {
    return ensureInitialized().decodeJson<ChatMessageModel>(json);
  }
}
mixin ChatMessageModelMappable {
  String toJson() {
    return ChatMessageModelMapper.ensureInitialized()
        .encodeJson<ChatMessageModel>(this as ChatMessageModel);
  }

  Map<String, dynamic> toMap() {
    return ChatMessageModelMapper.ensureInitialized()
        .encodeMap<ChatMessageModel>(this as ChatMessageModel);
  }

  ChatMessageModelCopyWith<ChatMessageModel, ChatMessageModel, ChatMessageModel>
  get copyWith =>
      _ChatMessageModelCopyWithImpl<ChatMessageModel, ChatMessageModel>(
        this as ChatMessageModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ChatMessageModelMapper.ensureInitialized().stringifyValue(
      this as ChatMessageModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ChatMessageModelMapper.ensureInitialized().equalsValue(
      this as ChatMessageModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ChatMessageModelMapper.ensureInitialized().hashValue(
      this as ChatMessageModel,
    );
  }
}

extension ChatMessageModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChatMessageModel, $Out> {
  ChatMessageModelCopyWith<$R, ChatMessageModel, $Out>
  get $asChatMessageModel =>
      $base.as((v, t, t2) => _ChatMessageModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ChatMessageModelCopyWith<$R, $In extends ChatMessageModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? conversationId,
    String? senderId,
    String? text,
    DateTime? createdAt,
  });
  ChatMessageModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ChatMessageModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChatMessageModel, $Out>
    implements ChatMessageModelCopyWith<$R, ChatMessageModel, $Out> {
  _ChatMessageModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChatMessageModel> $mapper =
      ChatMessageModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? conversationId,
    String? senderId,
    String? text,
    DateTime? createdAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (conversationId != null) #conversationId: conversationId,
      if (senderId != null) #senderId: senderId,
      if (text != null) #text: text,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  ChatMessageModel $make(CopyWithData data) => ChatMessageModel(
    id: data.get(#id, or: $value.id),
    conversationId: data.get(#conversationId, or: $value.conversationId),
    senderId: data.get(#senderId, or: $value.senderId),
    text: data.get(#text, or: $value.text),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  ChatMessageModelCopyWith<$R2, ChatMessageModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ChatMessageModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
