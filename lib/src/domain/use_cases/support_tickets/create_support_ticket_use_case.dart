import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/support_ticket_category.dart';
import 'package:multibook/src/domain/repositories/support_ticket_repository.dart';

@injectable
class CreateSupportTicketUseCase {
  CreateSupportTicketUseCase(this._repository);

  final SupportTicketRepository _repository;

  Future<Result<void>> execute({
    required SupportTicketCategory category,
    required String subject,
    required String message,
  }) => _repository.createTicket(
    category: category,
    subject: subject,
    message: message,
  );
}
