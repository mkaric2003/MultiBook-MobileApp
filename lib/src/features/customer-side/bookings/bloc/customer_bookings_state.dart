import 'package:aquabook/src/data/enums/booking_status.dart';
import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/data/models/appointment_model.dart';
import 'package:aquabook/src/features/customer-side/bookings/domain/enums/customer_booking_type.dart';
import 'package:flutter/material.dart';

class CustomerBookingsState {
  const CustomerBookingsState({
    this.selectedType = CustomerBookingType.stays,
    this.bookings = const [],
    this.appointments = const [],
    this.isLoading = true,
    this.isLoadingMore = false,
    this.hasReachedEnd = false,
    this.errorMessage,
  });

  final List<BookingModel> bookings;
  final List<AppointmentModel> appointments;
  final CustomerBookingType selectedType;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedEnd;
  final String? errorMessage;

  List<BookingModel> get upcomingBookings {
    final today = DateTime.now();
    return bookings
        .where(
          (booking) =>
              !booking.checkOut.isBefore(
                DateTime(today.year, today.month, today.day),
              ) &&
              booking.status != BookingStatus.cancelled &&
              booking.status != BookingStatus.declined &&
              booking.status != BookingStatus.completed,
        )
        .toList()
      ..sort((first, second) => first.checkIn.compareTo(second.checkIn));
  }

  List<BookingModel> get pastBookings {
    final upcomingIds = upcomingBookings.map((booking) => booking.id).toSet();
    return bookings
        .where((booking) => !upcomingIds.contains(booking.id))
        .toList()
      ..sort((first, second) => second.checkIn.compareTo(first.checkIn));
  }

  List<AppointmentModel> get upcomingAppointments {
    final today = DateUtils.dateOnly(DateTime.now());
    return appointments
        .where(
          (appointment) =>
              !appointment.date.isBefore(today) &&
              appointment.status != 'cancelled' &&
              appointment.status != 'completed',
        )
        .toList()
      ..sort((first, second) => first.date.compareTo(second.date));
  }

  List<AppointmentModel> get pastAppointments {
    final upcomingIds = upcomingAppointments
        .map((appointment) => appointment.id)
        .toSet();
    return appointments
        .where((appointment) => !upcomingIds.contains(appointment.id))
        .toList()
      ..sort((first, second) => second.date.compareTo(first.date));
  }
}
