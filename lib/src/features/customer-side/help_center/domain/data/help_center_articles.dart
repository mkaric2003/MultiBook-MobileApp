import 'package:multibook/src/features/customer-side/help_center/domain/enums/help_article_id.dart';
import 'package:multibook/src/features/customer-side/help_center/domain/enums/help_center_topic.dart';
import 'package:multibook/src/features/customer-side/help_center/domain/models/help_article_model.dart';

const helpCenterArticles = <HelpArticleModel>[
  HelpArticleModel(
    id: HelpArticleId.findingAndBookingStay,
    topic: HelpCenterTopic.stays,
  ),
  HelpArticleModel(
    id: HelpArticleId.stayDatesGuestsAndRooms,
    topic: HelpCenterTopic.stays,
  ),
  HelpArticleModel(
    id: HelpArticleId.bookingAndAppointmentStatuses,
    topic: HelpCenterTopic.appointments,
  ),
  HelpArticleModel(
    id: HelpArticleId.reschedulingAndCancelling,
    topic: HelpCenterTopic.changesAndCancellations,
  ),
  HelpArticleModel(
    id: HelpArticleId.paymentsCashAndNoShows,
    topic: HelpCenterTopic.payments,
  ),
  HelpArticleModel(
    id: HelpArticleId.paymentSecurityAndReceipts,
    topic: HelpCenterTopic.payments,
  ),
  HelpArticleModel(
    id: HelpArticleId.profileAndPersonalData,
    topic: HelpCenterTopic.accountAndPrivacy,
  ),
  HelpArticleModel(
    id: HelpArticleId.messagesNotificationsAndSupport,
    topic: HelpCenterTopic.messagesAndNotifications,
  ),
  HelpArticleModel(
    id: HelpArticleId.locationAndSearch,
    topic: HelpCenterTopic.technicalSupport,
  ),
  HelpArticleModel(
    id: HelpArticleId.reportingAndStayingSafe,
    topic: HelpCenterTopic.safetyAndSupport,
  ),
];
