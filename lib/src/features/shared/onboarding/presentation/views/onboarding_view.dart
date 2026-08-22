import 'package:aquabook/app.dart';
import 'package:aquabook/l10n/l10n.dart';
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

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final pages = [
      OnboardingPageModel(
        assetPath: 'assets/images/first-intro.png',
        title: context.l10n.onboardingFirstTitle,
        description: context.l10n.onboardingFirstDescription,
        isSvg: false,
      ),
      OnboardingPageModel(
        assetPath: 'assets/images/second-intro.png',
        title: context.l10n.onboardingSecondTitle,
        description: context.l10n.onboardingSecondDescription,
        isSvg: false,
      ),
      OnboardingPageModel(
        assetPath: 'assets/images/third-intro-image.svg',
        title: context.l10n.onboardingThirdTitle,
        description: context.l10n.onboardingThirdDescription,
        isSvg: true,
      ),
    ];

    return BlocProvider(
      create: (_) => getIt<OnboardingCubit>(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listenWhen: (previous, current) =>
            !previous.isCompleted && current.isCompleted,
        listener: (context, state) => context.go(AppRoutes.SIGNIN),
        builder: (context, state) {
          final isLastPage = state.currentPage == pages.length - 1;

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: pages.length,
                      onPageChanged: context.read<OnboardingCubit>().changePage,
                      itemBuilder: (_, index) =>
                          OnboardingPageContent(page: pages[index]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 8, 28, 28),
                    child: Column(
                      children: [
                        if (isLastPage)
                          CustomButton(
                            buttonName: context.l10n.getStarted,
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
                                  pageCount: pages.length,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  context.read<OnboardingCubit>().complete(),
                              child: Text(context.l10n.skip),
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
