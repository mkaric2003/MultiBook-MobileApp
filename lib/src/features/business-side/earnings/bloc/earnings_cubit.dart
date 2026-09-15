import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/core/session/session_stream_registry.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/models/service_provider_model.dart';
import 'package:multibook/src/domain/use_cases/businesses/get_owned_business_use_case.dart';
import 'package:multibook/src/domain/use_cases/businesses/get_owned_businesses_use_case.dart';
import 'package:multibook/src/domain/use_cases/earnings/watch_earnings_metrics_use_case.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/business-side/earnings/bloc/earnings_state.dart';
import 'package:multibook/src/features/business-side/earnings/domain/enums/earnings_period.dart';
import 'package:multibook/src/features/business-side/earnings/domain/models/earnings_date_range.dart';

@injectable
class EarningsCubit extends Cubit<EarningsState> {
  EarningsCubit(
    this._userProfile,
    this._getOwnedBusinesses,
    this._getOwnedBusiness,
    this._watchEarningsMetrics,
    this._sessionStreamRegistry,
  ) : super(const EarningsState());

  final UserProfileUseCase _userProfile;
  final GetOwnedBusinessesUseCase _getOwnedBusinesses;
  final GetOwnedBusinessUseCase _getOwnedBusiness;
  final WatchEarningsMetricsUseCase _watchEarningsMetrics;
  final SessionStreamRegistry _sessionStreamRegistry;
  StreamSubscription? _metricsSubscription;
  int _loadRequestId = 0;
  int _metricsRequestId = 0;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    await load();
    if (!isClosed) {
      _userProfile.selectedBusinessId.addListener(_onBusinessChanged);
    }
  }

  void _onBusinessChanged() {
    unawaited(load(businessId: _userProfile.selectedBusinessId.value));
  }

  Future<void> load({String? businessId}) async {
    final requestId = ++_loadRequestId;
    _cancelMetricsSubscription();
    emit(const EarningsState());

    try {
      final user = await _userProfile.getCurrentUser();
      final businessesResult = await _getOwnedBusinesses.execute();
      if (requestId != _loadRequestId) return;
      final businesses = switch (businessesResult) {
        Success(value: final businesses) => businesses,
        FailureResult() => throw StateError('Could not load businesses.'),
      };
      final selectedBusinessSummary =
          _findBusiness(businesses, businessId ?? user?.selectedBusinessId) ??
          (businesses.isEmpty ? null : businesses.first);
      if (selectedBusinessSummary == null) {
        emit(EarningsState(isLoading: false, businesses: businesses));
        return;
      }

      if (selectedBusinessSummary.id != user?.selectedBusinessId) {
        await _userProfile.setSelectedBusiness(
          businessId: selectedBusinessSummary.id,
        );
      }
      if (requestId != _loadRequestId) return;

      final businessResult = await _getOwnedBusiness.execute(
        selectedBusinessSummary.id,
      );
      if (requestId != _loadRequestId) return;
      final selectedBusiness = switch (businessResult) {
        Success(value: final business) => business,
        FailureResult() => throw StateError('Could not load business details.'),
      };

      final range = _rangeFor(EarningsPeriod.currentMonth);
      emit(
        EarningsState(
          isLoading: false,
          businesses: businesses,
          selectedBusiness: selectedBusiness,
          dateRange: range,
        ),
      );
      await _replaceMetricsSubscription(selectedBusiness.id, range);
    } catch (_) {
      if (requestId != _loadRequestId) return;
      emit(const EarningsState(isLoading: false, hasError: true));
    }
  }

  Future<void> selectBusiness(BusinessModel business) =>
      _userProfile.setSelectedBusiness(businessId: business.id);

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
    emit(
      EarningsState(
        isLoading: false,
        businesses: state.businesses,
        selectedBusiness: business,
        period: period,
        dateRange: range,
        selectedProvider: state.selectedProvider,
      ),
    );
    await _replaceMetricsSubscription(
      business.id,
      range,
      staff: state.selectedProvider,
    );
  }

  Future<void> selectProvider(ServiceProviderModel? provider) async {
    final business = state.selectedBusiness;
    final range = state.dateRange;
    if (business == null || range == null) return;
    emit(
      EarningsState(
        isLoading: false,
        businesses: state.businesses,
        selectedBusiness: business,
        period: state.period,
        dateRange: range,
        selectedProvider: provider,
      ),
    );
    await _replaceMetricsSubscription(business.id, range, staff: provider);
  }

  Future<void> _replaceMetricsSubscription(
    String businessId,
    EarningsDateRange range, {
    ServiceProviderModel? staff,
  }) async {
    final requestId = ++_metricsRequestId;
    final previousSubscription = _detachMetricsSubscription();
    if (previousSubscription != null) {
      unawaited(previousSubscription.cancel());
    }
    if (isClosed || requestId != _metricsRequestId) return;

    _metricsSubscription = _watchEarningsMetrics
        .execute(
          businessId: businessId,
          startDate: range.start,
          endDate: range.end,
          staffId: staff?.id,
        )
        .listen((result) {
          if (isClosed || requestId != _metricsRequestId) return;
          switch (result) {
            case Success(value: final metrics):
              emit(state.copyWith(metrics: metrics, hasError: false));
            case FailureResult():
              emit(state.copyWith(hasError: true));
          }
        });
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

  void _cancelMetricsSubscription() {
    _metricsRequestId++;
    final metricsSubscription = _detachMetricsSubscription();
    if (metricsSubscription != null) {
      unawaited(metricsSubscription.cancel());
    }
  }

  StreamSubscription? _detachMetricsSubscription() {
    final metricsSubscription = _metricsSubscription;
    _metricsSubscription = null;
    _sessionStreamRegistry.unregister(metricsSubscription);
    return metricsSubscription;
  }

  @override
  Future<void> close() async {
    _userProfile.selectedBusinessId.removeListener(_onBusinessChanged);
    _metricsRequestId++;
    await _detachMetricsSubscription()?.cancel();
    return super.close();
  }
}
