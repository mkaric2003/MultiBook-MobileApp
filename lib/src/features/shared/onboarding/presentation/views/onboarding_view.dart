import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/features/shared/onboarding/cubit/onboarding_cubit.dart';
import 'package:aquabook/src/features/shared/onboarding/cubit/onboarding_state.dart';
import 'package:aquabook/src/features/shared/onboarding/domain/models/onboarding_page_model.dart';
import 'package:aquabook/src/features/shared/onboarding/presentation/widgets/onboarding_page_content.dart';
import 'package:aquabook/src/features/shared/onboarding/presentation/widgets/onboarding_page_indicator.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class OnboardingView extends HookWidget {
  const OnboardingView({super.key});

  static const _pages = [
    OnboardingPageModel(
      assetPath: 'assets/images/first-intro.png',
      title: 'Manage your stays &\nservices in one place',
      description:
          'Easily control your hotels, apartments, and service businesses from one app.',
      isSvg: false,
    ),
    OnboardingPageModel(
      assetPath: 'assets/images/second-intro.png',
      title: 'Track bookings &\nearnings easily',
      description:
          'Stay on top of your reservations and monitor your income in real time.',
      isSvg: false,
    ),
    OnboardingPageModel(
      assetPath: 'assets/images/third-intro-image.svg',
      title: 'Connect with your\ncustomers directly',
      description:
          'Receive instant notifications, manage bookings, and chat with your clients in one place.',
      isSvg: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();

    return BlocProvider(
      create: (_) => getIt<OnboardingCubit>(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listenWhen: (previous, current) =>
            !previous.isCompleted && current.isCompleted,
        listener: (context, state) => context.go(AppRoutes.SIGNIN),
        builder: (context, state) {
          final isLastPage = state.currentPage == _pages.length - 1;

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: _pages.length,
                      onPageChanged: context.read<OnboardingCubit>().changePage,
                      itemBuilder: (_, index) =>
                          OnboardingPageContent(page: _pages[index]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 8, 28, 28),
                    child: Column(
                      children: [
                        if (isLastPage)
                          CustomButton(
                            buttonName: 'Get started',
                            onPressed: () =>
                                context.read<OnboardingCubit>().complete(),
                          ),
                        if (isLastPage) const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: OnboardingPageIndicator(
                                  currentPage: state.currentPage,
                                  pageCount: _pages.length,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  context.read<OnboardingCubit>().complete(),
                              child: const Text('Skip'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
