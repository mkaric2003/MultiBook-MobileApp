import 'package:aquabook/src/data/models/appointment_model.dart';

class AppointmentDetailsArguments {
  const AppointmentDetailsArguments({required this.appointment});

  final AppointmentModel appointment;

  bool get isFinished {
    if (appointment.status == 'cancelled' ||
        appointment.status == 'declined' ||
        appointment.status == 'completed') {
      return true;
    }
    final end = DateTime(
      appointment.date.year,
      appointment.date.month,
      appointment.date.day,
    ).add(Duration(minutes: appointment.endMinutes));
    return !end.isAfter(DateTime.now());
  }

  bool get canReschedule => !isFinished && appointment.rescheduleCount == 0;
}
