import 'package:aquabook/app.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/appointment_confirmed/domain/models/appointment_confirmed_arguments.dart';
import 'package:aquabook/src/features/customer-side/appointment_confirmed/presentation/widgets/appointment_confirmation_code_card.dart';
import 'package:aquabook/src/features/customer-side/appointment_confirmed/presentation/widgets/appointment_confirmation_header.dart';
import 'package:aquabook/src/features/customer-side/appointment_confirmed/presentation/widgets/appointment_confirmation_summary_card.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppointmentConfirmedView extends StatelessWidget {
  const AppointmentConfirmedView({required this.arguments, super.key});

  final AppointmentConfirmedArguments arguments;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 30, 22, 22),
        child: Column(
          children: [
            const AppointmentConfirmationHeader(),
            const SizedBox(height: 28),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppointmentConfirmationSummaryCard(arguments: arguments),
                    const SizedBox(height: 18),
                    AppointmentConfirmationCodeCard(arguments: arguments),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            CustomButton(
              buttonName: context.l10n.backToHome,
              color: AppColors.surfaceHighlight,
              onPressed: () => context.go(AppRoutes.CUSTOMER_HOME),
            ),
          ],
        ),
      ),
    ),
  );
}
