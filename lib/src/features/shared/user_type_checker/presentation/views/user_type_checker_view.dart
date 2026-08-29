import 'package:multibook/app.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/user_type.dart';
import 'package:multibook/src/features/shared/user_type_checker/cubit/user_type_checker_cubit.dart';
import 'package:multibook/src/features/shared/user_type_checker/cubit/user_type_checker_state.dart';
import 'package:multibook/src/features/shared/user_type_checker/presentation/widgets/user_type_option_card.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserTypeCheckerView extends StatelessWidget {
  const UserTypeCheckerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserTypeCheckerCubit>(),
      child: BlocConsumer<UserTypeCheckerCubit, UserTypeCheckerState>(
        listenWhen: (previous, current) =>
            previous.isCompleted != current.isCompleted ||
            previous.errorMessage != current.errorMessage,
        listener: (context, state) {
          if (state.isCompleted) {
            context.go(AppRoutes.HOME);
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 58, 25, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.userTypeTitle,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      context.l10n.userTypeDescription,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 42),
                    UserTypeOptionCard(
                      title: context.l10n.ownBusiness,
                      description: context.l10n.ownBusinessDescription,
                      icon: Icons.storefront,
                      isSelected: state.selectedType == UserType.provider,
                      onTap: () => context
                          .read<UserTypeCheckerCubit>()
                          .selectType(UserType.provider),
                    ),
                    const SizedBox(height: 18),
                    UserTypeOptionCard(
                      title: context.l10n.customer,
                      description: context.l10n.customerDescription,
                      icon: Icons.calendar_month,
                      isSelected: state.selectedType == UserType.customer,
                      onTap: () => context
                          .read<UserTypeCheckerCubit>()
                          .selectType(UserType.customer),
                    ),
                    const Spacer(),
                    CustomButton(
                      buttonName: context.l10n.continueLabel,
                      enabled: state.selectedType != null && !state.isLoading,
                      onPressed: () => context
                          .read<UserTypeCheckerCubit>()
                          .continueWithSelectedType(),
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
