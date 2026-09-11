import 'package:dart_mappable/dart_mappable.dart';

part 'business_review_model.mapper.dart';

@MappableClass()
class BusinessReviewModel with BusinessReviewModelMappable {
  const BusinessReviewModel({
    required this.id,
    required this.customerName,
    required this.rating,
    this.customerAvatarUrl,
    this.comment,
  });

  final String id;
  final String customerName;
  final String? customerAvatarUrl;
  final int rating;
  final String? comment;
}
