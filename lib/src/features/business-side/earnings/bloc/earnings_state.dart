import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/features/business-side/dashboard/domain/models/business_monthly_metrics.dart';

class EarningsState {
  const EarningsState({
    this.isLoading = true,
    this.businesses = const [],
    this.selectedBusiness,
    this.monthlyMetrics = const BusinessMonthlyMetrics(),
    this.hasError = false,
  });

  final bool isLoading;
  final List<BusinessModel> businesses;
  final BusinessModel? selectedBusiness;
  final BusinessMonthlyMetrics monthlyMetrics;
  final bool hasError;

  EarningsState copyWith({
    bool? isLoading,
    List<BusinessModel>? businesses,
    BusinessModel? selectedBusiness,
    BusinessMonthlyMetrics? monthlyMetrics,
    bool? hasError,
  }) => EarningsState(
    isLoading: isLoading ?? this.isLoading,
    businesses: businesses ?? this.businesses,
    selectedBusiness: selectedBusiness ?? this.selectedBusiness,
    monthlyMetrics: monthlyMetrics ?? this.monthlyMetrics,
    hasError: hasError ?? this.hasError,
  );
}
