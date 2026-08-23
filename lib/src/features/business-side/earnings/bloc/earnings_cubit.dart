import 'dart:async';

import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/data/repositories/business_metrics_repository.dart';
import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
import 'package:aquabook/src/features/business-side/earnings/bloc/earnings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class EarningsCubit extends Cubit<EarningsState> {
  EarningsCubit(
    this._userRepository,
    this._businessRepository,
    this._businessMetricsRepository,
  ) : super(const EarningsState());

  final UserRepository _userRepository;
  final BusinessRepository _businessRepository;
  final BusinessMetricsRepository _businessMetricsRepository;
  StreamSubscription? _monthlyMetricsSubscription;
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
        ),
      );
      try {
        await _businessMetricsRepository.initialize(selectedBusiness.id);
      } catch (_) {
        // New reservations will create the metrics document automatically.
      }
      _monthlyMetricsSubscription = _businessMetricsRepository
          .watchCurrentMonth(selectedBusiness.id)
          .listen(
            (metrics) {
              if (!isClosed) emit(state.copyWith(monthlyMetrics: metrics));
            },
            onError: (_, _) {
              if (!isClosed) emit(state.copyWith(hasError: true));
            },
          );
    } catch (_) {
      if (requestId != _loadRequestId) return;
      emit(const EarningsState(isLoading: false, hasError: true));
    }
  }

  Future<void> selectBusiness(BusinessModel business) =>
      load(businessId: business.id);

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
    await _monthlyMetricsSubscription?.cancel();
    _monthlyMetricsSubscription = null;
  }

  @override
  Future<void> close() async {
    await _cancelMetricsSubscription();
    return super.close();
  }
}
