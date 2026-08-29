import 'dart:async';

import 'package:multibook/src/core/session/session_stream_registry.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/models/service_provider_model.dart';
import 'package:multibook/src/data/repositories/business_metrics_repository.dart';
import 'package:multibook/src/data/repositories/business_repository.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/business-side/dashboard/domain/models/business_monthly_metrics.dart';
import 'package:multibook/src/features/business-side/earnings/bloc/earnings_state.dart';
import 'package:multibook/src/features/business-side/earnings/domain/enums/earnings_period.dart';
import 'package:multibook/src/features/business-side/earnings/domain/models/earnings_date_range.dart';
import 'package:multibook/src/features/business-side/earnings/domain/models/provider_earnings_metrics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class EarningsCubit extends Cubit<EarningsState> {
  EarningsCubit(
    this._userRepository,
    this._businessRepository,
    this._businessMetricsRepository,
    this._sessionStreamRegistry,
  ) : super(const EarningsState());

  final UserProfileUseCase _userRepository;
  final BusinessRepository _businessRepository;
  final BusinessMetricsRepository _businessMetricsRepository;
  final SessionStreamRegistry _sessionStreamRegistry;
  StreamSubscription? _metricsSubscription;
  int _loadRequestId = 0;

  Future<void> load({String? businessId}) async {
    final requestId = ++_loadRequestId;
    await _cancelMetricsSubscription();
    emit(const EarningsState());

    try {
      final user = await _userRepository.getCurrentUser();
      final businesses = await _businessRepository.getOwnedBusinesses();
      if (requestId != _loadRequestId) return;

      final selectedBusiness =
          _findBusiness(businesses, businessId ?? user?.selectedBusinessId) ??
          (businesses.isEmpty ? null : businesses.first);
      if (selectedBusiness == null) {
        emit(EarningsState(isLoading: false, businesses: businesses));
        return;
      }

      if (selectedBusiness.id != user?.selectedBusinessId) {
        await _userRepository.setSelectedBusiness(
          businessId: selectedBusiness.id,
        );
      }
      if (requestId != _loadRequestId) return;

      emit(
        EarningsState(
          isLoading: false,
          businesses: businesses,
          selectedBusiness: selectedBusiness,
          dateRange: _rangeFor(EarningsPeriod.currentMonth),
        ),
      );
      try {
        await _businessMetricsRepository.initialize(selectedBusiness.id);
      } catch (_) {
        // New reservations will create the metrics document automatically.
      }
      _watchMetrics(
        selectedBusiness.id,
        _rangeFor(EarningsPeriod.currentMonth),
      );
    } catch (_) {
      if (requestId != _loadRequestId) return;
      emit(const EarningsState(isLoading: false, hasError: true));
    }
  }

  Future<void> selectBusiness(BusinessModel business) =>
      _userRepository.setSelectedBusiness(businessId: business.id);

  Future<void> selectPeriod(
    EarningsPeriod period, {
    EarningsDateRange? customRange,
  }) async {
    final business = state.selectedBusiness;
    if (business == null) return;
    final range = period == EarningsPeriod.custom
        ? customRange
        : _rangeFor(period);
    if (range == null) return;
    await _cancelMetricsSubscription();
    emit(
      state.copyWith(
        period: period,
        dateRange: range,
        monthlyMetrics: const BusinessMonthlyMetrics(),
        providerMetrics: const ProviderEarningsMetrics(),
        hasError: false,
      ),
    );
    _watchMetrics(business.id, range, provider: state.selectedProvider);
  }

  Future<void> selectProvider(ServiceProviderModel? provider) async {
    final business = state.selectedBusiness;
    final range = state.dateRange;
    if (business == null || range == null) return;
    await _cancelMetricsSubscription();
    emit(
      EarningsState(
        isLoading: false,
        businesses: state.businesses,
        selectedBusiness: business,
        monthlyMetrics: const BusinessMonthlyMetrics(),
        providerMetrics: const ProviderEarningsMetrics(),
        period: state.period,
        dateRange: range,
        selectedProvider: provider,
      ),
    );
    _watchMetrics(business.id, range, provider: provider);
  }

  void _watchMetrics(
    String businessId,
    EarningsDateRange range, {
    ServiceProviderModel? provider,
  }) {
    if (provider != null) {
      _metricsSubscription = _businessMetricsRepository
          .watchProviderDateRange(
            businessId: businessId,
            providerId: provider.id,
            start: range.start,
            end: range.end,
          )
          .listen(
            (metrics) {
              if (!isClosed) emit(state.copyWith(providerMetrics: metrics));
            },
            onError: (_, _) {
              if (!isClosed) emit(state.copyWith(hasError: true));
            },
          );
      _sessionStreamRegistry.register(_metricsSubscription!);
      return;
    }
    _metricsSubscription = _businessMetricsRepository
        .watchDateRange(
          businessId: businessId,
          start: range.start,
          end: range.end,
        )
        .listen(
          (metrics) {
            if (!isClosed) emit(state.copyWith(monthlyMetrics: metrics));
          },
          onError: (_, _) {
            if (!isClosed) emit(state.copyWith(hasError: true));
          },
        );
    _sessionStreamRegistry.register(_metricsSubscription!);
  }

  EarningsDateRange _rangeFor(EarningsPeriod period) {
    final today = _dateOnly(DateTime.now());
    switch (period) {
      case EarningsPeriod.currentWeek:
        return EarningsDateRange(
          start: today.subtract(Duration(days: today.weekday - 1)),
          end: today,
        );
      case EarningsPeriod.previousWeek:
        final end = today.subtract(Duration(days: today.weekday));
        return EarningsDateRange(
          start: end.subtract(const Duration(days: 6)),
          end: end,
        );
      case EarningsPeriod.currentMonth:
        return EarningsDateRange(
          start: DateTime(today.year, today.month),
          end: today,
        );
      case EarningsPeriod.previousMonth:
        final start = DateTime(today.year, today.month - 1);
        return EarningsDateRange(
          start: start,
          end: DateTime(
            today.year,
            today.month,
          ).subtract(const Duration(days: 1)),
        );
      case EarningsPeriod.currentYear:
        return EarningsDateRange(start: DateTime(today.year), end: today);
      case EarningsPeriod.previousYear:
        return EarningsDateRange(
          start: DateTime(today.year - 1),
          end: DateTime(today.year - 1, 12, 31),
        );
      case EarningsPeriod.custom:
        return EarningsDateRange(start: today, end: today);
    }
  }

  DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  BusinessModel? _findBusiness(
    List<BusinessModel> businesses,
    String? businessId,
  ) {
    if (businessId == null) return null;
    for (final business in businesses) {
      if (business.id == businessId) return business;
    }
    return null;
  }

  Future<void> _cancelMetricsSubscription() async {
    final metricsSubscription = _metricsSubscription;
    _metricsSubscription = null;
    _sessionStreamRegistry.unregister(metricsSubscription);
    await metricsSubscription?.cancel();
  }

  @override
  Future<void> close() async {
    await _cancelMetricsSubscription();
    return super.close();
  }
}
