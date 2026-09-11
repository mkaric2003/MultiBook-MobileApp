import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/use_cases/support_tickets/get_support_tickets_use_case.dart';
import 'package:multibook/src/features/customer-side/support_tickets/cubit/support_tickets_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SupportTicketsCubit extends Cubit<SupportTicketsState> {
  SupportTicketsCubit(this._getTickets) : super(const SupportTicketsState());

  final GetSupportTicketsUseCase _getTickets;

  Future<void> load() async {
    if (!state.isLoading) emit(state.copyWith(isLoading: true));
    final result = await _getTickets.execute();
    if (isClosed) return;
    switch (result) {
      case Success(:final value):
        emit(SupportTicketsState(isLoading: false, tickets: value.items));
      case FailureResult():
        emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}
