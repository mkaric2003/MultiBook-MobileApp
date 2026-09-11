import 'package:dart_mappable/dart_mappable.dart';
import 'package:multibook/src/data/models/business_review_model.dart';

part 'review_list_response.mapper.dart';

@MappableClass()
class ReviewListResponse with ReviewListResponseMappable {
  const ReviewListResponse({required this.items, this.nextOffset});

  final List<BusinessReviewModel> items;
  final int? nextOffset;
}
