import 'package:multibook/src/data/models/business_model.dart';

class MyBusinessesState {
  const MyBusinessesState({
    this.isLoading = true,
    this.isSelecting = false,
    this.businesses = const [],
  });

  final bool isLoading;
  final bool isSelecting;
  final List<BusinessModel> businesses;
}
