import 'package:multibook/src/data/enums/support_ticket_category.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/use_cases/support_tickets/create_support_ticket_use_case.dart';
import 'package:multibook/src/features/customer-side/support_tickets/cubit/create_support_ticket_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateSupportTicketCubit extends Cubit<CreateSupportTicketState> {
  CreateSupportTicketCubit(this._createTicket)
    : super(const CreateSupportTicketState());

  final CreateSupportTicketUseCase _createTicket;

  Future<void> submit({
    required SupportTicketCategory category,
    required String subject,
    required String message,
  }) async {
    if (state.isSubmitting) return;
    emit(const CreateSupportTicketState(isSubmitting: true));
    final result = await _createTicket.execute(
      category: category,
      subject: subject,
      message: message,
    );
    if (isClosed) return;
    switch (result) {
      case Success():
        emit(const CreateSupportTicketState(isSuccess: true));
      case FailureResult():
        emit(const CreateSupportTicketState(hasError: true));
    }
  }
}
