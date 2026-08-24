import 'package:aquabook/src/data/enums/support_ticket_category.dart';
import 'package:aquabook/src/data/repositories/support_ticket_repository.dart';
import 'package:aquabook/src/features/customer-side/support_tickets/cubit/create_support_ticket_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateSupportTicketCubit extends Cubit<CreateSupportTicketState> {
  CreateSupportTicketCubit(this._repository)
    : super(const CreateSupportTicketState());

  final SupportTicketRepository _repository;

  Future<void> submit({
    required SupportTicketCategory category,
    required String subject,
    required String message,
  }) async {
    if (state.isSubmitting) return;
    emit(const CreateSupportTicketState(isSubmitting: true));
    try {
      await _repository.createTicket(
        category: category,
        subject: subject,
        message: message,
      );
      emit(const CreateSupportTicketState(isSuccess: true));
    } on SupportTicketException {
      emit(const CreateSupportTicketState(hasError: true));
    }
  }
}
