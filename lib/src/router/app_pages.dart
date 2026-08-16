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
      builder: (context, state) => const CustomerSearchView(),
    ),
    GoRoute(
      path: AppRoutes.STAY_DETAIL,
      name: AppRoutes.STAY_DETAIL,
      builder: (context, state) =>
          StayDetailView(stay: state.extra! as StayListing),
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
      path: AppRoutes.SIGNUP,
      name: AppRoutes.SIGNUP,
      builder: (context, state) => const SignupView(),
    ),
  ],
);
