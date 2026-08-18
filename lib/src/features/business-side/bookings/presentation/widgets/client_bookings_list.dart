import 'package:aquabook/src/features/business-side/bookings/bloc/client_bookings_state.dart';
import 'package:aquabook/src/features/business-side/bookings/bloc/client_bookings_cubit.dart';
import 'package:aquabook/src/features/business-side/bookings/presentation/widgets/client_booking_card.dart';
import 'package:aquabook/src/features/business-side/bookings/presentation/widgets/manage_booking_sheet.dart';
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

    if (state.errorMessage != null && state.bookings.isEmpty) {
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

    if (state.bookings.isEmpty) {
      return const Center(
        child: Text(
          'No bookings found.',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    return ListView.separated(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
      itemCount: state.bookings.length + (state.isLoadingMore ? 1 : 0),
      separatorBuilder: (_, _) => const SizedBox(height: 18),
      itemBuilder: (context, index) {
        if (index == state.bookings.length) {
          return const Center(child: CircularProgressIndicator());
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
              onCancel: context.read<ClientBookingsCubit>().cancelBooking,
            ),
          ),
        );
      },
    );
  }
}
