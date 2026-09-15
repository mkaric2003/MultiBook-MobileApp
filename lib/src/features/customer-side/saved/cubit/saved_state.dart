import 'package:multibook/src/data/models/business_model.dart';

class SavedState {
  const SavedState({
    this.businesses = const [],
    this.isLoading = false,
    this.removingId,
    this.hasError = false,
  });
  final List<BusinessModel> businesses;
  final bool isLoading;
  final String? removingId;
  final bool hasError;
}
