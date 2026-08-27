import 'package:dart_mappable/dart_mappable.dart';

part 'support_ticket_category.mapper.dart';

@MappableEnum()
enum SupportTicketCategory {
  account,
  booking,
  appointment,
  payment,
  technical,
  other,
}
