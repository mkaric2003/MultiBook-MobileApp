// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'chat_conversation_model.dart';

class ChatConversationModelMapper
    extends ClassMapperBase<ChatConversationModel> {
  ChatConversationModelMapper._();

  static ChatConversationModelMapper? _instance;
  static ChatConversationModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChatConversationModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ChatConversationModel';

  static String _$id(ChatConversationModel v) => v.id;
  static const Field<ChatConversationModel, String> _f$id = Field('id', _$id);
  static String? _$businessId(ChatConversationModel v) => v.businessId;
  static const Field<ChatConversationModel, String> _f$businessId = Field(
    'businessId',
    _$businessId,
    opt: true,
  );
  static String? _$legacyBusinessId(ChatConversationModel v) =>
      v.legacyBusinessId;
  static const Field<ChatConversationModel, String> _f$legacyBusinessId = Field(
    'legacyBusinessId',
    _$legacyBusinessId,
    opt: true,
  );
  static String _$businessOwnerId(ChatConversationModel v) => v.businessOwnerId;
  static const Field<ChatConversationModel, String> _f$businessOwnerId = Field(
    'businessOwnerId',
    _$businessOwnerId,
  );
  static String _$businessName(ChatConversationModel v) => v.businessName;
  static const Field<ChatConversationModel, String> _f$businessName = Field(
    'businessName',
    _$businessName,
  );
  static String? _$businessImageUrl(ChatConversationModel v) =>
      v.businessImageUrl;
  static const Field<ChatConversationModel, String> _f$businessImageUrl = Field(
    'businessImageUrl',
    _$businessImageUrl,
    opt: true,
  );
  static String _$customerId(ChatConversationModel v) => v.customerId;
  static const Field<ChatConversationModel, String> _f$customerId = Field(
    'customerId',
    _$customerId,
  );
  static String _$customerName(ChatConversationModel v) => v.customerName;
  static const Field<ChatConversationModel, String> _f$customerName = Field(
    'customerName',
    _$customerName,
  );
  static String? _$customerImageUrl(ChatConversationModel v) =>
      v.customerImageUrl;
  static const Field<ChatConversationModel, String> _f$customerImageUrl = Field(
    'customerImageUrl',
    _$customerImageUrl,
  );
  static List<String> _$participantIds(ChatConversationModel v) =>
      v.participantIds;
  static const Field<ChatConversationModel, List<String>> _f$participantIds =
      Field('participantIds', _$participantIds);
  static List<String> _$activeParticipantIds(ChatConversationModel v) =>
      v.activeParticipantIds;
  static const Field<ChatConversationModel, List<String>>
  _f$activeParticipantIds = Field(
    'activeParticipantIds',
    _$activeParticipantIds,
  );
  static DateTime _$createdAt(ChatConversationModel v) => v.createdAt;
  static const Field<ChatConversationModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static DateTime _$updatedAt(ChatConversationModel v) => v.updatedAt;
  static const Field<ChatConversationModel, DateTime> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
  );
  static String? _$lastMessageId(ChatConversationModel v) => v.lastMessageId;
  static const Field<ChatConversationModel, String> _f$lastMessageId = Field(
    'lastMessageId',
    _$lastMessageId,
    opt: true,
  );
  static String _$lastMessageText(ChatConversationModel v) => v.lastMessageText;
  static const Field<ChatConversationModel, String> _f$lastMessageText = Field(
    'lastMessageText',
    _$lastMessageText,
    opt: true,
    def: '',
  );
  static DateTime? _$lastMessageAt(ChatConversationModel v) => v.lastMessageAt;
  static const Field<ChatConversationModel, DateTime> _f$lastMessageAt = Field(
    'lastMessageAt',
    _$lastMessageAt,
    opt: true,
  );
  static String? _$lastSenderId(ChatConversationModel v) => v.lastSenderId;
  static const Field<ChatConversationModel, String> _f$lastSenderId = Field(
    'lastSenderId',
    _$lastSenderId,
    opt: true,
  );
  static String? _$typingUserId(ChatConversationModel v) => v.typingUserId;
  static const Field<ChatConversationModel, String> _f$typingUserId = Field(
    'typingUserId',
    _$typingUserId,
    opt: true,
  );
  static DateTime? _$typingExpiresAt(ChatConversationModel v) =>
      v.typingExpiresAt;
  static const Field<ChatConversationModel, DateTime> _f$typingExpiresAt =
      Field('typingExpiresAt', _$typingExpiresAt, opt: true);
  static DateTime? _$lastReadAtCustomer(ChatConversationModel v) =>
      v.lastReadAtCustomer;
  static const Field<ChatConversationModel, DateTime> _f$lastReadAtCustomer =
      Field('lastReadAtCustomer', _$lastReadAtCustomer, opt: true);
  static DateTime? _$lastReadAtBusiness(ChatConversationModel v) =>
      v.lastReadAtBusiness;
  static const Field<ChatConversationModel, DateTime> _f$lastReadAtBusiness =
      Field('lastReadAtBusiness', _$lastReadAtBusiness, opt: true);
  static int _$unreadCustomerCount(ChatConversationModel v) =>
      v.unreadCustomerCount;
  static const Field<ChatConversationModel, int> _f$unreadCustomerCount = Field(
    'unreadCustomerCount',
    _$unreadCustomerCount,
    opt: true,
    def: 0,
  );
  static int _$unreadBusinessCount(ChatConversationModel v) =>
      v.unreadBusinessCount;
  static const Field<ChatConversationModel, int> _f$unreadBusinessCount = Field(
    'unreadBusinessCount',
    _$unreadBusinessCount,
    opt: true,
    def: 0,
  );

  @override
  final MappableFields<ChatConversationModel> fields = const {
    #id: _f$id,
    #businessId: _f$businessId,
    #legacyBusinessId: _f$legacyBusinessId,
    #businessOwnerId: _f$businessOwnerId,
    #businessName: _f$businessName,
    #businessImageUrl: _f$businessImageUrl,
    #customerId: _f$customerId,
    #customerName: _f$customerName,
    #customerImageUrl: _f$customerImageUrl,
    #participantIds: _f$participantIds,
    #activeParticipantIds: _f$activeParticipantIds,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #lastMessageId: _f$lastMessageId,
    #lastMessageText: _f$lastMessageText,
    #lastMessageAt: _f$lastMessageAt,
    #lastSenderId: _f$lastSenderId,
    #typingUserId: _f$typingUserId,
    #typingExpiresAt: _f$typingExpiresAt,
    #lastReadAtCustomer: _f$lastReadAtCustomer,
    #lastReadAtBusiness: _f$lastReadAtBusiness,
    #unreadCustomerCount: _f$unreadCustomerCount,
    #unreadBusinessCount: _f$unreadBusinessCount,
  };

  static ChatConversationModel _instantiate(DecodingData data) {
    return ChatConversationModel(
      id: data.dec(_f$id),
      businessId: data.dec(_f$businessId),
      legacyBusinessId: data.dec(_f$legacyBusinessId),
      businessOwnerId: data.dec(_f$businessOwnerId),
      businessName: data.dec(_f$businessName),
      businessImageUrl: data.dec(_f$businessImageUrl),
      customerId: data.dec(_f$customerId),
      customerName: data.dec(_f$customerName),
      customerImageUrl: data.dec(_f$customerImageUrl),
      participantIds: data.dec(_f$participantIds),
      activeParticipantIds: data.dec(_f$activeParticipantIds),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      lastMessageId: data.dec(_f$lastMessageId),
      lastMessageText: data.dec(_f$lastMessageText),
      lastMessageAt: data.dec(_f$lastMessageAt),
      lastSenderId: data.dec(_f$lastSenderId),
      typingUserId: data.dec(_f$typingUserId),
      typingExpiresAt: data.dec(_f$typingExpiresAt),
      lastReadAtCustomer: data.dec(_f$lastReadAtCustomer),
      lastReadAtBusiness: data.dec(_f$lastReadAtBusiness),
      unreadCustomerCount: data.dec(_f$unreadCustomerCount),
      unreadBusinessCount: data.dec(_f$unreadBusinessCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ChatConversationModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChatConversationModel>(map);
  }

  static ChatConversationModel fromJson(String json) {
    return ensureInitialized().decodeJson<ChatConversationModel>(json);
  }
}
mixin ChatConversationModelMappable {
  String toJson() {
    return ChatConversationModelMapper.ensureInitialized()
        .encodeJson<ChatConversationModel>(this as ChatConversationModel);
  }

  Map<String, dynamic> toMap() {
    return ChatConversationModelMapper.ensureInitialized()
        .encodeMap<ChatConversationModel>(this as ChatConversationModel);
  }

  ChatConversationModelCopyWith<
    ChatConversationModel,
    ChatConversationModel,
    ChatConversationModel
  >
  get copyWith =>
      _ChatConversationModelCopyWithImpl<
        ChatConversationModel,
        ChatConversationModel
      >(this as ChatConversationModel, $identity, $identity);
  @override
  String toString() {
    return ChatConversationModelMapper.ensureInitialized().stringifyValue(
      this as ChatConversationModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ChatConversationModelMapper.ensureInitialized().equalsValue(
      this as ChatConversationModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ChatConversationModelMapper.ensureInitialized().hashValue(
      this as ChatConversationModel,
    );
  }
}

extension ChatConversationModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChatConversationModel, $Out> {
  ChatConversationModelCopyWith<$R, ChatConversationModel, $Out>
  get $asChatConversationModel => $base.as(
    (v, t, t2) => _ChatConversationModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ChatConversationModelCopyWith<
  $R,
  $In extends ChatConversationModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get participantIds;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get activeParticipantIds;
  $R call({
    String? id,
    String? businessId,
    String? legacyBusinessId,
    String? businessOwnerId,
    String? businessName,
    String? businessImageUrl,
    String? customerId,
    String? customerName,
    String? customerImageUrl,
    List<String>? participantIds,
    List<String>? activeParticipantIds,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? lastMessageId,
    String? lastMessageText,
    DateTime? lastMessageAt,
    String? lastSenderId,
    String? typingUserId,
    DateTime? typingExpiresAt,
    DateTime? lastReadAtCustomer,
    DateTime? lastReadAtBusiness,
    int? unreadCustomerCount,
    int? unreadBusinessCount,
  });
  ChatConversationModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ChatConversationModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChatConversationModel, $Out>
    implements ChatConversationModelCopyWith<$R, ChatConversationModel, $Out> {
  _ChatConversationModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChatConversationModel> $mapper =
      ChatConversationModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get participantIds => ListCopyWith(
    $value.participantIds,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(participantIds: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get activeParticipantIds => ListCopyWith(
    $value.activeParticipantIds,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(activeParticipantIds: v),
  );
  @override
  $R call({
    String? id,
    Object? businessId = $none,
    Object? legacyBusinessId = $none,
    String? businessOwnerId,
    String? businessName,
    Object? businessImageUrl = $none,
    String? customerId,
    String? customerName,
    Object? customerImageUrl = $none,
    List<String>? participantIds,
    List<String>? activeParticipantIds,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? lastMessageId = $none,
    String? lastMessageText,
    Object? lastMessageAt = $none,
    Object? lastSenderId = $none,
    Object? typingUserId = $none,
    Object? typingExpiresAt = $none,
    Object? lastReadAtCustomer = $none,
    Object? lastReadAtBusiness = $none,
    int? unreadCustomerCount,
    int? unreadBusinessCount,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (businessId != $none) #businessId: businessId,
      if (legacyBusinessId != $none) #legacyBusinessId: legacyBusinessId,
      if (businessOwnerId != null) #businessOwnerId: businessOwnerId,
      if (businessName != null) #businessName: businessName,
      if (businessImageUrl != $none) #businessImageUrl: businessImageUrl,
      if (customerId != null) #customerId: customerId,
      if (customerName != null) #customerName: customerName,
      if (customerImageUrl != $none) #customerImageUrl: customerImageUrl,
      if (participantIds != null) #participantIds: participantIds,
      if (activeParticipantIds != null)
        #activeParticipantIds: activeParticipantIds,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (lastMessageId != $none) #lastMessageId: lastMessageId,
      if (lastMessageText != null) #lastMessageText: lastMessageText,
      if (lastMessageAt != $none) #lastMessageAt: lastMessageAt,
      if (lastSenderId != $none) #lastSenderId: lastSenderId,
      if (typingUserId != $none) #typingUserId: typingUserId,
      if (typingExpiresAt != $none) #typingExpiresAt: typingExpiresAt,
      if (lastReadAtCustomer != $none) #lastReadAtCustomer: lastReadAtCustomer,
      if (lastReadAtBusiness != $none) #lastReadAtBusiness: lastReadAtBusiness,
      if (unreadCustomerCount != null)
        #unreadCustomerCount: unreadCustomerCount,
      if (unreadBusinessCount != null)
        #unreadBusinessCount: unreadBusinessCount,
    }),
  );
  @override
  ChatConversationModel $make(CopyWithData data) => ChatConversationModel(
    id: data.get(#id, or: $value.id),
    businessId: data.get(#businessId, or: $value.businessId),
    legacyBusinessId: data.get(#legacyBusinessId, or: $value.legacyBusinessId),
    businessOwnerId: data.get(#businessOwnerId, or: $value.businessOwnerId),
    businessName: data.get(#businessName, or: $value.businessName),
    businessImageUrl: data.get(#businessImageUrl, or: $value.businessImageUrl),
    customerId: data.get(#customerId, or: $value.customerId),
    customerName: data.get(#customerName, or: $value.customerName),
    customerImageUrl: data.get(#customerImageUrl, or: $value.customerImageUrl),
    participantIds: data.get(#participantIds, or: $value.participantIds),
    activeParticipantIds: data.get(
      #activeParticipantIds,
      or: $value.activeParticipantIds,
    ),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    lastMessageId: data.get(#lastMessageId, or: $value.lastMessageId),
    lastMessageText: data.get(#lastMessageText, or: $value.lastMessageText),
    lastMessageAt: data.get(#lastMessageAt, or: $value.lastMessageAt),
    lastSenderId: data.get(#lastSenderId, or: $value.lastSenderId),
    typingUserId: data.get(#typingUserId, or: $value.typingUserId),
    typingExpiresAt: data.get(#typingExpiresAt, or: $value.typingExpiresAt),
    lastReadAtCustomer: data.get(
      #lastReadAtCustomer,
      or: $value.lastReadAtCustomer,
    ),
    lastReadAtBusiness: data.get(
      #lastReadAtBusiness,
      or: $value.lastReadAtBusiness,
    ),
    unreadCustomerCount: data.get(
      #unreadCustomerCount,
      or: $value.unreadCustomerCount,
    ),
    unreadBusinessCount: data.get(
      #unreadBusinessCount,
      or: $value.unreadBusinessCount,
    ),
  );

  @override
  ChatConversationModelCopyWith<$R2, ChatConversationModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ChatConversationModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
