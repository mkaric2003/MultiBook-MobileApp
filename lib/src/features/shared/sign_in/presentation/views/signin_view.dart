import 'package:aquabook/app.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/shared/sign_in/cubit/signin_cubit.dart';
import 'package:aquabook/src/features/shared/sign_in/cubit/signin_state.dart';
import 'package:aquabook/src/features/shared/sign_in/presentation/widgets/signin_form.dart';
import 'package:aquabook/src/features/shared/sign_up/presentation/widgets/social_sign_in_button.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:aquabook/src/global_widgets/labeled_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninView extends HookWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    final formValid = useState(false);
    final signinData = useState<SigninFormData?>(null);

    return BlocProvider(
      create: (_) => getIt<SigninCubit>(),
      child: BlocConsumer<SigninCubit, SigninState>(
        listener: (context, state) {
          if (state.isSuccess) {
            context.go(
              state.requiresUserTypeSelection
                  ? AppRoutes.USER_TYPE_CHECKER
                  : AppRoutes.HOME,
            );
          }

          final message = state.errorMessage ?? state.successMessage;
          if (message != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          }
        },
        builder: (context, state) {
          final canSignIn = formValid.value && !state.isLoading;

          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(27, 75, 27, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.signInTitle,
                      style: GoogleFonts.inter(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      context.l10n.signInDescription,
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        height: 1.5,
                        color: AppColors.muted,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SigninForm(
                      onValidityChanged: (value) => formValid.value = value,
                      onChanged: (data) => signinData.value = data,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF7C3AED),
                        ),
                        onPressed: state.isLoading
                            ? null
                            : () => context
                                  .read<SigninCubit>()
                                  .sendPasswordResetEmail(
                                    signinData.value?.email ?? '',
                                  ),
                        child: Text(context.l10n.forgotPassword),
                      ),
                    ),
                    const SizedBox(height: 18),
                    CustomButton(
                      buttonName: context.l10n.signIn,
                      onPressed: canSignIn
                          ? () => context.read<SigninCubit>().signIn(
                              email: signinData.value!.email,
                              password: signinData.value!.password,
                            )
                          : null,
                      enabled: canSignIn,
                    ),
                    const SizedBox(height: 44),
                    const LabeledDivider(padding: EdgeInsets.zero),
                    const SizedBox(height: 38),
                    SocialSigninButton(
                      label: context.l10n.continueWithApple,
                      icon: SvgPicture.asset(
                        'assets/icons/apple.svg',
                        width: 22,
                        height: 22,
                      ),
                      onPressed: () =>
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(context.l10n.appleSignInSoon),
                            ),
                          ),
                      enabled: !state.isLoading,
                    ),
                    const SizedBox(height: 18),
                    SocialSigninButton(
                      label: context.l10n.continueWithGoogle,
                      icon: SvgPicture.asset(
                        'assets/icons/google.svg',
                        width: 22,
                        height: 22,
                      ),
                      onPressed: () =>
                          context.read<SigninCubit>().signInWithGoogle(),
                      enabled: !state.isLoading,
                    ),
                    const SizedBox(height: 38),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.l10n.dontHaveAccount,
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () => context.go(AppRoutes.SIGNUP),
                          child: Text(
                            context.l10n.createOne,
                            style: TextStyle(
                              color: Color(0xFF7C3AED),
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
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
