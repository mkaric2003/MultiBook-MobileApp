part of '../../../app.dart';

final router = GoRouter(
  initialLocation: getIt<OnboardingRepository>().hasSeenOnboarding
      ? AppRoutes.SIGNIN
      : AppRoutes.ONBOARDING,
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

    if (isSignedIn && isAuthenticationRoute) return AppRoutes.HOME;
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
      path: AppRoutes.ACCOUNT_SETTINGS,
      name: AppRoutes.ACCOUNT_SETTINGS,
      builder: (context, state) => const AccountSettingsView(),
    ),
    GoRoute(
      path: AppRoutes.CUSTOMER_EDIT_PROFILE,
      name: AppRoutes.CUSTOMER_EDIT_PROFILE,
      builder: (context, state) => const CustomerEditProfileView(),
    ),
    GoRoute(
      path: AppRoutes.AVAILABILITY_CALENDAR,
      name: AppRoutes.AVAILABILITY_CALENDAR,
      builder: (context, state) => const AvailabilityCalendarView(),
    ),
    GoRoute(
      path: AppRoutes.SIGNUP,
      name: AppRoutes.SIGNUP,
      builder: (context, state) => const SignupView(),
    ),
  ],
);
