import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/networking/api_client.dart';
import 'package:multibook/src/data/enums/support_ticket_category.dart';
import 'package:multibook/src/data/models/support_ticket_page.dart';

@lazySingleton
class SupportTicketApiDataSource {
  SupportTicketApiDataSource(this._client);

  final ApiClient _client;

  Future<SupportTicketPage> getTickets({
    String? cursor,
    int pageSize = 60,
  }) async {
    final response = await _client.get(
      '/v1/support-tickets',
      queryParameters: {
        if (cursor != null) 'cursor': cursor,
        'page_size': pageSize,
      },
    );
    return SupportTicketPageMapper.fromMap(response.data!);
  }

  Future<void> createTicket({
    required SupportTicketCategory category,
    required String subject,
    required String message,
  }) async {
    await _client.post(
      '/v1/support-tickets',
      data: {
        'category': category.name,
        'subject': subject.trim(),
        'message': message.trim(),
      },
    );
  }
}
