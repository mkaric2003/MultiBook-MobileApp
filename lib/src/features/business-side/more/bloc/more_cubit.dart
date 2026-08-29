import 'dart:async';
import 'dart:developer';

import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/core/session/session_stream_registry.dart';
import 'package:multibook/src/data/repositories/business_repository.dart';
import 'package:multibook/src/data/repositories/chat_repository.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/business-side/more/bloc/more_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MoreCubit extends Cubit<MoreState> {
  MoreCubit(
    this._businessRepository,
    this._userRepository,
    this._chatRepository,
    this._sessionStreamRegistry,
  ) : super(const MoreState());

  final BusinessRepository _businessRepository;
  final UserProfileUseCase _userRepository;
  final ChatRepository _chatRepository;
  final SessionStreamRegistry _sessionStreamRegistry;
  StreamSubscription? _conversationsSubscription;

  Future<void> load() async {
    final user = await _userRepository.getCurrentUser();
    final businesses = await _businessRepository.getOwnedBusinesses();
    final selectedBusiness =
        _findBusiness(businesses, user?.selectedBusinessId) ??
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
    await _chatRepository.ensureUnreadMessagesCount();
    await _conversationsSubscription?.cancel();
    _sessionStreamRegistry.unregister(_conversationsSubscription);
    _conversationsSubscription = _chatRepository
        .watchUnreadMessagesCount()
        .listen(
          (count) {
            if (!isClosed) {
              emit(state.copyWith(unreadMessagesCount: count));
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
  }

  @override
  Future<void> close() async {
    _sessionStreamRegistry.unregister(_conversationsSubscription);
    await _conversationsSubscription?.cancel();
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
