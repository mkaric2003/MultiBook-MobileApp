import 'package:dart_mappable/dart_mappable.dart';

part 'help_article_id.mapper.dart';

@MappableEnum()
enum HelpArticleId {
  findingAndBookingStay,
  stayDatesGuestsAndRooms,
  bookingAndAppointmentStatuses,
  reschedulingAndCancelling,
  paymentsCashAndNoShows,
  paymentSecurityAndReceipts,
  profileAndPersonalData,
  messagesNotificationsAndSupport,
  locationAndSearch,
  reportingAndStayingSafe,
}
