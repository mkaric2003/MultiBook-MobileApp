import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/models/stay_extra_model.dart';

class ReviewStayState {
  const ReviewStayState({
    this.isLoading = false,
    this.business,
    this.selectedExtras = const [],
  });

  final bool isLoading;
  final BusinessModel? business;
  final List<StayExtraModel> selectedExtras;

  ReviewStayState copyWith({
    bool? isLoading,
    BusinessModel? business,
    List<StayExtraModel>? selectedExtras,
  }) => ReviewStayState(
    isLoading: isLoading ?? this.isLoading,
    business: business ?? this.business,
    selectedExtras: selectedExtras ?? this.selectedExtras,
  );
}
