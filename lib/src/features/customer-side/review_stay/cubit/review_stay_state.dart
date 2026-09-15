import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/models/stay_extra_model.dart';

class ReviewStayState {
  const ReviewStayState({
    this.isLoading = false,
    this.business,
    this.selectedExtras = const [],
    this.errorMessage,
  });

  final bool isLoading;
  final BusinessModel? business;
  final List<StayExtraModel> selectedExtras;
  final String? errorMessage;

  ReviewStayState copyWith({
    bool? isLoading,
    BusinessModel? business,
    List<StayExtraModel>? selectedExtras,
    String? errorMessage,
    bool clearError = false,
  }) => ReviewStayState(
    isLoading: isLoading ?? this.isLoading,
    business: business ?? this.business,
    selectedExtras: selectedExtras ?? this.selectedExtras,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
}
