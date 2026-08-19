import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/bookings/bloc/customer_bookings_state.dart';
import 'package:aquabook/src/features/customer-side/bookings/bloc/customer_bookings_cubit.dart';
import 'package:aquabook/src/features/customer-side/bookings/presentation/widgets/customer_appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerAppointmentsList extends StatelessWidget {
  const CustomerAppointmentsList({
    required this.state,
    required this.controller,
    super.key,
  });

  final CustomerBookingsState state;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.appointments.isEmpty) {
      return Center(
        child: Text(
          state.errorMessage ?? 'No service bookings yet.',
          style: const TextStyle(color: AppColors.muted, fontSize: 16),
        ),
      );
    }
    return ListView(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
      children: [
        if (state.upcomingAppointments.isNotEmpty) ...[
          const Text(
            'Upcoming',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 18),
          ...state.upcomingAppointments.map(
            (appointment) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CustomerAppointmentCard(
                appointment: appointment,
                onUpdated: context
                    .read<CustomerBookingsCubit>()
                    .updateAppointment,
              ),
            ),
          ),
        ],
        if (state.pastAppointments.isNotEmpty) ...[
          const SizedBox(height: 22),
          const Text(
            'Past',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 18),
          ...state.pastAppointments.map(
            (appointment) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CustomerAppointmentCard(
                appointment: appointment,
                onUpdated: context
                    .read<CustomerBookingsCubit>()
                    .updateAppointment,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
