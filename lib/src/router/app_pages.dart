part of '../../../app.dart';

final router = GoRouter(
  initialLocation: AppRoutes.SIGNUP,
  routes: [
    GoRoute(
      path: AppRoutes.SIGNUP,
      name: AppRoutes.SIGNUP,
      builder: (context, state) => SignupView(),
    ),
  ],
);
