import 'package:aquabook/src/data/models/business_model.dart';

class ServiceDetailState {
  const ServiceDetailState({
    this.isLoading = false,
    this.business,
    this.errorMessage,
    this.isSaved = false,
  });

  final bool isLoading;
  final BusinessModel? business;
  final String? errorMessage;
  final bool isSaved;
}
