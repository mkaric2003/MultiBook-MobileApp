import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/api_exception.dart';
import 'package:multibook/src/data/data_sources/api_client.dart';
import 'package:multibook/src/data/data_sources/firebase_storage_data_source.dart';
import 'package:multibook/src/data/enums/stay_extra_type.dart';
import 'package:multibook/src/data/models/appointment_draft_model.dart';
import 'package:multibook/src/data/models/booking_draft_model.dart';
import 'package:multibook/src/data/models/stay_extra_model.dart';

@lazySingleton
class CustomerDraftsApiDataSource {
  CustomerDraftsApiDataSource(this._client, this._storage);

  final ApiClient _client;
  final FirebaseStorageDataSource _storage;

  Future<BookingDraftModel?> getBookingDraft() async {
    try {
      final response = await _client.get('/v1/drafts/booking');
      return _bookingDraftFromMap(response.data!);
    } on ApiException catch (error) {
      if (error.statusCode == 404) return null;
      rethrow;
    }
  }

  Future<BookingDraftModel> saveBookingDraft(BookingDraftModel draft) async {
    final response = await _client.put(
      '/v1/drafts/booking',
      data: {
        'businessId': draft.businessId,
        'checkIn': _date(draft.checkIn),
        'checkOut': _date(draft.checkOut),
        'adults': draft.adults,
        'children': draft.children,
        'infants': draft.infants,
        'roomTypeId': draft.roomTypeId,
        'selectedExtras': draft.selectedExtras.map(_stayExtraToMap).toList(),
      },
    );
    return _bookingDraftFromMap(response.data!);
  }

  Future<void> deleteBookingDraft() async {
    await _client.delete('/v1/drafts/booking');
  }

  Future<AppointmentDraftModel?> getAppointmentDraft() async {
    try {
      final response = await _client.get('/v1/drafts/appointment');
      return _appointmentDraftFromMap(response.data!);
    } on ApiException catch (error) {
      if (error.statusCode == 404) return null;
      rethrow;
    }
  }

  Future<AppointmentDraftModel> saveAppointmentDraft(
    AppointmentDraftModel draft,
  ) async {
    final response = await _client.put(
      '/v1/drafts/appointment',
      data: {
        'businessId': draft.businessId,
        'selectedOfferingIds': draft.selectedOfferingIds,
        'selectedProviderId': draft.selectedProviderId,
        'date': _date(draft.date),
        'startMinutes': draft.startMinutes,
        'selectedAddOnIds': draft.selectedAddOnIds,
      },
    );
    return _appointmentDraftFromMap(response.data!);
  }

  Future<void> deleteAppointmentDraft() async {
    await _client.delete('/v1/drafts/appointment');
  }

  Future<BookingDraftModel> _bookingDraftFromMap(
    Map<String, dynamic> data,
  ) async {
    final imageUrl = await _resolveImageUrl(
      data['businessImageUrl'] as String?,
    );
    return BookingDraftModel(
      id: data['id'] as String? ?? '',
      businessId: data['businessId'] as String? ?? '',
      businessName: data['businessName'] as String? ?? '',
      businessLocation: data['businessLocation'] as String? ?? '',
      businessImageUrl: imageUrl,
      pricePerNight: (data['pricePerNight'] as num?)?.toInt() ?? 0,
      checkIn: _parseDate(data['checkIn'] as String?),
      checkOut: _parseDate(data['checkOut'] as String?),
      adults: (data['adults'] as num?)?.toInt() ?? 1,
      children: (data['children'] as num?)?.toInt() ?? 0,
      infants: (data['infants'] as num?)?.toInt() ?? 0,
      roomTypeId: data['roomTypeId'] as String?,
      selectedExtras: (data['selectedExtras'] as List? ?? const [])
          .whereType<Map>()
          .map((extra) {
            final values = Map<String, dynamic>.from(extra);
            return StayExtraModel(
              type: StayExtraType.values.byName(
                values['type'] as String? ?? StayExtraType.values.first.name,
              ),
              price: (values['price'] as num?)?.toInt() ?? 0,
              isPerNight: values['isPerNight'] as bool? ?? false,
              isPerHour: values['isPerHour'] as bool? ?? false,
            );
          })
          .toList(),
    );
  }

  Future<AppointmentDraftModel> _appointmentDraftFromMap(
    Map<String, dynamic> data,
  ) async {
    final imageUrl = await _resolveImageUrl(
      data['businessImageUrl'] as String?,
    );
    return AppointmentDraftModel(
      id: data['id'] as String? ?? '',
      businessId: data['businessId'] as String? ?? '',
      businessName: data['businessName'] as String? ?? '',
      businessImageUrl: imageUrl,
      selectedOfferingIds: List<String>.from(
        data['selectedOfferingIds'] as List? ?? const [],
      ),
      selectedProviderId: data['selectedProviderId'] as String?,
      selectedProviderName: data['selectedProviderName'] as String?,
      date: _parseDate(data['date'] as String?),
      startMinutes: (data['startMinutes'] as num?)?.toInt(),
      selectedAddOnIds: List<String>.from(
        data['selectedAddOnIds'] as List? ?? const [],
      ),
    );
  }

  Future<String> _resolveImageUrl(String? value) async {
    if (value == null || value.isEmpty) return '';
    return _storage.getDownloadUrl(storagePath: value);
  }

  Map<String, dynamic> _stayExtraToMap(StayExtraModel extra) => {
    'type': extra.type.name,
    'price': extra.price,
    'isPerNight': extra.isPerNight,
    'isPerHour': extra.isPerHour,
  };

  String _date(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';

  DateTime _parseDate(String? value) => value == null
      ? DateTime.now()
      : DateTime.tryParse(value) ?? DateTime.now();
}
