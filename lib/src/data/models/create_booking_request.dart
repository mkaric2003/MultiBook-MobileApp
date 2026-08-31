import 'package:dart_mappable/dart_mappable.dart';
import 'package:multibook/src/data/models/booking_extra_request.dart';

part 'create_booking_request.mapper.dart';

@MappableClass()
class CreateBookingRequest with CreateBookingRequestMappable {
  const CreateBookingRequest({
    this.stayUnitTypeId,
    required this.checkIn,
    required this.checkOut,
    required this.adults,
    required this.children,
    required this.infants,
    required this.selectedExtras,
    required this.customerName,
    required this.customerEmail,
    required this.paymentMethod,
  });

  final String? stayUnitTypeId;
  final String checkIn;
  final String checkOut;
  final int adults;
  final int children;
  final int infants;
  final List<BookingExtraRequest> selectedExtras;
  final String customerName;
  final String customerEmail;
  final String paymentMethod;
}
