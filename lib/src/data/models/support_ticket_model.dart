import 'package:multibook/src/data/enums/support_ticket_category.dart';
import 'package:multibook/src/data/enums/support_ticket_status.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'support_ticket_model.mapper.dart';

@MappableClass()
final class SupportTicketModel with SupportTicketModelMappable {
  const SupportTicketModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.category,
    required this.status,
    required this.subject,
    required this.message,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String customerId;
  final String customerName;
  final String customerEmail;
  final SupportTicketCategory category;
  final SupportTicketStatus status;
  final String subject;
  final String message;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
