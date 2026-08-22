import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/data/models/business_review_model.dart';

class ServiceDetailState {
  const ServiceDetailState({
    this.isLoading = false,
    this.business,
    this.errorMessage,
    this.isSaved = false,
    this.reviews = const [],
  });

  final bool isLoading;
  final BusinessModel? business;
  final String? errorMessage;
  final bool isSaved;
  final List<BusinessReviewModel> reviews;
}
