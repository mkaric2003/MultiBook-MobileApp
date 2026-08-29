import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/models/service_provider_model.dart';
import 'package:multibook/src/features/business-side/dashboard/domain/models/business_monthly_metrics.dart';
import 'package:multibook/src/features/business-side/earnings/domain/enums/earnings_period.dart';
import 'package:multibook/src/features/business-side/earnings/domain/models/earnings_date_range.dart';
import 'package:multibook/src/features/business-side/earnings/domain/models/provider_earnings_metrics.dart';

class EarningsState {
  const EarningsState({
    this.isLoading = true,
    this.businesses = const [],
    this.selectedBusiness,
    this.monthlyMetrics = const BusinessMonthlyMetrics(),
    this.hasError = false,
    this.period = EarningsPeriod.currentMonth,
    this.dateRange,
    this.selectedProvider,
    this.providerMetrics = const ProviderEarningsMetrics(),
  });

  final bool isLoading;
  final List<BusinessModel> businesses;
  final BusinessModel? selectedBusiness;
  final BusinessMonthlyMetrics monthlyMetrics;
  final bool hasError;
  final EarningsPeriod period;
  final EarningsDateRange? dateRange;
  final ServiceProviderModel? selectedProvider;
  final ProviderEarningsMetrics providerMetrics;

  EarningsState copyWith({
    bool? isLoading,
    List<BusinessModel>? businesses,
    BusinessModel? selectedBusiness,
    BusinessMonthlyMetrics? monthlyMetrics,
    bool? hasError,
    EarningsPeriod? period,
    EarningsDateRange? dateRange,
    ServiceProviderModel? selectedProvider,
    ProviderEarningsMetrics? providerMetrics,
  }) => EarningsState(
    isLoading: isLoading ?? this.isLoading,
    businesses: businesses ?? this.businesses,
    selectedBusiness: selectedBusiness ?? this.selectedBusiness,
    monthlyMetrics: monthlyMetrics ?? this.monthlyMetrics,
    hasError: hasError ?? this.hasError,
    period: period ?? this.period,
    dateRange: dateRange ?? this.dateRange,
    selectedProvider: selectedProvider ?? this.selectedProvider,
    providerMetrics: providerMetrics ?? this.providerMetrics,
  );
}
