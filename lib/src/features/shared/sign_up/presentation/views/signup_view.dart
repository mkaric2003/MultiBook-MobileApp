// signup_view.dart

import 'package:aquabook/app.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/shared/sign_up/cubit/signup_cubit.dart';
import 'package:aquabook/src/features/shared/sign_up/cubit/signup_state.dart';
import 'package:aquabook/src/features/shared/sign_up/presentation/widgets/agree_terms_tile.dart';
import 'package:aquabook/src/features/shared/sign_up/presentation/widgets/marketing_tile.dart';
import 'package:aquabook/src/features/shared/sign_up/presentation/widgets/sign_up_form.dart';
import 'package:aquabook/src/features/shared/sign_up/presentation/widgets/social_sign_in_button.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:aquabook/src/global_widgets/labeled_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupView extends HookWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final formValid = useState(false);
    final agreed = useState(false);
    final signupData = useState<SignupFormData?>(null);

    return BlocProvider(
      create: (_) => getIt<SignupCubit>(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.isSuccess) {
            context.go(
              state.requiresUserTypeSelection
                  ? AppRoutes.USER_TYPE_CHECKER
                  : AppRoutes.HOME,
            );
          }

          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          final canCreate = formValid.value && agreed.value && !state.isLoading;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(
                top: 55,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      context.l10n.signUpTitle,
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      context.l10n.signUpDescription,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: AppColors.muted,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SignUpForm(
                      onValidityChanged: (v) => formValid.value = v,
                      onChanged: (data) => signupData.value = data,
                    ),
                    AgreeTermsTile(
                      value: agreed.value,
                      onChanged: (v) => agreed.value = v,
                      onTapTerms: () {},
                      onTapPrivacy: () {},
                    ),
                    const SizedBox(height: 7),
                    MarketingTile(value: true, onChanged: (v) {}),
                    const SizedBox(height: 15),
                    CustomButton(
                      buttonName: context.l10n.createAccount,
                      onPressed: canCreate
                          ? () => context.read<SignupCubit>().signUp(
                              firstName: signupData.value!.firstName,
                              lastName: signupData.value!.lastName,
                              email: signupData.value!.email,
                              password: signupData.value!.password,
                            )
                          : null,
                      enabled: canCreate,
                    ),
                    const SizedBox(height: 25),
                    const LabeledDivider(),
                    const SizedBox(height: 25),
                    SocialSigninButton(
                      label: context.l10n.continueWithApple,
                      icon: SvgPicture.asset(
                        'assets/icons/apple.svg',
                        width: 22,
                        height: 22,
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),
                    SocialSigninButton(
                      label: context.l10n.continueWithGoogle,
                      icon: SvgPicture.asset(
                        'assets/icons/google.svg',
                        width: 22,
                        height: 22,
                      ),
                      onPressed: () =>
                          context.read<SignupCubit>().signInWithGoogle(),
                      enabled: !state.isLoading,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.l10n.alreadyHaveAccount,
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () => context.go(AppRoutes.SIGNIN),
                          child: Text(
                            context.l10n.signIn,
                            style: TextStyle(
                              color: Color(0xFF7C3AED),
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
