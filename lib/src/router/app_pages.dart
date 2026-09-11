part of '../../../app.dart';

final router = GoRouter(
  refreshListenable: getIt<AuthenticationRepository>().authStateListenable,
  initialLocation: !getIt<OnboardingRepository>().hasSeenOnboarding
      ? AppRoutes.ONBOARDING
      : getIt<AuthenticationRepository>().isSignedIn
      ? AppRoutes.HOME
      : AppRoutes.SIGNIN,
  redirect: (context, state) {
    final isSignedIn = getIt<AuthenticationRepository>().isSignedIn;
    final hasSeenOnboarding = getIt<OnboardingRepository>().hasSeenOnboarding;
    final isAuthenticationRoute =
        state.matchedLocation == AppRoutes.SIGNIN ||
        state.matchedLocation == AppRoutes.SIGNUP;
    final isOnboardingRoute = state.matchedLocation == AppRoutes.ONBOARDING;

    if (!hasSeenOnboarding && !isOnboardingRoute) return AppRoutes.ONBOARDING;
    if (hasSeenOnboarding && isOnboardingRoute) {
      return isSignedIn ? AppRoutes.HOME : AppRoutes.SIGNIN;
    }

    if (!isSignedIn && !isAuthenticationRoute && !isOnboardingRoute) {
      return AppRoutes.SIGNIN;
    }

    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.SIGNIN,
      name: AppRoutes.SIGNIN,
      builder: (context, state) => const SigninView(),
    ),
    GoRoute(
      path: AppRoutes.ONBOARDING,
      name: AppRoutes.ONBOARDING,
      builder: (context, state) => const OnboardingView(),
    ),
    GoRoute(
      path: AppRoutes.USER_TYPE_CHECKER,
      name: AppRoutes.USER_TYPE_CHECKER,
      builder: (context, state) => const UserTypeCheckerView(),
    ),
    GoRoute(
      path: AppRoutes.HOME,
      name: AppRoutes.HOME,
      builder: (context, state) => const ClientEntryView(),
    ),
    GoRoute(
      path: AppRoutes.BUSINESS_HOME,
      name: AppRoutes.BUSINESS_HOME,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: AppRoutes.CUSTOMER_HOME,
      name: AppRoutes.CUSTOMER_HOME,
      builder: (context, state) => const CustomerHomeView(),
    ),
    GoRoute(
      path: AppRoutes.CUSTOMER_SEARCH,
      name: AppRoutes.CUSTOMER_SEARCH,
      builder: (context, state) => CustomerSearchView(
        initialTab: state.extra is CustomerHomeTab
            ? state.extra! as CustomerHomeTab
            : CustomerHomeTab.stays,
      ),
    ),
    GoRoute(
      path: AppRoutes.EXPLORE_STAY_RESULTS,
      name: AppRoutes.EXPLORE_STAY_RESULTS,
      builder: (context, state) => ExploreStayResultsView(
        arguments: state.extra! as ExploreStayResultsArguments,
      ),
    ),
    GoRoute(
      path: AppRoutes.EXPLORE_SERVICE_RESULTS,
      name: AppRoutes.EXPLORE_SERVICE_RESULTS,
      builder: (context, state) => ExploreServiceResultsView(
        arguments: state.extra! as ExploreServiceResultsArguments,
      ),
    ),
    GoRoute(
      path: AppRoutes.STAY_DETAIL,
      name: AppRoutes.STAY_DETAIL,
      builder: (context, state) =>
          StayDetailView(stay: state.extra! as StayListing),
    ),
    GoRoute(
      path: AppRoutes.SERVICE_DETAIL,
      name: AppRoutes.SERVICE_DETAIL,
      builder: (context, state) =>
          ServiceDetailView(service: state.extra! as ServiceListing),
    ),
    GoRoute(
      path: AppRoutes.CREATE_APPOINTMENT,
      name: AppRoutes.CREATE_APPOINTMENT,
      builder: (context, state) => CreateAppointmentView(
        arguments: state.extra! as CreateAppointmentArguments,
      ),
    ),
    GoRoute(
      path: AppRoutes.REVIEW_APPOINTMENT,
      name: AppRoutes.REVIEW_APPOINTMENT,
      builder: (context, state) => ReviewAppointmentView(
        arguments: state.extra! as ReviewAppointmentArguments,
      ),
    ),
    GoRoute(
      path: AppRoutes.APPOINTMENT_PAYMENT,
      name: AppRoutes.APPOINTMENT_PAYMENT,
      builder: (context, state) => AppointmentPaymentView(
        arguments: state.extra! as AppointmentPaymentArguments,
      ),
    ),
    GoRoute(
      path: AppRoutes.APPOINTMENT_CONFIRMED,
      name: AppRoutes.APPOINTMENT_CONFIRMED,
      builder: (context, state) => AppointmentConfirmedView(
        arguments: state.extra! as AppointmentConfirmedArguments,
      ),
    ),
    GoRoute(
      path: AppRoutes.APPOINTMENT_DETAILS,
      name: AppRoutes.APPOINTMENT_DETAILS,
      builder: (context, state) => AppointmentDetailsView(
        arguments: AppointmentDetailsArguments(
          appointment: state.extra! as AppointmentModel,
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.RESCHEDULE_APPOINTMENT,
      name: AppRoutes.RESCHEDULE_APPOINTMENT,
      builder: (context, state) => RescheduleAppointmentView(
        arguments: state.extra! as RescheduleAppointmentArguments,
      ),
    ),
    GoRoute(
      path: AppRoutes.BOOKING_DETAILS,
      name: AppRoutes.BOOKING_DETAILS,
      builder: (context, state) => BookingDetailsView(
        arguments: state.extra! as BookingDetailsArguments,
      ),
    ),
    GoRoute(
      path: AppRoutes.REVIEW_STAY,
      name: AppRoutes.REVIEW_STAY,
      builder: (context, state) =>
          ReviewStayView(arguments: state.extra! as ReviewStayArguments),
    ),
    GoRoute(
      path: AppRoutes.PAYMENT,
      name: AppRoutes.PAYMENT,
      builder: (context, state) =>
          PaymentView(arguments: state.extra! as PaymentArguments),
    ),
    GoRoute(
      path: AppRoutes.BOOKING_CONFIRMED,
      name: AppRoutes.BOOKING_CONFIRMED,
      builder: (context, state) => BookingConfirmedView(
        arguments: state.extra! as BookingConfirmedArguments,
      ),
    ),
    GoRoute(
      path: AppRoutes.CUSTOMER_BOOKING_DETAILS,
      name: AppRoutes.CUSTOMER_BOOKING_DETAILS,
      builder: (context, state) =>
          CustomerBookingDetailsView(booking: state.extra! as BookingModel),
    ),
    GoRoute(
      path: AppRoutes.ADD_BUSINESS,
      name: AppRoutes.ADD_BUSINESS,
      builder: (context, state) => const AddBusinessView(),
    ),
    GoRoute(
      path: AppRoutes.MY_BUSINESSES,
      name: AppRoutes.MY_BUSINESSES,
      builder: (context, state) => const MyBusinessesView(),
    ),
    GoRoute(
      path: AppRoutes.MANAGE_CATALOG,
      name: AppRoutes.MANAGE_CATALOG,
      builder: (context, state) => const ManageCatalogView(),
    ),
    GoRoute(
      path: AppRoutes.ACCOUNT_SETTINGS,
      name: AppRoutes.ACCOUNT_SETTINGS,
      builder: (context, state) => const AccountSettingsView(),
    ),
    GoRoute(
      path: AppRoutes.CHANGE_PASSWORD,
      name: AppRoutes.CHANGE_PASSWORD,
      builder: (context, state) => const ChangePasswordView(),
    ),
    GoRoute(
      path: AppRoutes.LANGUAGE_CURRENCY,
      name: AppRoutes.LANGUAGE_CURRENCY,
      builder: (context, state) => const LanguageCurrencyView(),
    ),
    GoRoute(
      path: AppRoutes.APPEARANCE,
      name: AppRoutes.APPEARANCE,
      builder: (context, state) => const AppearanceView(),
    ),
    GoRoute(
      path: AppRoutes.CUSTOMER_EDIT_PROFILE,
      name: AppRoutes.CUSTOMER_EDIT_PROFILE,
      builder: (context, state) => const CustomerEditProfileView(),
    ),
    GoRoute(
      path: AppRoutes.TERMS_OF_SERVICE,
      name: AppRoutes.TERMS_OF_SERVICE,
      builder: (context, state) => const LegalDocumentView(
        documentType: LegalDocumentType.termsOfService,
      ),
    ),
    GoRoute(
      path: AppRoutes.PRIVACY_POLICY,
      name: AppRoutes.PRIVACY_POLICY,
      builder: (context, state) => const LegalDocumentView(
        documentType: LegalDocumentType.privacyPolicy,
      ),
    ),
    GoRoute(
      path: AppRoutes.PROVIDER_TERMS_OF_SERVICE,
      name: AppRoutes.PROVIDER_TERMS_OF_SERVICE,
      builder: (context, state) => const LegalDocumentView(
        documentType: LegalDocumentType.termsOfService,
        audience: LegalDocumentAudience.provider,
      ),
    ),
    GoRoute(
      path: AppRoutes.PROVIDER_PRIVACY_POLICY,
      name: AppRoutes.PROVIDER_PRIVACY_POLICY,
      builder: (context, state) => const LegalDocumentView(
        documentType: LegalDocumentType.privacyPolicy,
        audience: LegalDocumentAudience.provider,
      ),
    ),
    GoRoute(
      path: AppRoutes.SUPPORT_TICKETS,
      name: AppRoutes.SUPPORT_TICKETS,
      builder: (context, state) => const SupportTicketsView(),
    ),
    GoRoute(
      path: AppRoutes.CREATE_SUPPORT_TICKET,
      name: AppRoutes.CREATE_SUPPORT_TICKET,
      builder: (context, state) => const CreateSupportTicketView(),
    ),
    GoRoute(
      path: AppRoutes.HELP_CENTER,
      name: AppRoutes.HELP_CENTER,
      builder: (context, state) => const HelpCenterView(),
    ),
    GoRoute(
      path: AppRoutes.HELP_ARTICLE_DETAIL,
      name: AppRoutes.HELP_ARTICLE_DETAIL,
      builder: (context, state) =>
          HelpArticleDetailView(article: state.extra! as HelpArticleModel),
    ),
    GoRoute(
      path: AppRoutes.PAYMENT_METHODS,
      name: AppRoutes.PAYMENT_METHODS,
      builder: (context, state) => const PaymentMethodsView(),
    ),
    GoRoute(
      path: AppRoutes.ADD_PAYMENT_METHOD,
      name: AppRoutes.ADD_PAYMENT_METHOD,
      builder: (context, state) => const AddPaymentMethodView(),
    ),
    GoRoute(
      path: AppRoutes.PROMOTIONS,
      name: AppRoutes.PROMOTIONS,
      builder: (context, state) => const PromotionsView(),
    ),
    GoRoute(
      path: AppRoutes.CREATE_PROMOTION,
      name: AppRoutes.CREATE_PROMOTION,
      builder: (context, state) =>
          CreatePromotionView(business: state.extra! as BusinessModel),
    ),
    GoRoute(
      path: AppRoutes.AVAILABILITY_CALENDAR,
      name: AppRoutes.AVAILABILITY_CALENDAR,
      builder: (context, state) => const AvailabilityCalendarView(),
    ),
    GoRoute(
      path: AppRoutes.CHAT_LIST,
      name: AppRoutes.CHAT_LIST,
      builder: (context, state) => const ChatListView(),
    ),
    GoRoute(
      path: AppRoutes.NOTIFICATIONS,
      name: AppRoutes.NOTIFICATIONS,
      builder: (context, state) => const NotificationsView(),
    ),
    GoRoute(
      path: AppRoutes.CHAT_CONVERSATION,
      name: AppRoutes.CHAT_CONVERSATION,
      builder: (context, state) => ChatConversationView(
        arguments: state.extra! as ChatConversationArguments,
      ),
    ),
    GoRoute(
      path: AppRoutes.SIGNUP,
      name: AppRoutes.SIGNUP,
      builder: (context, state) => const SignupView(),
    ),
  ],
);
