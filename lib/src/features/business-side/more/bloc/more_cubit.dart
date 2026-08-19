import 'dart:async';

import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/data/repositories/chat_repository.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
import 'package:aquabook/src/features/business-side/more/bloc/more_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MoreCubit extends Cubit<MoreState> {
  MoreCubit(
    this._businessRepository,
    this._userRepository,
    this._chatRepository,
  ) : super(const MoreState());

  final BusinessRepository _businessRepository;
  final UserRepository _userRepository;
  final ChatRepository _chatRepository;
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
    await _conversationsSubscription?.cancel();
    _conversationsSubscription = _chatRepository.watchConversations().listen(
      (conversations) => emit(
        state.copyWith(
          unreadMessagesCount: conversations.fold<int>(
            0,
            (total, conversation) => total + conversation.unreadBusinessCount,
          ),
        ),
      ),
    );
  }

  @override
  Future<void> close() async {
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
