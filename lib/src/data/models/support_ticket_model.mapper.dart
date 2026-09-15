// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'support_ticket_model.dart';

class SupportTicketModelMapper extends ClassMapperBase<SupportTicketModel> {
  SupportTicketModelMapper._();

  static SupportTicketModelMapper? _instance;
  static SupportTicketModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SupportTicketModelMapper._());
      SupportTicketCategoryMapper.ensureInitialized();
      SupportTicketStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SupportTicketModel';

  static String _$id(SupportTicketModel v) => v.id;
  static const Field<SupportTicketModel, String> _f$id = Field('id', _$id);
  static String _$customerId(SupportTicketModel v) => v.customerId;
  static const Field<SupportTicketModel, String> _f$customerId = Field(
    'customerId',
    _$customerId,
  );
  static String _$customerName(SupportTicketModel v) => v.customerName;
  static const Field<SupportTicketModel, String> _f$customerName = Field(
    'customerName',
    _$customerName,
  );
  static String _$customerEmail(SupportTicketModel v) => v.customerEmail;
  static const Field<SupportTicketModel, String> _f$customerEmail = Field(
    'customerEmail',
    _$customerEmail,
  );
  static SupportTicketCategory _$category(SupportTicketModel v) => v.category;
  static const Field<SupportTicketModel, SupportTicketCategory> _f$category =
      Field('category', _$category);
  static SupportTicketStatus _$status(SupportTicketModel v) => v.status;
  static const Field<SupportTicketModel, SupportTicketStatus> _f$status = Field(
    'status',
    _$status,
  );
  static String _$subject(SupportTicketModel v) => v.subject;
  static const Field<SupportTicketModel, String> _f$subject = Field(
    'subject',
    _$subject,
  );
  static String _$message(SupportTicketModel v) => v.message;
  static const Field<SupportTicketModel, String> _f$message = Field(
    'message',
    _$message,
  );
  static DateTime? _$createdAt(SupportTicketModel v) => v.createdAt;
  static const Field<SupportTicketModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );
  static DateTime? _$updatedAt(SupportTicketModel v) => v.updatedAt;
  static const Field<SupportTicketModel, DateTime> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );

  @override
  final MappableFields<SupportTicketModel> fields = const {
    #id: _f$id,
    #customerId: _f$customerId,
    #customerName: _f$customerName,
    #customerEmail: _f$customerEmail,
    #category: _f$category,
    #status: _f$status,
    #subject: _f$subject,
    #message: _f$message,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static SupportTicketModel _instantiate(DecodingData data) {
    return SupportTicketModel(
      id: data.dec(_f$id),
      customerId: data.dec(_f$customerId),
      customerName: data.dec(_f$customerName),
      customerEmail: data.dec(_f$customerEmail),
      category: data.dec(_f$category),
      status: data.dec(_f$status),
      subject: data.dec(_f$subject),
      message: data.dec(_f$message),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SupportTicketModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SupportTicketModel>(map);
  }

  static SupportTicketModel fromJson(String json) {
    return ensureInitialized().decodeJson<SupportTicketModel>(json);
  }
}

mixin SupportTicketModelMappable {
  String toJson() {
    return SupportTicketModelMapper.ensureInitialized()
        .encodeJson<SupportTicketModel>(this as SupportTicketModel);
  }

  Map<String, dynamic> toMap() {
    return SupportTicketModelMapper.ensureInitialized()
        .encodeMap<SupportTicketModel>(this as SupportTicketModel);
  }

  SupportTicketModelCopyWith<
    SupportTicketModel,
    SupportTicketModel,
    SupportTicketModel
  >
  get copyWith =>
      _SupportTicketModelCopyWithImpl<SupportTicketModel, SupportTicketModel>(
        this as SupportTicketModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SupportTicketModelMapper.ensureInitialized().stringifyValue(
      this as SupportTicketModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return SupportTicketModelMapper.ensureInitialized().equalsValue(
      this as SupportTicketModel,
      other,
    );
  }

  @override
  int get hashCode {
    return SupportTicketModelMapper.ensureInitialized().hashValue(
      this as SupportTicketModel,
    );
  }
}

extension SupportTicketModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SupportTicketModel, $Out> {
  SupportTicketModelCopyWith<$R, SupportTicketModel, $Out>
  get $asSupportTicketModel => $base.as(
    (v, t, t2) => _SupportTicketModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class SupportTicketModelCopyWith<
  $R,
  $In extends SupportTicketModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? customerId,
    String? customerName,
    String? customerEmail,
    SupportTicketCategory? category,
    SupportTicketStatus? status,
    String? subject,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  SupportTicketModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SupportTicketModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SupportTicketModel, $Out>
    implements SupportTicketModelCopyWith<$R, SupportTicketModel, $Out> {
  _SupportTicketModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SupportTicketModel> $mapper =
      SupportTicketModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? customerId,
    String? customerName,
    String? customerEmail,
    SupportTicketCategory? category,
    SupportTicketStatus? status,
    String? subject,
    String? message,
    Object? createdAt = $none,
    Object? updatedAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (customerId != null) #customerId: customerId,
      if (customerName != null) #customerName: customerName,
      if (customerEmail != null) #customerEmail: customerEmail,
      if (category != null) #category: category,
      if (status != null) #status: status,
      if (subject != null) #subject: subject,
      if (message != null) #message: message,
      if (createdAt != $none) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
    }),
  );
  @override
  SupportTicketModel $make(CopyWithData data) => SupportTicketModel(
    id: data.get(#id, or: $value.id),
    customerId: data.get(#customerId, or: $value.customerId),
    customerName: data.get(#customerName, or: $value.customerName),
    customerEmail: data.get(#customerEmail, or: $value.customerEmail),
    category: data.get(#category, or: $value.category),
    status: data.get(#status, or: $value.status),
    subject: data.get(#subject, or: $value.subject),
    message: data.get(#message, or: $value.message),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  SupportTicketModelCopyWith<$R2, SupportTicketModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SupportTicketModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

