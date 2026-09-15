import 'package:dart_mappable/dart_mappable.dart';
import 'package:multibook/src/data/models/support_ticket_model.dart';

part 'support_ticket_page.mapper.dart';

@MappableClass()
final class SupportTicketPage with SupportTicketPageMappable {
  const SupportTicketPage({required this.items, this.nextCursor});

  final List<SupportTicketModel> items;
  final String? nextCursor;
}
