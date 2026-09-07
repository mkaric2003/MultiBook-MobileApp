import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/networking/api_client.dart';
import 'package:multibook/src/data/models/booking_list_response.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/data/models/stay_availability_response.dart';

@lazySingleton
class CustomerBookingsApiDataSource {
  CustomerBookingsApiDataSource(this._client);

  final ApiClient _client;

  Future<BookingListResponse> getBookings({
    String? businessId,
    String? cursor,
    int pageSize = 20,
  }) async {
    final response = await _client.get(
      '/v1/bookings',
      queryParameters: {
        if (businessId != null) 'business_id': businessId,
        if (cursor != null) 'cursor': cursor,
        'page_size': pageSize,
      },
    );
    return BookingListResponseMapper.fromMap(response.data!);
  }

  Future<BookingModel> cancelBooking(String bookingId) async {
    final response = await _client.patch(
      '/v1/bookings/$bookingId/cancel',
      data: const {},
    );
    return BookingModel.fromMap(response.data!);
  }

  Future<StayAvailabilityResponse> getAvailability({
    required String businessId,
    String? roomTypeId,
  }) async {
    final response = await _client.get(
      '/v1/businesses/$businessId/stay/availability',
      queryParameters: {if (roomTypeId != null) 'room_type_id': roomTypeId},
    );
    return StayAvailabilityResponseMapper.fromMap(response.data!);
  }
}
