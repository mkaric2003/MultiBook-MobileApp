import 'package:multibook/src/features/business-side/promotions/domain/enums/promotion_type.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'promotion_model.mapper.dart';

@MappableClass()
final class PromotionModel with PromotionModelMappable {
  const PromotionModel({
    required this.id,
    required this.businessId,
    required this.ownerId,
    required this.name,
    required this.type,
    required this.value,
    required this.startsAt,
    required this.endsAt,
    required this.isActive,
    this.code,
    this.minimumAmount = 0,
    this.minimumNights = 1,
    this.usageLimit,
    this.usageCount = 0,
    this.createdAt,
  });

  final String id;
  final String businessId;
  final String ownerId;
  final String name;
  final PromotionType type;
  final int value;
  final DateTime startsAt;
  final DateTime endsAt;
  final bool isActive;
  final String? code;
  final int minimumAmount;
  final int minimumNights;
  final int? usageLimit;
  final int usageCount;
  final DateTime? createdAt;
}
