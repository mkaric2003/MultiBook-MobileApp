part of '../../../app.dart';

GoRoute _appRoute({
  required String path,
  required String name,
  required Widget Function(BuildContext context, GoRouterState state) builder,
}) => GoRoute(
  path: path,
  name: name,
  pageBuilder: (context, state) => MaterialPage<void>(
    key: state.pageKey,
    child: AppBackground(child: builder(context, state)),
  ),
);

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
    _appRoute(
      path: AppRoutes.SIGNIN,
      name: AppRoutes.SIGNIN,
      builder: (context, state) => const SigninView(),
    ),
    _appRoute(
      path: AppRoutes.ONBOARDING,
      name: AppRoutes.ONBOARDING,
      builder: (context, state) => const OnboardingView(),
    ),
    _appRoute(
      path: AppRoutes.USER_TYPE_CHECKER,
      name: AppRoutes.USER_TYPE_CHECKER,
      builder: (context, state) => const UserTypeCheckerView(),
    ),
    _appRoute(
      path: AppRoutes.HOME,
      name: AppRoutes.HOME,
      builder: (context, state) => const ClientEntryView(),
    ),
    _appRoute(
      path: AppRoutes.BUSINESS_HOME,
      name: AppRoutes.BUSINESS_HOME,
      builder: (context, state) => const HomeView(),
    ),
    _appRoute(
      path: AppRoutes.CUSTOMER_HOME,
      name: AppRoutes.CUSTOMER_HOME,
      builder: (context, state) => const CustomerHomeView(),
    ),
    _appRoute(
      path: AppRoutes.CUSTOMER_SEARCH,
      name: AppRoutes.CUSTOMER_SEARCH,
      builder: (context, state) => CustomerSearchView(
        initialTab: state.extra is CustomerHomeTab
            ? state.extra! as CustomerHomeTab
            : CustomerHomeTab.stays,
      ),
    ),
    _appRoute(
      path: AppRoutes.EXPLORE_STAY_RESULTS,
      name: AppRoutes.EXPLORE_STAY_RESULTS,
      builder: (context, state) => ExploreStayResultsView(
        arguments: state.extra! as ExploreStayResultsArguments,
      ),
    ),
    _appRoute(
      path: AppRoutes.EXPLORE_SERVICE_RESULTS,
      name: AppRoutes.EXPLORE_SERVICE_RESULTS,
      builder: (context, state) => ExploreServiceResultsView(
        arguments: state.extra! as ExploreServiceResultsArguments,
      ),
    ),
    _appRoute(
      path: AppRoutes.STAY_DETAIL,
      name: AppRoutes.STAY_DETAIL,
      builder: (context, state) =>
          StayDetailView(stay: state.extra! as StayListing),
    ),
    _appRoute(
      path: AppRoutes.SERVICE_DETAIL,
      name: AppRoutes.SERVICE_DETAIL,
      builder: (context, state) =>
          ServiceDetailView(service: state.extra! as ServiceListing),
    ),
    _appRoute(
      path: AppRoutes.CREATE_APPOINTMENT,
      name: AppRoutes.CREATE_APPOINTMENT,
      builder: (context, state) => CreateAppointmentView(
        arguments: state.extra! as CreateAppointmentArguments,
      ),
    ),
    _appRoute(
      path: AppRoutes.REVIEW_APPOINTMENT,
      name: AppRoutes.REVIEW_APPOINTMENT,
      builder: (context, state) => ReviewAppointmentView(
        arguments: state.extra! as ReviewAppointmentArguments,
      ),
    ),
    _appRoute(
      path: AppRoutes.APPOINTMENT_PAYMENT,
      name: AppRoutes.APPOINTMENT_PAYMENT,
      builder: (context, state) => AppointmentPaymentView(
        arguments: state.extra! as AppointmentPaymentArguments,
      ),
    ),
    _appRoute(
      path: AppRoutes.APPOINTMENT_CONFIRMED,
      name: AppRoutes.APPOINTMENT_CONFIRMED,
      builder: (context, state) => AppointmentConfirmedView(
        arguments: state.extra! as AppointmentConfirmedArguments,
      ),
    ),
    _appRoute(
      path: AppRoutes.APPOINTMENT_DETAILS,
      name: AppRoutes.APPOINTMENT_DETAILS,
      builder: (context, state) => AppointmentDetailsView(
        arguments: AppointmentDetailsArguments(
          appointment: state.extra! as AppointmentModel,
        ),
      ),
    ),
    _appRoute(
      path: AppRoutes.RESCHEDULE_APPOINTMENT,
      name: AppRoutes.RESCHEDULE_APPOINTMENT,
      builder: (context, state) => RescheduleAppointmentView(
        arguments: state.extra! as RescheduleAppointmentArguments,
      ),
    ),
    _appRoute(
      path: AppRoutes.BOOKING_DETAILS,
      name: AppRoutes.BOOKING_DETAILS,
      builder: (context, state) => BookingDetailsView(
        arguments: state.extra! as BookingDetailsArguments,
      ),
    ),
    _appRoute(
      path: AppRoutes.REVIEW_STAY,
      name: AppRoutes.REVIEW_STAY,
      builder: (context, state) =>
          ReviewStayView(arguments: state.extra! as ReviewStayArguments),
    ),
    _appRoute(
      path: AppRoutes.PAYMENT,
      name: AppRoutes.PAYMENT,
      builder: (context, state) =>
          PaymentView(arguments: state.extra! as PaymentArguments),
    ),
    _appRoute(
      path: AppRoutes.BOOKING_CONFIRMED,
      name: AppRoutes.BOOKING_CONFIRMED,
      builder: (context, state) => BookingConfirmedView(
        arguments: state.extra! as BookingConfirmedArguments,
      ),
    ),
    _appRoute(
      path: AppRoutes.CUSTOMER_BOOKING_DETAILS,
      name: AppRoutes.CUSTOMER_BOOKING_DETAILS,
      builder: (context, state) =>
          CustomerBookingDetailsView(booking: state.extra! as BookingModel),
    ),
    _appRoute(
      path: AppRoutes.ADD_BUSINESS,
      name: AppRoutes.ADD_BUSINESS,
      builder: (context, state) => const AddBusinessView(),
    ),
    _appRoute(
      path: AppRoutes.MY_BUSINESSES,
      name: AppRoutes.MY_BUSINESSES,
      builder: (context, state) => const MyBusinessesView(),
    ),
    _appRoute(
      path: AppRoutes.MANAGE_CATALOG,
      name: AppRoutes.MANAGE_CATALOG,
      builder: (context, state) => const ManageCatalogView(),
    ),
    _appRoute(
      path: AppRoutes.ACCOUNT_SETTINGS,
      name: AppRoutes.ACCOUNT_SETTINGS,
      builder: (context, state) => const AccountSettingsView(),
    ),
    _appRoute(
      path: AppRoutes.CHANGE_PASSWORD,
      name: AppRoutes.CHANGE_PASSWORD,
      builder: (context, state) => const ChangePasswordView(),
    ),
    _appRoute(
      path: AppRoutes.LANGUAGE_CURRENCY,
      name: AppRoutes.LANGUAGE_CURRENCY,
      builder: (context, state) => const LanguageCurrencyView(),
    ),
    _appRoute(
      path: AppRoutes.APPEARANCE,
      name: AppRoutes.APPEARANCE,
      builder: (context, state) => const AppearanceView(),
    ),
    _appRoute(
      path: AppRoutes.CUSTOMER_EDIT_PROFILE,
      name: AppRoutes.CUSTOMER_EDIT_PROFILE,
      builder: (context, state) => const CustomerEditProfileView(),
    ),
    _appRoute(
      path: AppRoutes.TERMS_OF_SERVICE,
      name: AppRoutes.TERMS_OF_SERVICE,
      builder: (context, state) => const LegalDocumentView(
        documentType: LegalDocumentType.termsOfService,
      ),
    ),
    _appRoute(
      path: AppRoutes.PRIVACY_POLICY,
      name: AppRoutes.PRIVACY_POLICY,
      builder: (context, state) => const LegalDocumentView(
        documentType: LegalDocumentType.privacyPolicy,
      ),
    ),
    _appRoute(
      path: AppRoutes.PROVIDER_TERMS_OF_SERVICE,
      name: AppRoutes.PROVIDER_TERMS_OF_SERVICE,
      builder: (context, state) => const LegalDocumentView(
        documentType: LegalDocumentType.termsOfService,
        audience: LegalDocumentAudience.provider,
      ),
    ),
    _appRoute(
      path: AppRoutes.PROVIDER_PRIVACY_POLICY,
      name: AppRoutes.PROVIDER_PRIVACY_POLICY,
      builder: (context, state) => const LegalDocumentView(
        documentType: LegalDocumentType.privacyPolicy,
        audience: LegalDocumentAudience.provider,
      ),
    ),
    _appRoute(
      path: AppRoutes.SUPPORT_TICKETS,
      name: AppRoutes.SUPPORT_TICKETS,
      builder: (context, state) => const SupportTicketsView(),
    ),
    _appRoute(
      path: AppRoutes.CREATE_SUPPORT_TICKET,
      name: AppRoutes.CREATE_SUPPORT_TICKET,
      builder: (context, state) => const CreateSupportTicketView(),
    ),
    _appRoute(
      path: AppRoutes.HELP_CENTER,
      name: AppRoutes.HELP_CENTER,
      builder: (context, state) => const HelpCenterView(),
    ),
    _appRoute(
      path: AppRoutes.HELP_ARTICLE_DETAIL,
      name: AppRoutes.HELP_ARTICLE_DETAIL,
      builder: (context, state) =>
          HelpArticleDetailView(article: state.extra! as HelpArticleModel),
    ),
    _appRoute(
      path: AppRoutes.PAYMENT_METHODS,
      name: AppRoutes.PAYMENT_METHODS,
      builder: (context, state) => const PaymentMethodsView(),
    ),
    _appRoute(
      path: AppRoutes.ADD_PAYMENT_METHOD,
      name: AppRoutes.ADD_PAYMENT_METHOD,
      builder: (context, state) => const AddPaymentMethodView(),
    ),
    _appRoute(
      path: AppRoutes.PROMOTIONS,
      name: AppRoutes.PROMOTIONS,
      builder: (context, state) => const PromotionsView(),
    ),
    _appRoute(
      path: AppRoutes.CREATE_PROMOTION,
      name: AppRoutes.CREATE_PROMOTION,
      builder: (context, state) =>
          CreatePromotionView(business: state.extra! as BusinessModel),
    ),
    _appRoute(
      path: AppRoutes.AVAILABILITY_CALENDAR,
      name: AppRoutes.AVAILABILITY_CALENDAR,
      builder: (context, state) => const AvailabilityCalendarView(),
    ),
    _appRoute(
      path: AppRoutes.CHAT_LIST,
      name: AppRoutes.CHAT_LIST,
      builder: (context, state) => const ChatListView(),
    ),
    _appRoute(
      path: AppRoutes.NOTIFICATIONS,
      name: AppRoutes.NOTIFICATIONS,
      builder: (context, state) => const NotificationsView(),
    ),
    _appRoute(
      path: AppRoutes.CHAT_CONVERSATION,
      name: AppRoutes.CHAT_CONVERSATION,
      builder: (context, state) => ChatConversationView(
        arguments: state.extra! as ChatConversationArguments,
      ),
    ),
    _appRoute(
      path: AppRoutes.SIGNUP,
      name: AppRoutes.SIGNUP,
      builder: (context, state) => const SignupView(),
    ),
  ],
);
