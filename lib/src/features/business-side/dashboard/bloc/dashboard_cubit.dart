import 'dart:async';
import 'dart:developer';

import 'package:multibook/src/data/enums/user_type.dart';
import 'package:multibook/src/core/session/session_stream_registry.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/use_cases/dashboard_metrics/watch_dashboard_metrics_use_case.dart';
import 'package:multibook/src/domain/use_cases/businesses/get_selected_business_use_case.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/business-side/dashboard/bloc/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(
    this._userRepository,
    this._getSelectedBusiness,
    this._watchDashboardMetrics,
    this._sessionStreamRegistry,
  ) : super(const DashboardState());

  final UserProfileUseCase _userRepository;
  final GetSelectedBusinessUseCase _getSelectedBusiness;
  final WatchDashboardMetricsUseCase _watchDashboardMetrics;
  final SessionStreamRegistry _sessionStreamRegistry;
  StreamSubscription? _metricsSubscription;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    await load();
    if (!isClosed) {
      _userRepository.selectedBusinessId.addListener(_onBusinessChanged);
    }
  }

  void _onBusinessChanged() {
    unawaited(load());
  }

  Future<void> load() async {
    await _cancelMetricSubscriptions();
    final user = await _userRepository.getCurrentUser();
    if (user == null || user.type != UserType.provider) {
      emit(const DashboardState(isLoading: false));
      return;
    }

    final selection = await _getSelectedBusiness.execute(
      user.selectedBusinessId,
    );
    final business = switch (selection) {
      Success(value: final value) => value,
      FailureResult() => null,
    };

    if (business != null && business.id != user.selectedBusinessId) {
      await _userRepository.setSelectedBusiness(businessId: business.id);
    }

    emit(DashboardState(isLoading: false, business: business));
    if (business == null) return;
    _metricsSubscription = _watchDashboardMetrics
        .execute(business.id)
        .listen(
          (result) {
            switch (result) {
              case Success(value: final metrics):
                if (!isClosed) emit(state.copyWith(metrics: metrics));
              case FailureResult(failure: final failure):
                log(
                  'Could not watch dashboard metrics.',
                  name: 'DashboardCubit',
                  error: failure,
                );
            }
          },
          onError: (Object error, StackTrace stackTrace) {
            log(
              'Dashboard metrics stream failed.',
              name: 'DashboardCubit',
              error: error,
              stackTrace: stackTrace,
            );
          },
        );
    _sessionStreamRegistry.register(_metricsSubscription!);
  }

  Future<void> _cancelMetricSubscriptions() async {
    final metricsSubscription = _metricsSubscription;
    _metricsSubscription = null;
    _sessionStreamRegistry.unregister(metricsSubscription);
    await metricsSubscription?.cancel();
  }

  @override
  Future<void> close() async {
    _userRepository.selectedBusinessId.removeListener(_onBusinessChanged);
    await _cancelMetricSubscriptions();
    return super.close();
  }
}
