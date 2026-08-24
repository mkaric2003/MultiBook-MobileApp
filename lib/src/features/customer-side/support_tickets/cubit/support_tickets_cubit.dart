import 'dart:async';

import 'package:aquabook/src/data/repositories/support_ticket_repository.dart';
import 'package:aquabook/src/features/customer-side/support_tickets/cubit/support_tickets_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SupportTicketsCubit extends Cubit<SupportTicketsState> {
  SupportTicketsCubit(this._repository) : super(const SupportTicketsState());

  final SupportTicketRepository _repository;
  StreamSubscription? _ticketsSubscription;

  Future<void> load() async {
    await _ticketsSubscription?.cancel();
    _ticketsSubscription = _repository.watchMyTickets().listen(
      (tickets) {
        if (!isClosed) {
          emit(SupportTicketsState(isLoading: false, tickets: tickets));
        }
      },
      onError: (_, _) {
        if (!isClosed) {
          emit(state.copyWith(isLoading: false, hasError: true));
        }
      },
    );
  }

  @override
  Future<void> close() async {
    await _ticketsSubscription?.cancel();
    return super.close();
  }
}
