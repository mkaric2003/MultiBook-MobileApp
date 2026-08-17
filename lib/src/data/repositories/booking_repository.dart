import 'dart:developer';
import 'dart:math' show Random;

import 'package:aquabook/src/data/data_sources/authentication_data_source.dart';
import 'package:aquabook/src/data/data_sources/firestore_data_source.dart';
import 'package:aquabook/src/data/enums/booking_status.dart';
import 'package:aquabook/src/data/enums/payment_status.dart';
import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/data/models/stay_extra_model.dart';
import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/features/customer-side/payment/domain/models/payment_arguments.dart';
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
    final booking = arguments.review.bookingState;
    final price =
        arguments.review.booking.pricePerNight ??
        business.stayDetails?.pricePerNight ??
        0;
    final room = price * booking.nightCount;
    final extras = _extrasTotal(arguments.selectedExtras, booking.nightCount);
    final cleaning = 25;
    final service = ((room + extras) * .05).round();
    final taxes = ((room + extras + cleaning + service) * .08).round();
    final id = _firestore.createDocumentId(collection: _collection);
    final result = BookingModel(
      id: id,
      businessId: business.id,
      businessOwnerId: business.ownerId,
      customerId: customerId,
      businessName: business.name,
      businessCity: business.location.city,
      businessImageUrl: business.coverPhotoUrl ?? business.logoUrl ?? '',
      checkIn: booking.checkIn,
      checkOut: booking.checkOut,
      adults: booking.adults,
      children: booking.children,
      infants: booking.infants,
      pricePerNight: price,
      selectedExtras: arguments.selectedExtras,
      roomSubtotal: room,
      cleaningFee: cleaning,
      serviceFee: service,
      taxes: taxes,
      total: room + extras + cleaning + service + taxes,
      status: BookingStatus.confirmed,
      paymentStatus: PaymentStatus.paid,
      paymentMethod: 'card',
      confirmationCode: _confirmationCode(),
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
          'businessName': result.businessName,
          'businessCity': result.businessCity,
          'businessImageUrl': result.businessImageUrl,
          'checkIn': result.checkIn,
          'checkOut': result.checkOut,
          'adults': result.adults,
          'children': result.children,
          'infants': result.infants,
          'pricePerNight': result.pricePerNight,
          'selectedExtras': result.selectedExtras
              .map(
                (extra) => {
                  'type': extra.type.name,
                  'price': extra.price,
                  'isPerNight': extra.isPerNight,
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

  int _extrasTotal(List<StayExtraModel> extras, int nights) => extras.fold(
    0,
    (sum, extra) => sum + extra.price * (extra.isPerNight ? nights : 1),
  );
  String _confirmationCode() =>
      'MB-${DateTime.now().year}-${Random().nextInt(899999) + 100000}';
}
