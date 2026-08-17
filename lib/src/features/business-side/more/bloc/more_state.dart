import 'package:aquabook/src/data/models/business_model.dart';

class MoreState {
  const MoreState({
    this.isLoading = true,
    this.businesses = const [],
    this.selectedBusiness,
  });

  final bool isLoading;
  final List<BusinessModel> businesses;
  final BusinessModel? selectedBusiness;
}
