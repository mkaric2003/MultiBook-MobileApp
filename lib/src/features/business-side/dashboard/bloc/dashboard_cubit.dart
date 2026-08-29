import 'dart:async';
import 'dart:developer';

import 'package:multibook/src/data/enums/user_type.dart';
import 'package:multibook/src/core/session/session_stream_registry.dart';
import 'package:multibook/src/data/repositories/business_metrics_repository.dart';
import 'package:multibook/src/data/repositories/business_repository.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/business-side/dashboard/bloc/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(
    this._userRepository,
    this._businessRepository,
    this._businessMetricsRepository,
    this._sessionStreamRegistry,
  ) : super(const DashboardState());

  final UserProfileUseCase _userRepository;
  final BusinessRepository _businessRepository;
  final BusinessMetricsRepository _businessMetricsRepository;
  final SessionStreamRegistry _sessionStreamRegistry;
  StreamSubscription? _summarySubscription;
  StreamSubscription? _monthSubscription;

  Future<void> load() async {
    await _cancelMetricSubscriptions();
    final user = await _userRepository.getCurrentUser();
    if (user == null || user.type != UserType.provider) {
      emit(const DashboardState(isLoading: false));
      return;
    }

    var business = user.selectedBusinessId == null
        ? null
        : await _businessRepository.getBusiness(
            businessId: user.selectedBusinessId!,
          );
    business ??= await _businessRepository.getFirstOwnedBusiness();

    if (business != null && business.id != user.selectedBusinessId) {
      await _userRepository.setSelectedBusiness(businessId: business.id);
    }

    emit(DashboardState(isLoading: false, business: business));
    if (business == null) return;
    try {
      await _businessMetricsRepository.initialize(business.id);
    } catch (_) {
      // A missing metrics document simply renders zero values until the next
      // booking or appointment event creates it.
    }
    _summarySubscription = _businessMetricsRepository
        .watchSummary(business.id)
        .listen(
          (metrics) {
            if (!isClosed) emit(state.copyWith(metrics: metrics));
          },
          onError: (Object error, StackTrace stackTrace) {
            log(
              'Could not watch dashboard summary.',
              name: 'DashboardCubit',
              error: error,
              stackTrace: stackTrace,
            );
          },
        );
    _sessionStreamRegistry.register(_summarySubscription!);
    _monthSubscription = _businessMetricsRepository
        .watchCurrentMonth(business.id)
        .listen(
          (monthlyMetrics) {
            if (!isClosed) {
              emit(state.copyWith(monthlyMetrics: monthlyMetrics));
            }
          },
          onError: (Object error, StackTrace stackTrace) {
            log(
              'Could not watch dashboard month metrics.',
              name: 'DashboardCubit',
              error: error,
              stackTrace: stackTrace,
            );
          },
        );
    _sessionStreamRegistry.register(_monthSubscription!);
  }

  Future<void> _cancelMetricSubscriptions() async {
    final summarySubscription = _summarySubscription;
    final monthSubscription = _monthSubscription;
    _summarySubscription = null;
    _monthSubscription = null;
    _sessionStreamRegistry.unregister(summarySubscription);
    _sessionStreamRegistry.unregister(monthSubscription);
    await summarySubscription?.cancel();
    await monthSubscription?.cancel();
  }

  @override
  Future<void> close() async {
    await _cancelMetricSubscriptions();
    return super.close();
  }
}
