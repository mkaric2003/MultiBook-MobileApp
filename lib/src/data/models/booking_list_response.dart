import 'package:dart_mappable/dart_mappable.dart';
import 'package:multibook/src/data/models/booking_model.dart';

part 'booking_list_response.mapper.dart';

@MappableClass()
class BookingListResponse with BookingListResponseMappable {
  const BookingListResponse({required this.items, this.nextCursor});

  final List<BookingModel> items;
  final String? nextCursor;
}
