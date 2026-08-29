import 'package:multibook/src/features/business-side/bookings/bloc/client_bookings_state.dart';
import 'package:multibook/src/features/business-side/bookings/bloc/client_bookings_cubit.dart';
import 'package:multibook/src/features/business-side/bookings/presentation/widgets/client_booking_card.dart';
import 'package:multibook/src/features/business-side/bookings/presentation/widgets/manage_booking_sheet.dart';
import 'package:multibook/src/features/business-side/bookings/presentation/widgets/client_appointment_card.dart';
import 'package:multibook/src/features/business-side/bookings/presentation/widgets/manage_appointment_sheet.dart';
import 'package:multibook/app.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/features/customer-side/reschedule_appointment/domain/models/reschedule_appointment_arguments.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientBookingsList extends StatelessWidget {
  const ClientBookingsList({
    super.key,
    required this.state,
    required this.controller,
  });

  final ClientBookingsState state;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final isServices = state.tab.name == 'services';
    final itemCount = isServices
        ? state.appointments.length
        : state.bookings.length;
    if (state.errorMessage != null && itemCount == 0) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            state.errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    if (itemCount == 0) {
      return const Center(
        child: Text(
          'No bookings found for this business.',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    return ListView.separated(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      itemCount: itemCount + (state.isLoadingMore ? 1 : 0),
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == itemCount) {
          return const Center(child: CircularProgressIndicator());
        }

        if (isServices) {
          final appointment = state.appointments[index];
          return ClientAppointmentCard(
            appointment: appointment,
            onManage: () => showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (sheetContext) => ManageAppointmentSheet(
                appointment: appointment,
                onDecline: context
                    .read<ClientBookingsCubit>()
                    .declineAppointment,
                onComplete: context
                    .read<ClientBookingsCubit>()
                    .completeAppointment,
                onNoShow: context
                    .read<ClientBookingsCubit>()
                    .markAppointmentNoShow,
                onReschedule: () async {
                  final business = state.selectedBusiness;
                  if (business == null) return;
                  final updated = await context.push<AppointmentModel>(
                    AppRoutes.RESCHEDULE_APPOINTMENT,
                    extra: RescheduleAppointmentArguments(
                      appointment: appointment,
                      business: business,
                    ),
                  );
                  if (updated != null && context.mounted) {
                    context.read<ClientBookingsCubit>().updateAppointment(
                      updated,
                    );
                    if (sheetContext.mounted) Navigator.pop(sheetContext);
                  }
                },
              ),
            ),
          );
        }
        final booking = state.bookings[index];
        return ClientBookingCard(
          booking: booking,
          onManage: () => showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => ManageBookingSheet(
              booking: booking,
              onDecline: context.read<ClientBookingsCubit>().declineBooking,
              onComplete: context.read<ClientBookingsCubit>().completeBooking,
              onNoShow: context.read<ClientBookingsCubit>().markBookingNoShow,
            ),
          ),
        );
      },
    );
  }
}
