import 'package:aquabook/app.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/appointment_model.dart';
import 'package:aquabook/src/features/customer-side/appointment_details/cubit/appointment_details_cubit.dart';
import 'package:aquabook/src/features/customer-side/appointment_details/cubit/appointment_details_state.dart';
import 'package:aquabook/src/features/customer-side/appointment_details/domain/models/appointment_details_arguments.dart';
import 'package:aquabook/src/features/customer-side/appointment_details/presentation/widgets/appointment_details_actions.dart';
import 'package:aquabook/src/features/customer-side/appointment_details/presentation/widgets/appointment_details_business_card.dart';
import 'package:aquabook/src/features/customer-side/appointment_details/presentation/widgets/appointment_details_information_card.dart';
import 'package:aquabook/src/features/customer-side/appointment_details/presentation/widgets/appointment_details_price_card.dart';
import 'package:aquabook/src/features/customer-side/reschedule_appointment/domain/models/reschedule_appointment_arguments.dart';
import 'package:aquabook/src/features/shared/chat/domain/models/chat_conversation_arguments.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class AppointmentDetailsView extends StatelessWidget {
  const AppointmentDetailsView({required this.arguments, super.key});

  final AppointmentDetailsArguments arguments;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) =>
        getIt<AppointmentDetailsCubit>()
          ..load(arguments.appointment.businessId),
    child: BlocConsumer<AppointmentDetailsCubit, AppointmentDetailsState>(
      listener: (context, state) {
        if (state.appointment != null) context.pop(state.appointment);
        if (state.errorMessage != null) {
          toastification.show(
            context: context,
            alignment: Alignment.bottomCenter,
            autoCloseDuration: const Duration(seconds: 3),
            type: ToastificationType.error,
            title: Text(state.errorMessage!),
          );
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(title: context.l10n.appointmentDetails),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                  child: Column(
                    children: [
                      AppointmentDetailsBusinessCard(
                        arguments: arguments,
                        business: state.business,
                      ),
                      const SizedBox(height: 18),
                      AppointmentDetailsInformationCard(arguments: arguments),
                      const SizedBox(height: 18),
                      AppointmentDetailsPriceCard(arguments: arguments),
                      if (!arguments.isFinished) ...[
                        const SizedBox(height: 24),
                        AppointmentDetailsActions(
                          isCancelling: state.isCancelling,
                          canReschedule:
                              arguments.canReschedule && state.business != null,
                          onCancel: () async {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (dialogContext) => AlertDialog(
                                title: Text(context.l10n.cancelAppointmentQuestion),
                                content: Text(context.l10n.cannotBeUndone),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext, false),
                                    child: Text(context.l10n.keepAppointment),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext, true),
                                    child: Text(context.l10n.cancelAppointment),
                                  ),
                                ],
                              ),
                            );
                            if (confirmed == true && context.mounted) {
                              await context
                                  .read<AppointmentDetailsCubit>()
                                  .cancel(arguments.appointment);
                            }
                          },
                          onReschedule: () async {
                            final business = state.business;
                            if (business == null) return;
                            final updated = await context
                                .push<AppointmentModel>(
                                  AppRoutes.RESCHEDULE_APPOINTMENT,
                                  extra: RescheduleAppointmentArguments(
                                    appointment: arguments.appointment,
                                    business: business,
                                  ),
                                );
                            if (updated != null && context.mounted) {
                              context.pop(updated);
                            }
                          },
                          onMessageProvider: () {
                            final business = state.business;
                            if (business == null) return;
                            context.push(
                              AppRoutes.CHAT_CONVERSATION,
                              extra: ChatConversationArguments.fromBusiness(
                                business,
                              ),
                            );
                          },
                        ),
                      ],
                    ],
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
