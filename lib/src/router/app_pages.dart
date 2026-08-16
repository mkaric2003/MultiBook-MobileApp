part of '../../../app.dart';

final router = GoRouter(
  initialLocation: AppRoutes.SIGNIN,
  redirect: (context, state) {
    final isSignedIn = getIt<AuthenticationRepository>().isSignedIn;
    final isAuthenticationRoute =
        state.matchedLocation == AppRoutes.SIGNIN ||
        state.matchedLocation == AppRoutes.SIGNUP;

    if (isSignedIn && isAuthenticationRoute) return AppRoutes.HOME;
    if (!isSignedIn && !isAuthenticationRoute) return AppRoutes.SIGNIN;

    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.SIGNIN,
      name: AppRoutes.SIGNIN,
      builder: (context, state) => const SigninView(),
    ),
    GoRoute(
      path: AppRoutes.HOME,
      name: AppRoutes.HOME,
      builder: (context, state) => const ClientEntryView(),
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
