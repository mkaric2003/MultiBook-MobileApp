import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/support_ticket_api_data_source.dart';
import 'package:multibook/src/data/enums/support_ticket_category.dart';
import 'package:multibook/src/data/models/support_ticket_page.dart';
import 'package:multibook/src/domain/repositories/support_ticket_repository.dart';

@LazySingleton(as: SupportTicketRepository)
class SupportTicketRepositoryImpl implements SupportTicketRepository {
  SupportTicketRepositoryImpl(this._source, this._executor);

  final SupportTicketApiDataSource _source;
  final RestRepositoryExecutor _executor;

  @override
  Future<Result<SupportTicketPage>> getTickets({
    String? cursor,
    int pageSize = 60,
  }) => _executor.execute(
    () => _source.getTickets(cursor: cursor, pageSize: pageSize),
  );

  @override
  Future<Result<void>> createTicket({
    required SupportTicketCategory category,
    required String subject,
    required String message,
  }) => _executor.execute(
    () => _source.createTicket(
      category: category,
      subject: subject,
      message: message,
    ),
  );
}
