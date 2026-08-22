import 'dart:developer';
import 'dart:math' show Random;

import 'package:aquabook/src/data/data_cursor.dart';
import 'package:aquabook/src/data/data_sources/authentication_data_source.dart';
import 'package:aquabook/src/data/data_sources/firestore_data_source.dart';
import 'package:aquabook/src/data/enums/booking_status.dart';
import 'package:aquabook/src/data/enums/payment_status.dart';
import 'package:aquabook/src/data/enums/stay_extra_type.dart';
import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/data/models/stay_extra_model.dart';
import 'package:aquabook/src/data/models/stay_room_model.dart';
import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/features/customer-side/payment/domain/models/payment_arguments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

class BookingException implements Exception {
  const BookingException(this.message);
  final String message;
}

@lazySingleton
class BookingRepository {
  BookingRepository(this._auth, this._firestore, this._businessRepository);
  final AuthenticationDataSource _auth;
  final FirestoreDataSource _firestore;
  final BusinessRepository _businessRepository;
  static const _collection = 'bookings';
  Future<BookingModel> createBooking(PaymentArguments arguments) async {
    final customerId = _auth.currentUser?.uid;
    if (customerId == null) {
      throw const BookingException(
        'You need to sign in before completing a booking.',
      );
    }
    final business = await _businessRepository.getBusiness(
      businessId: arguments.review.booking.stay.id,
    );
    if (business == null) {
      throw const BookingException('This stay is no longer available.');
    }
    final stayRooms = business.stayDetails?.rooms ?? const [];
    final selectedRoom = arguments.review.booking.room;
    final defaultRoom = _defaultRoom(
      rooms: stayRooms,
      pricePerNight: business.stayDetails?.pricePerNight,
    );
    final room = selectedRoom ?? defaultRoom;
    final booking = arguments.review.bookingState;
    final price =
        selectedRoom?.pricePerNight ??
        arguments.review.booking.pricePerNight ??
        business.stayDetails?.pricePerNight ??
        room?.pricePerNight ??
        0;
    final roomSubtotal = price * booking.nightCount;
    final extras = _extrasTotal(arguments.selectedExtras, booking.nightCount);
    final cleaning = 2500;
    final service = ((roomSubtotal + extras) * .05).round();
    final taxes = ((roomSubtotal + extras + cleaning + service) * .08).round();
    final id = _firestore.createDocumentId(collection: _collection);
    final result = BookingModel(
      id: id,
      businessId: business.id,
      businessOwnerId: business.ownerId,
      customerId: customerId,
      customerName: _auth.currentUser?.displayName ?? 'Guest',
      customerEmail: _auth.currentUser?.email ?? '',
      customerAvatarUrl: _auth.currentUser?.photoURL,
      businessName: business.name,
      businessCity: business.location.city,
      businessImageUrl: business.coverPhotoUrl ?? business.logoUrl ?? '',
      checkIn: booking.checkIn,
      checkOut: booking.checkOut,
      adults: booking.adults,
      children: booking.children,
      infants: booking.infants,
      pricePerNight: price,
      roomType: room?.name,
      roomTypeId: room?.id,
      selectedExtras: arguments.selectedExtras,
      roomSubtotal: roomSubtotal,
      cleaningFee: cleaning,
      serviceFee: service,
      taxes: taxes,
      total: roomSubtotal + extras + cleaning + service + taxes,
      status: BookingStatus.confirmed,
      paymentStatus: PaymentStatus.paid,
      paymentMethod: 'card',
      confirmationCode: _confirmationCode(),
      currency: business.currency,
    );
    try {
      await _firestore.setDocument(
        collection: _collection,
        documentId: id,
        data: {
          'id': result.id,
          'businessId': result.businessId,
          'businessOwnerId': result.businessOwnerId,
          'customerId': result.customerId,
          'customerName': result.customerName,
          'customerEmail': result.customerEmail,
          'customerAvatarUrl': result.customerAvatarUrl,
          'businessName': result.businessName,
          'businessCity': result.businessCity,
          'businessImageUrl': result.businessImageUrl,
          'checkIn': result.checkIn,
          'checkOut': result.checkOut,
          'adults': result.adults,
          'children': result.children,
          'infants': result.infants,
          'pricePerNight': result.pricePerNight,
          'roomType': result.roomType,
          'roomTypeId': result.roomTypeId,
          'selectedExtras': result.selectedExtras
              .map(
                (extra) => {
                  'type': extra.type.name,
                  'price': extra.price,
                  'isPerNight': extra.isPerNight,
                  'isPerHour': extra.isPerHour,
                },
              )
              .toList(),
          'roomSubtotal': result.roomSubtotal,
          'cleaningFee': result.cleaningFee,
          'serviceFee': result.serviceFee,
          'taxes': result.taxes,
          'total': result.total,
          'status': result.status.name,
          'paymentStatus': result.paymentStatus.name,
          'paymentMethod': result.paymentMethod,
          'confirmationCode': result.confirmationCode,
          'currency': result.currency.name,
          'createdAt': _firestore.serverTimestamp,
        },
      );
      log('Booking $id created.', name: 'BookingRepository');
      return result;
    } catch (error, stack) {
      log(
        'Could not create booking.',
        name: 'BookingRepository',
        error: error,
        stackTrace: stack,
      );
      throw const BookingException(
        'We could not complete your booking. Please try again.',
      );
    }
  }

  StayRoomModel? _defaultRoom({
    required List<StayRoomModel> rooms,
    required int? pricePerNight,
  }) {
    if (rooms.isEmpty) return null;
    return rooms.firstWhere(
      (room) => room.pricePerNight == pricePerNight,
      orElse: () => rooms.first,
    );
  }

  DataCursor<BookingModel> getOwnedBookingsCursor({
    required String businessId,
    BookingStatus? status,
    int pageSize = 12,
  }) {
    final ownerId = _auth.currentUser?.uid;
    if (ownerId == null) {
      throw const BookingException('You need to sign in to view bookings.');
    }

    return _firestore.createCursorWhereAll<BookingModel>(
      collection: _collection,
      filters: {
        'businessOwnerId': ownerId,
        'businessId': businessId,
        if (status != null) 'status': status.name,
      },
      pageSize: pageSize,
      listSerializer: (documents) =>
          documents.map(_bookingFromDocument).toList(),
    );
  }

  Future<List<BookingModel>> getOwnedBusinessBookings({
    required String businessId,
  }) async {
    final cursor = getOwnedBookingsCursor(businessId: businessId, pageSize: 50);
    final bookings = <BookingModel>[];

    while (!cursor.isEverythingLoaded) {
      bookings.addAll(await cursor.fetchNextPage());
    }

    return bookings;
  }

  Future<List<BookingModel>> getCustomerBusinessBookings({
    required String businessId,
  }) async {
    final customerId = _auth.currentUser?.uid;
    if (customerId == null) {
      throw const BookingException('You need to sign in to view bookings.');
    }

    final cursor = _firestore.createCursorWhereAll<BookingModel>(
      collection: _collection,
      filters: {'customerId': customerId, 'businessId': businessId},
      pageSize: 50,
      listSerializer: (documents) =>
          documents.map(_bookingFromDocument).toList(),
    );
    final bookings = <BookingModel>[];
    while (!cursor.isEverythingLoaded) {
      bookings.addAll(await cursor.fetchNextPage());
    }
    return bookings;
  }

  DataCursor<BookingModel> getCustomerBookingsCursor({int pageSize = 20}) {
    final customerId = _auth.currentUser?.uid;
    if (customerId == null) {
      throw const BookingException('You need to sign in to view bookings.');
    }

    return _firestore.createCursorWhere<BookingModel>(
      collection: _collection,
      field: 'customerId',
      value: customerId,
      pageSize: pageSize,
      listSerializer: (documents) =>
          documents.map(_bookingFromDocument).toList(),
    );
  }

  Future<void> cancelBooking({required String bookingId}) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw const BookingException('You need to sign in to cancel a booking.');
    }

    try {
      await _firestore.updateDocument(
        collection: _collection,
        documentId: bookingId,
        data: {
          'status': BookingStatus.cancelled.name,
          'updatedAt': _firestore.serverTimestamp,
        },
      );
      log(
        'Booking $bookingId cancelled by customer.',
        name: 'BookingRepository',
      );
    } catch (error, stack) {
      log(
        'Could not cancel booking $bookingId.',
        name: 'BookingRepository',
        error: error,
        stackTrace: stack,
      );
      throw const BookingException(
        'We could not cancel this booking. Please try again.',
      );
    }
  }

  Future<void> declineBooking({required String bookingId}) async {
    if (_auth.currentUser?.uid == null) {
      throw const BookingException('You need to sign in to decline a booking.');
    }

    try {
      await _firestore.updateDocument(
        collection: _collection,
        documentId: bookingId,
        data: {
          'status': BookingStatus.declined.name,
          'updatedAt': _firestore.serverTimestamp,
        },
      );
      log(
        'Booking $bookingId declined by business owner.',
        name: 'BookingRepository',
      );
    } catch (error, stack) {
      log(
        'Could not decline booking $bookingId.',
        name: 'BookingRepository',
        error: error,
        stackTrace: stack,
      );
      throw const BookingException(
        'We could not decline this booking. Please try again.',
      );
    }
  }

  BookingModel _bookingFromDocument(Map<String, dynamic> document) {
    final extras = (document['selectedExtras'] as List<dynamic>? ?? const [])
        .whereType<Map<dynamic, dynamic>>()
        .map(
          (extra) => StayExtraModel(
            type: StayExtraType.values.byName(extra['type'] as String),
            price: (extra['price'] as num?)?.toInt() ?? 0,
            isPerNight: extra['isPerNight'] as bool? ?? false,
            isPerHour: extra['isPerHour'] as bool? ?? false,
          ),
        )
        .toList();

    return BookingModel(
      id: document['id'] as String? ?? '',
      businessId: document['businessId'] as String? ?? '',
      businessOwnerId: document['businessOwnerId'] as String? ?? '',
      customerId: document['customerId'] as String? ?? '',
      customerName: document['customerName'] as String? ?? 'Guest',
      customerEmail: document['customerEmail'] as String? ?? '',
      customerAvatarUrl: document['customerAvatarUrl'] as String?,
      businessName: document['businessName'] as String? ?? '',
      businessCity: document['businessCity'] as String? ?? '',
      businessImageUrl: document['businessImageUrl'] as String? ?? '',
      checkIn: _asDateTime(document['checkIn']),
      checkOut: _asDateTime(document['checkOut']),
      adults: (document['adults'] as num?)?.toInt() ?? 0,
      children: (document['children'] as num?)?.toInt() ?? 0,
      infants: (document['infants'] as num?)?.toInt() ?? 0,
      pricePerNight: (document['pricePerNight'] as num?)?.toInt() ?? 0,
      selectedExtras: extras,
      roomSubtotal: (document['roomSubtotal'] as num?)?.toInt() ?? 0,
      cleaningFee: (document['cleaningFee'] as num?)?.toInt() ?? 0,
      serviceFee: (document['serviceFee'] as num?)?.toInt() ?? 0,
      taxes: (document['taxes'] as num?)?.toInt() ?? 0,
      total: (document['total'] as num?)?.toInt() ?? 0,
      status: _enumByName(
        BookingStatus.values,
        document['status'],
        BookingStatus.confirmed,
      ),
      paymentStatus: _enumByName(
        PaymentStatus.values,
        document['paymentStatus'],
        PaymentStatus.pending,
      ),
      paymentMethod: document['paymentMethod'] as String? ?? '',
      confirmationCode: document['confirmationCode'] as String? ?? '',
      roomType: document['roomType'] as String?,
      roomTypeId: document['roomTypeId'] as String?,
      createdAt: document['createdAt'] is Timestamp
          ? (document['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  DateTime _asDateTime(Object? value) => switch (value) {
    Timestamp timestamp => timestamp.toDate(),
    DateTime dateTime => dateTime,
    _ => DateTime.now(),
  };

  T _enumByName<T extends Enum>(List<T> values, Object? value, T fallback) {
    final name = value as String?;
    return values.where((item) => item.name == name).firstOrNull ?? fallback;
  }

  int _extrasTotal(List<StayExtraModel> extras, int nights) => extras.fold(
    0,
    (total, extra) => total + extra.price * (extra.isPerNight ? nights : 1),
  );
  String _confirmationCode() =>
      'MB-${DateTime.now().year}-${Random().nextInt(899999) + 100000}';
}
