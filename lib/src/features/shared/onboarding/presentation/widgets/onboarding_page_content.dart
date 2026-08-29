import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/shared/onboarding/domain/models/onboarding_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPageContent extends StatelessWidget {
  const OnboardingPageContent({super.key, required this.page});

  final OnboardingPageModel page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          const Spacer(flex: 2),
          SizedBox(
            height: 290,
            child: page.isSvg
                ? SvgPicture.asset(page.assetPath, fit: BoxFit.contain)
                : Image.asset(page.assetPath, fit: BoxFit.contain),
          ),
          const Spacer(),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 22),
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 17,
              height: 1.6,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
