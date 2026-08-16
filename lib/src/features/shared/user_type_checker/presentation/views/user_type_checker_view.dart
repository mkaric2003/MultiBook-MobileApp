import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/user_type.dart';
import 'package:aquabook/src/features/shared/user_type_checker/cubit/user_type_checker_cubit.dart';
import 'package:aquabook/src/features/shared/user_type_checker/cubit/user_type_checker_state.dart';
import 'package:aquabook/src/features/shared/user_type_checker/presentation/widgets/user_type_option_card.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
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
                    const Text(
                      'How will you use MultiBook?',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Choose the experience that fits you best. You can change this later.',
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 42),
                    UserTypeOptionCard(
                      title: 'I own a business',
                      description:
                          'Manage stays or services, bookings and earnings.',
                      icon: Icons.storefront,
                      isSelected: state.selectedType == UserType.provider,
                      onTap: () => context
                          .read<UserTypeCheckerCubit>()
                          .selectType(UserType.provider),
                    ),
                    const SizedBox(height: 18),
                    UserTypeOptionCard(
                      title: 'I am a customer',
                      description:
                          'Book stays and schedule services in one place.',
                      icon: Icons.calendar_month,
                      isSelected: state.selectedType == UserType.customer,
                      onTap: () => context
                          .read<UserTypeCheckerCubit>()
                          .selectType(UserType.customer),
                    ),
                    const Spacer(),
                    CustomButton(
                      buttonName: 'Continue',
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
