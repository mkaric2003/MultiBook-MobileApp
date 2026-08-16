import 'package:aquabook/src/data/models/business_model.dart';

class StayDetailState {
  const StayDetailState({
    this.isLoading = false,
    this.business,
    this.errorMessage,
  });

  final bool isLoading;
  final BusinessModel? business;
  final String? errorMessage;
}
