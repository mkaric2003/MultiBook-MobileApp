// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'chat_conversation_arguments.dart';

class ChatConversationArgumentsMapper
    extends ClassMapperBase<ChatConversationArguments> {
  ChatConversationArgumentsMapper._();

  static ChatConversationArgumentsMapper? _instance;
  static ChatConversationArgumentsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = ChatConversationArgumentsMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'ChatConversationArguments';

  static String _$businessId(ChatConversationArguments v) => v.businessId;
  static const Field<ChatConversationArguments, String> _f$businessId = Field(
    'businessId',
    _$businessId,
  );
  static String _$businessOwnerId(ChatConversationArguments v) =>
      v.businessOwnerId;
  static const Field<ChatConversationArguments, String> _f$businessOwnerId =
      Field('businessOwnerId', _$businessOwnerId);
  static String _$businessName(ChatConversationArguments v) => v.businessName;
  static const Field<ChatConversationArguments, String> _f$businessName = Field(
    'businessName',
    _$businessName,
  );
  static String _$businessImageUrl(ChatConversationArguments v) =>
      v.businessImageUrl;
  static const Field<ChatConversationArguments, String> _f$businessImageUrl =
      Field('businessImageUrl', _$businessImageUrl);
  static String? _$customerId(ChatConversationArguments v) => v.customerId;
  static const Field<ChatConversationArguments, String> _f$customerId = Field(
    'customerId',
    _$customerId,
    opt: true,
  );
  static String? _$customerName(ChatConversationArguments v) => v.customerName;
  static const Field<ChatConversationArguments, String> _f$customerName = Field(
    'customerName',
    _$customerName,
    opt: true,
  );
  static String? _$customerImageUrl(ChatConversationArguments v) =>
      v.customerImageUrl;
  static const Field<ChatConversationArguments, String> _f$customerImageUrl =
      Field('customerImageUrl', _$customerImageUrl, opt: true);

  @override
  final MappableFields<ChatConversationArguments> fields = const {
    #businessId: _f$businessId,
    #businessOwnerId: _f$businessOwnerId,
    #businessName: _f$businessName,
    #businessImageUrl: _f$businessImageUrl,
    #customerId: _f$customerId,
    #customerName: _f$customerName,
    #customerImageUrl: _f$customerImageUrl,
  };

  static ChatConversationArguments _instantiate(DecodingData data) {
    return ChatConversationArguments(
      businessId: data.dec(_f$businessId),
      businessOwnerId: data.dec(_f$businessOwnerId),
      businessName: data.dec(_f$businessName),
      businessImageUrl: data.dec(_f$businessImageUrl),
      customerId: data.dec(_f$customerId),
      customerName: data.dec(_f$customerName),
      customerImageUrl: data.dec(_f$customerImageUrl),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ChatConversationArguments fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChatConversationArguments>(map);
  }

  static ChatConversationArguments fromJson(String json) {
    return ensureInitialized().decodeJson<ChatConversationArguments>(json);
  }
}
mixin ChatConversationArgumentsMappable {
  String toJson() {
    return ChatConversationArgumentsMapper.ensureInitialized()
        .encodeJson<ChatConversationArguments>(
          this as ChatConversationArguments,
        );
  }

  Map<String, dynamic> toMap() {
    return ChatConversationArgumentsMapper.ensureInitialized()
        .encodeMap<ChatConversationArguments>(
          this as ChatConversationArguments,
        );
  }

  ChatConversationArgumentsCopyWith<
    ChatConversationArguments,
    ChatConversationArguments,
    ChatConversationArguments
  >
  get copyWith =>
      _ChatConversationArgumentsCopyWithImpl<
        ChatConversationArguments,
        ChatConversationArguments
      >(this as ChatConversationArguments, $identity, $identity);
  @override
  String toString() {
    return ChatConversationArgumentsMapper.ensureInitialized().stringifyValue(
      this as ChatConversationArguments,
    );
  }

  @override
  bool operator ==(Object other) {
    return ChatConversationArgumentsMapper.ensureInitialized().equalsValue(
      this as ChatConversationArguments,
      other,
    );
  }

  @override
  int get hashCode {
    return ChatConversationArgumentsMapper.ensureInitialized().hashValue(
      this as ChatConversationArguments,
    );
  }
}

extension ChatConversationArgumentsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChatConversationArguments, $Out> {
  ChatConversationArgumentsCopyWith<$R, ChatConversationArguments, $Out>
  get $asChatConversationArguments => $base.as(
    (v, t, t2) => _ChatConversationArgumentsCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ChatConversationArgumentsCopyWith<
  $R,
  $In extends ChatConversationArguments,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? businessId,
    String? businessOwnerId,
    String? businessName,
    String? businessImageUrl,
    String? customerId,
    String? customerName,
    String? customerImageUrl,
  });
  ChatConversationArgumentsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ChatConversationArgumentsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChatConversationArguments, $Out>
    implements
        ChatConversationArgumentsCopyWith<$R, ChatConversationArguments, $Out> {
  _ChatConversationArgumentsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChatConversationArguments> $mapper =
      ChatConversationArgumentsMapper.ensureInitialized();
  @override
  $R call({
    String? businessId,
    String? businessOwnerId,
    String? businessName,
    String? businessImageUrl,
    Object? customerId = $none,
    Object? customerName = $none,
    Object? customerImageUrl = $none,
  }) => $apply(
    FieldCopyWithData({
      if (businessId != null) #businessId: businessId,
      if (businessOwnerId != null) #businessOwnerId: businessOwnerId,
      if (businessName != null) #businessName: businessName,
      if (businessImageUrl != null) #businessImageUrl: businessImageUrl,
      if (customerId != $none) #customerId: customerId,
      if (customerName != $none) #customerName: customerName,
      if (customerImageUrl != $none) #customerImageUrl: customerImageUrl,
    }),
  );
  @override
  ChatConversationArguments $make(
    CopyWithData data,
  ) => ChatConversationArguments(
    businessId: data.get(#businessId, or: $value.businessId),
    businessOwnerId: data.get(#businessOwnerId, or: $value.businessOwnerId),
    businessName: data.get(#businessName, or: $value.businessName),
    businessImageUrl: data.get(#businessImageUrl, or: $value.businessImageUrl),
    customerId: data.get(#customerId, or: $value.customerId),
    customerName: data.get(#customerName, or: $value.customerName),
    customerImageUrl: data.get(#customerImageUrl, or: $value.customerImageUrl),
  );

  @override
  ChatConversationArgumentsCopyWith<$R2, ChatConversationArguments, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ChatConversationArgumentsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
