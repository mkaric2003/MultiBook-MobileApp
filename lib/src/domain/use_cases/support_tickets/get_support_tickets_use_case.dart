import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/support_ticket_page.dart';
import 'package:multibook/src/domain/repositories/support_ticket_repository.dart';

@injectable
class GetSupportTicketsUseCase {
  GetSupportTicketsUseCase(this._repository);

  final SupportTicketRepository _repository;

  Future<Result<SupportTicketPage>> execute({
    String? cursor,
    int pageSize = 60,
  }) => _repository.getTickets(cursor: cursor, pageSize: pageSize);
}
