import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/customer-side/bookings/bloc/customer_bookings_state.dart';
import 'package:multibook/src/features/customer-side/bookings/bloc/customer_bookings_cubit.dart';
import 'package:multibook/src/features/customer-side/bookings/presentation/widgets/customer_bookings_section.dart';
import 'package:multibook/src/features/customer-side/bookings/presentation/widgets/customer_bookings_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerBookingsList extends StatelessWidget {
  const CustomerBookingsList({
    super.key,
    required this.state,
    required this.controller,
  });

  final CustomerBookingsState state;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const CustomerBookingsSkeleton.stays();
    }
    if (state.bookings.isEmpty) {
      return Center(
        child: Text(
          state.errorMessage ?? context.l10n.noBookingsYet,
          style: TextStyle(color: context.appPalette.muted, fontSize: 16),
        ),
      );
    }
    return ListView(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 78),
      children: [
        CustomerBookingsSection(
          title: context.l10n.upcoming,
          bookings: state.upcomingBookings,
          onBookingUpdated: context.read<CustomerBookingsCubit>().updateBooking,
        ),
        if (state.upcomingBookings.isNotEmpty && state.pastBookings.isNotEmpty)
          const SizedBox(height: 18),
        CustomerBookingsSection(
          title: context.l10n.past,
          bookings: state.pastBookings,
          onBookingUpdated: context.read<CustomerBookingsCubit>().updateBooking,
        ),
        if (state.isLoadingMore)
          const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
