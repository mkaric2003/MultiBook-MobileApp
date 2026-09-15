import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/support_ticket_category.dart';
import 'package:multibook/src/data/models/support_ticket_page.dart';

abstract class SupportTicketRepository {
  Future<Result<SupportTicketPage>> getTickets({
    String? cursor,
    int pageSize = 60,
  });

  Future<Result<void>> createTicket({
    required SupportTicketCategory category,
    required String subject,
    required String message,
  });
}
