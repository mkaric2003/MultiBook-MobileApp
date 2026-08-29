import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/features/customer-side/support_tickets/cubit/create_support_ticket_cubit.dart';
import 'package:multibook/src/features/customer-side/support_tickets/cubit/create_support_ticket_state.dart';
import 'package:multibook/src/features/customer-side/support_tickets/presentation/widgets/support_ticket_form.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class CreateSupportTicketView extends StatelessWidget {
  const CreateSupportTicketView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<CreateSupportTicketCubit>(),
    child: BlocConsumer<CreateSupportTicketCubit, CreateSupportTicketState>(
      listener: (context, state) {
        if (state.isSuccess) {
          toastification.show(
            context: context,
            type: ToastificationType.success,
            alignment: Alignment.bottomCenter,
            title: Text(context.l10n.supportRequestSent),
          );
          context.pop();
        }
        if (state.hasError) {
          toastification.show(
            context: context,
            type: ToastificationType.error,
            alignment: Alignment.bottomCenter,
            title: Text(context.l10n.supportRequestFailed),
          );
        }
      },
      builder: (context, state) => Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              CustomAppBar(title: context.l10n.newSupportRequest),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                  child: SupportTicketForm(
                    isSubmitting: state.isSubmitting,
                    onSubmit: (category, subject, message) =>
                        context.read<CreateSupportTicketCubit>().submit(
                          category: category,
                          subject: subject,
                          message: message,
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
