import 'package:dart_mappable/dart_mappable.dart';
import 'package:multibook/src/data/models/appointment_model.dart';

part 'appointment_list_response.mapper.dart';

@MappableClass()
class AppointmentListResponse with AppointmentListResponseMappable {
  const AppointmentListResponse({required this.items, this.nextCursor});

  final List<AppointmentModel> items;
  final String? nextCursor;
}
