import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/models/earnings_metrics.dart';
import 'package:multibook/src/data/models/service_provider_model.dart';
import 'package:multibook/src/features/business-side/earnings/domain/enums/earnings_period.dart';
import 'package:multibook/src/features/business-side/earnings/domain/models/earnings_date_range.dart';

class EarningsState {
  const EarningsState({
    this.isLoading = true,
    this.businesses = const [],
    this.selectedBusiness,
    this.metrics,
    this.hasError = false,
    this.period = EarningsPeriod.currentMonth,
    this.dateRange,
    this.selectedProvider,
  });

  final bool isLoading;
  final List<BusinessModel> businesses;
  final BusinessModel? selectedBusiness;
  final EarningsMetrics? metrics;
  final bool hasError;
  final EarningsPeriod period;
  final EarningsDateRange? dateRange;
  final ServiceProviderModel? selectedProvider;

  EarningsState copyWith({
    bool? isLoading,
    List<BusinessModel>? businesses,
    BusinessModel? selectedBusiness,
    EarningsMetrics? metrics,
    bool? hasError,
    EarningsPeriod? period,
    EarningsDateRange? dateRange,
    ServiceProviderModel? selectedProvider,
  }) => EarningsState(
    isLoading: isLoading ?? this.isLoading,
    businesses: businesses ?? this.businesses,
    selectedBusiness: selectedBusiness ?? this.selectedBusiness,
    metrics: metrics ?? this.metrics,
    hasError: hasError ?? this.hasError,
    period: period ?? this.period,
    dateRange: dateRange ?? this.dateRange,
    selectedProvider: selectedProvider ?? this.selectedProvider,
  );
}
