import 'package:multibook/app.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/features/customer-side/support_tickets/cubit/support_tickets_cubit.dart';
import 'package:multibook/src/features/customer-side/support_tickets/cubit/support_tickets_state.dart';
import 'package:multibook/src/features/customer-side/support_tickets/presentation/widgets/support_tickets_content.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SupportTicketsView extends StatelessWidget {
  const SupportTicketsView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<SupportTicketsCubit>()..load(),
    child: BlocBuilder<SupportTicketsCubit, SupportTicketsState>(
      builder: (context, state) => Scaffold(
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: CustomButton(
              buttonName: context.l10n.newSupportRequest,
              leadingIcon: const Icon(Icons.add),
              onPressed: () async {
                final created = await context.push<bool>(
                  AppRoutes.CREATE_SUPPORT_TICKET,
                );
                if (created == true && context.mounted) {
                  await context.read<SupportTicketsCubit>().load();
                }
              },
            ),
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              CustomAppBar(title: context.l10n.supportRequests),
              Expanded(child: SupportTicketsContent(state: state)),
            ],
          ),
        ),
      ),
    ),
  );
}
