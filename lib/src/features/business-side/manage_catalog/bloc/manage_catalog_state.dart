import 'package:aquabook/src/data/models/business_model.dart';

class ManageCatalogState {
  const ManageCatalogState({
    this.business,
    this.isLoading = false,
    this.isSaving = false,
    this.errorMessage,
  });

  final BusinessModel? business;
  final bool isLoading;
  final bool isSaving;
  final String? errorMessage;
}
