import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/core/services/notification_device_service.dart';
import 'package:multibook/src/core/session/session_stream_registry.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/use_cases/businesses/get_owned_businesses_use_case.dart';
import 'package:multibook/src/domain/use_cases/chat/get_unread_messages_count_use_case.dart';
import 'package:multibook/src/domain/use_cases/chat/watch_unread_messages_count_use_case.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/business-side/more/bloc/more_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MoreCubit extends Cubit<MoreState> with WidgetsBindingObserver {
  MoreCubit(
    this._getOwnedBusinessesUseCase,
    this._userRepository,
    this._watchUnreadMessagesCount,
    this._getUnreadMessagesCount,
    this._notificationDeviceService,
    this._sessionStreamRegistry,
  ) : super(const MoreState());

  final GetOwnedBusinessesUseCase _getOwnedBusinessesUseCase;
  final UserProfileUseCase _userRepository;
  final WatchUnreadMessagesCountUseCase _watchUnreadMessagesCount;
  final GetUnreadMessagesCountUseCase _getUnreadMessagesCount;
  final NotificationDeviceService _notificationDeviceService;
  final SessionStreamRegistry _sessionStreamRegistry;
  StreamSubscription<Result<int>>? _conversationsSubscription;
  StreamSubscription<Map<String, String>>? _foregroundMessageSubscription;
  bool _isObservingLifecycle = false;

  Future<void> load({String? businessId}) async {
    final user = await _userRepository.getCurrentUser();
    final businessesResult = await _getOwnedBusinessesUseCase.execute();
    final businesses = switch (businessesResult) {
      Success(value: final values) => values,
      FailureResult() => const <BusinessModel>[],
    };
    final selectedBusiness =
        _findBusiness(businesses, businessId ?? user?.selectedBusinessId) ??
        (businesses.isEmpty ? null : businesses.first);

    if (selectedBusiness != null &&
        selectedBusiness.id != user?.selectedBusinessId) {
      await _userRepository.setSelectedBusiness(
        businessId: selectedBusiness.id,
      );
    }

    emit(
      MoreState(
        isLoading: false,
        businesses: businesses,
        selectedBusiness: selectedBusiness,
      ),
    );
    await _conversationsSubscription?.cancel();
    _sessionStreamRegistry.unregister(_conversationsSubscription);
    _conversationsSubscription = _watchUnreadMessagesCount.execute().listen(
      (result) {
        if (isClosed) return;
        switch (result) {
          case Success(:final value):
            emit(state.copyWith(unreadMessagesCount: value));
          case FailureResult():
            log('Could not refresh unread messages.', name: 'MoreCubit');
        }
      },
      onError: (Object error, StackTrace stackTrace) {
        log(
          'Could not watch unread messages.',
          name: 'MoreCubit',
          error: error,
          stackTrace: stackTrace,
        );
      },
    );
    _sessionStreamRegistry.register(_conversationsSubscription!);
    _foregroundMessageSubscription ??= _notificationDeviceService
        .onForegroundMessage
        .where((data) => data['type'] == 'chat_message')
        .listen((_) => unawaited(_refreshUnreadMessagesCount()));
    if (!_isObservingLifecycle) {
      WidgetsBinding.instance.addObserver(this);
      _isObservingLifecycle = true;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_refreshUnreadMessagesCount());
    }
  }

  Future<void> _refreshUnreadMessagesCount() async {
    final result = await _getUnreadMessagesCount.execute();
    if (!isClosed && result is Success<int>) {
      emit(state.copyWith(unreadMessagesCount: result.value));
    }
  }

  @override
  Future<void> close() async {
    if (_isObservingLifecycle) {
      WidgetsBinding.instance.removeObserver(this);
    }
    _sessionStreamRegistry.unregister(_conversationsSubscription);
    await _conversationsSubscription?.cancel();
    await _foregroundMessageSubscription?.cancel();
    return super.close();
  }

  Future<void> selectBusiness(BusinessModel business) async {
    if (business.id == state.selectedBusiness?.id) {
      return;
    }

    await _userRepository.setSelectedBusiness(businessId: business.id);
    emit(
      MoreState(
        isLoading: false,
        businesses: state.businesses,
        selectedBusiness: business,
      ),
    );
  }

  BusinessModel? _findBusiness(
    List<BusinessModel> businesses,
    String? businessId,
  ) {
    for (final business in businesses) {
      if (business.id == businessId) {
        return business;
      }
    }
    return null;
  }
}
