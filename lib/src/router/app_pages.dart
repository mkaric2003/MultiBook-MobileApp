part of '../../../app.dart';

final router = GoRouter(
  initialLocation: AppRoutes.INTRODUCTION,
  routes: [
    GoRoute(
      path: AppRoutes.INTRODUCTION,
      name: AppRoutes.INTRODUCTION,
      builder: (context, state) => IntroductionView(),
    ),
  ],
);
