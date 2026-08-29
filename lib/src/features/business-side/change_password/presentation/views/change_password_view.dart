import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/features/business-side/change_password/cubit/change_password_cubit.dart';
import 'package:multibook/src/features/business-side/change_password/cubit/change_password_state.dart';
import 'package:multibook/src/features/business-side/change_password/presentation/widgets/change_password_form.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<ChangePasswordCubit>(),
    child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state.isSuccess) {
          toastification.show(
            context: context,
            type: ToastificationType.success,
            alignment: Alignment.bottomCenter,
            title: Text(context.l10n.passwordChangedSuccessfully),
          );
          context.pop();
        }
        final error = state.errorMessage;
        if (error != null) {
          toastification.show(
            context: context,
            type: ToastificationType.error,
            alignment: Alignment.bottomCenter,
            title: Text(error),
          );
        }
      },
      builder: (context, state) => Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              CustomAppBar(title: context.l10n.changePassword),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 26, 24, 40),
                  child: ChangePasswordForm(
                    isSubmitting: state.isSubmitting,
                    onSubmit:
                        ({required currentPassword, required newPassword}) =>
                            context.read<ChangePasswordCubit>().submit(
                              currentPassword: currentPassword,
                              newPassword: newPassword,
                            ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
