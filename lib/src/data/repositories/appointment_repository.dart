import 'dart:developer';
import 'dart:math' show Random;

import 'package:aquabook/src/data/data_sources/authentication_data_source.dart';
import 'package:aquabook/src/data/data_sources/firestore_data_source.dart';
import 'package:aquabook/src/data/models/appointment_model.dart';
import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_arguments.dart';
import 'package:aquabook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_request.dart';
import 'package:injectable/injectable.dart';

class AppointmentException implements Exception {
  const AppointmentException(this.message);

  final String message;
}

@lazySingleton
class AppointmentRepository {
  AppointmentRepository(this._auth, this._firestore, this._businessRepository);

  static const _collection = 'appointments';

  final AuthenticationDataSource _auth;
  final FirestoreDataSource _firestore;
  final BusinessRepository _businessRepository;

  Future<AppointmentModel> createAppointment({
    required AppointmentPaymentArguments arguments,
    required AppointmentPaymentRequest request,
  }) async {
    final customerId = _auth.currentUser?.uid;
    if (customerId == null) {
      throw const AppointmentException(
        'You need to sign in before confirming an appointment.',
      );
    }

    final selectedBusiness = arguments.review.business;
    final business = await _businessRepository.getBusiness(
      businessId: selectedBusiness.id,
    );
    if (business == null) {
      throw const AppointmentException('This service is no longer available.');
    }
    final provider = business.serviceDetails?.availableProviders
        .where((item) => item.id == arguments.review.provider.id)
        .firstOrNull;
    if (provider == null) {
      throw const AppointmentException('This service provider is unavailable.');
    }

    final duration = arguments.review.offerings.fold(
      0,
      (total, offering) => total + offering.durationMinutes,
    );
    final start = arguments.review.startMinutes;
    final end = start + duration;
    final weekday = arguments.review.date.weekday;
    final isWithinAvailability = provider.availabilitySlots.any(
      (slot) =>
          slot.weekday.index + 1 == weekday &&
          start >= slot.startMinutes &&
          end <= slot.endMinutes,
    );
    if (!isWithinAvailability) {
      throw const AppointmentException(
        'The selected time is no longer available for this provider.',
      );
    }

    // Existing appointments belong to other customers and must not be exposed
    // to the current user. Availability locking therefore belongs in a trusted
    // server-side transaction (for example a Cloud Function), not a client read.
    final dateKey = _dateKey(arguments.review.date);

    final id = _firestore.createDocumentId(collection: _collection);
    final result = AppointmentModel(
      id: id,
      businessId: business.id,
      businessOwnerId: business.ownerId,
      customerId: customerId,
      customerName: request.customerName.trim(),
      customerEmail: request.customerEmail.trim(),
      customerPhone: request.customerPhone.trim(),
      providerId: provider.id,
      providerName: provider.name,
      serviceIds: arguments.review.offerings.map((item) => item.id).toList(),
      serviceNames: arguments.review.offerings
          .map((item) => item.name)
          .toList(),
      date: DateTime(
        arguments.review.date.year,
        arguments.review.date.month,
        arguments.review.date.day,
      ),
      startMinutes: start,
      endMinutes: end,
      serviceCost: arguments.serviceCost,
      addOnsCost: arguments.addOnsCost,
      serviceFee: arguments.serviceFee,
      taxes: arguments.taxes,
      total: arguments.total,
      paymentMethod: request.paymentMethod,
      confirmationCode: _confirmationCode(),
    );
    try {
      await _firestore.setDocument(
        collection: _collection,
        documentId: result.id,
        data: {
          'id': result.id,
          'businessId': result.businessId,
          'businessOwnerId': result.businessOwnerId,
          'customerId': result.customerId,
          'customerName': result.customerName,
          'customerEmail': result.customerEmail,
          'customerPhone': result.customerPhone,
          'providerId': result.providerId,
          'providerName': result.providerName,
          'serviceIds': result.serviceIds,
          'serviceNames': result.serviceNames,
          'date': result.date,
          'dateKey': dateKey,
          'startMinutes': result.startMinutes,
          'endMinutes': result.endMinutes,
          'serviceCost': result.serviceCost,
          'addOnsCost': result.addOnsCost,
          'serviceFee': result.serviceFee,
          'taxes': result.taxes,
          'total': result.total,
          'paymentStatus': 'paid',
          'paymentMethod': result.paymentMethod,
          'status': 'confirmed',
          'confirmationCode': result.confirmationCode,
          'createdAt': _firestore.serverTimestamp,
        },
      );
      log('Appointment ${result.id} created.', name: 'AppointmentRepository');
      return result;
    } catch (error, stackTrace) {
      log(
        'Could not create appointment.',
        name: 'AppointmentRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw const AppointmentException(
        'We could not confirm your appointment. Please try again.',
      );
    }
  }

  static String _dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  static String _confirmationCode() => '#AP-${1000 + Random().nextInt(9000)}';
}
