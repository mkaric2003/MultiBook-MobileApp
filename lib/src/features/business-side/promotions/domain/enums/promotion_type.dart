import 'package:dart_mappable/dart_mappable.dart';

part 'promotion_type.mapper.dart';

@MappableEnum()
enum PromotionType { percentage, fixedAmount, couponCode }
