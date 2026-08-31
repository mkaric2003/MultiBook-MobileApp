import 'dart:developer';
import 'dart:math' show Random;

import 'package:multibook/src/data/data_cursor.dart';
import 'package:multibook/src/data/data_sources/authentication_data_source.dart';
import 'package:multibook/src/data/data_sources/firestore_data_source.dart';
import 'package:multibook/src/data/enums/payment_method_type.dart';
import 'package:multibook/src/data/enums/payment_status.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/firestore_document_path.dart';
import 'package:multibook/src/data/models/firestore_document_write.dart';
import 'package:multibook/src/data/repositories/business_repository.dart';
import 'package:multibook/src/data/repositories/service_availability_repository.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_arguments.dart';
import 'package:multibook/src/features/business-side/promotions/domain/promotion_price_calculator.dart';
import 'package:multibook/src/data/repositories/promotion_repository.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

class AppointmentException implements Exception {
  const AppointmentException(this.message);

  final String message;
}

@lazySingleton
class AppointmentRepository {
  AppointmentRepository(
    this._auth,
    this._firestore,
    this._businessRepository,
    this._serviceAvailabilityRepository,
    this._promotionRepository,
  );

  static const _collection = 'appointments';
  static const _slotCollection = 'appointment_slots';

  final AuthenticationDataSource _auth;
  final FirestoreDataSource _firestore;
  final BusinessRepository _businessRepository;
  final ServiceAvailabilityRepository _serviceAvailabilityRepository;
  final PromotionRepository _promotionRepository;

  Future<AppointmentModel> createAppointment({
    required AppointmentPaymentArguments arguments,
    required AppointmentPaymentRequest request,
    String? promoCode,
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

    final blockedSlotStarts = await _serviceAvailabilityRepository
        .getBlockedSlotStarts(
          businessId: business.id,
          providerId: provider.id,
          date: arguments.review.date,
        );
    if (_slotStarts(start: start, end: end).any(blockedSlotStarts.contains)) {
      throw const AppointmentException(
        'One or more selected times are unavailable.',
      );
    }

    final dateKey = _dateKey(arguments.review.date);

    final id = _firestore.createDocumentId(collection: _collection);
    final promotion = await _promotionRepository.getActiveForBusiness(
      business.id,
      promoCode: promoCode,
    );
    if (promoCode?.trim().isNotEmpty == true && promotion == null) {
      throw const AppointmentException('The promo code is invalid or expired.');
    }
    final discount = PromotionPriceCalculator.discount(
      subtotal: arguments.serviceCost,
      promotion: promotion,
    );
    final discountedServiceCost = arguments.serviceCost - discount;
    final discountedServiceFee = discountedServiceCost * .085;
    final discountedTaxes = (discountedServiceCost + discountedServiceFee) * .1;
    final result = AppointmentModel(
      id: id,
      businessId: business.id,
      businessOwnerId: business.ownerId,
      businessName: business.name,
      businessImageUrl: business.coverPhotoUrl ?? business.logoUrl ?? '',
      customerId: customerId,
      customerName: request.customerName.trim(),
      customerEmail: request.customerEmail.trim(),
      customerPhone: request.customerPhone.trim(),
      customerAvatarUrl: _auth.currentUser?.photoURL,
      providerId: provider.id,
      providerName: provider.name,
      providerCommissionRate: provider.commissionRate,
      providerEarnings: discountedServiceCost * (provider.commissionRate / 100),
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
      serviceCost: discountedServiceCost,
      originalServiceCost: arguments.serviceCost,
      discountAmount: discount,
      addOnsCost: 0,
      serviceFee: discountedServiceFee,
      taxes: discountedTaxes,
      total: discountedServiceCost + discountedServiceFee + discountedTaxes,
      paymentStatus: request.paymentType == PaymentMethodType.cash
          ? PaymentStatus.pending
          : PaymentStatus.paid,
      paymentMethod: request.paymentMethod,
      confirmationCode: _confirmationCode(),
      currency: business.currency,
    );
    try {
      final appointmentWrite = FirestoreDocumentWrite(
        collection: _collection,
        documentId: result.id,
        data: {
          'id': result.id,
          'businessId': result.businessId,
          'businessOwnerId': result.businessOwnerId,
          'businessName': result.businessName,
          'businessImageUrl': result.businessImageUrl,
          'customerId': result.customerId,
          'customerName': result.customerName,
          'customerEmail': result.customerEmail,
          'customerPhone': result.customerPhone,
          'customerAvatarUrl': result.customerAvatarUrl,
          'providerId': result.providerId,
          'providerName': result.providerName,
          'providerCommissionRate': result.providerCommissionRate,
          'providerEarnings': result.providerEarnings,
          'serviceIds': result.serviceIds,
          'serviceNames': result.serviceNames,
          'date': result.date,
          'dateKey': dateKey,
          'startMinutes': result.startMinutes,
          'endMinutes': result.endMinutes,
          'serviceCost': result.serviceCost,
          'originalServiceCost': result.originalServiceCost,
          'discountAmount': result.discountAmount,
          'addOnsCost': result.addOnsCost,
          'serviceFee': result.serviceFee,
          'taxes': result.taxes,
          'total': result.total,
          'paymentStatus': result.paymentStatus.name,
          'paymentType': request.paymentType.name,
          'paymentMethod': result.paymentMethod,
          'status': 'confirmed',
          'rescheduleCount': 0,
          'confirmationCode': result.confirmationCode,
          'currency': result.currency.name,
          'createdAt': _firestore.serverTimestamp,
        },
      );
      final slotWrites = _slotStarts(start: start, end: end).map((slotStart) {
        final availabilityKey = _availabilityKey(
          businessId: business.id,
          providerId: provider.id,
          dateKey: dateKey,
        );
        return FirestoreDocumentWrite(
          collection: _slotCollection,
          documentId: '$availabilityKey-$slotStart',
          data: {
            'availabilityKey': availabilityKey,
            'appointmentId': result.id,
            'businessId': business.id,
            'providerId': provider.id,
            'dateKey': dateKey,
            'startMinutes': slotStart,
            'customerId': customerId,
            'createdAt': _firestore.serverTimestamp,
          },
        );
      }).toList();
      final didCreate = await _firestore.createDocumentsIfAbsent(
        documentsToCheck: slotWrites,
        documentsToCreate: [appointmentWrite, ...slotWrites],
      );
      if (!didCreate) {
        throw const AppointmentException(
          'One or more selected times were just booked. Please choose another time.',
        );
      }
      log('Appointment ${result.id} created.', name: 'AppointmentRepository');
      return result;
    } on AppointmentException {
      rethrow;
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

  Future<Set<int>> getBookedSlotStarts({
    required String businessId,
    required String providerId,
    required DateTime date,
  }) async {
    if (_auth.currentUser == null) {
      throw const AppointmentException(
        'You need to sign in to view appointment availability.',
      );
    }
    try {
      final documents = await _firestore.getDocumentsWhere(
        collection: _slotCollection,
        field: 'availabilityKey',
        value: _availabilityKey(
          businessId: businessId,
          providerId: providerId,
          dateKey: _dateKey(date),
        ),
      );
      return documents
          .map((document) => (document['startMinutes'] as num?)?.toInt())
          .whereType<int>()
          .toSet();
    } catch (error, stackTrace) {
      log(
        'Could not load booked appointment slots.',
        name: 'AppointmentRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw const AppointmentException(
        'We could not load availability. Please try again.',
      );
    }
  }

  Future<AppointmentModel> cancelAppointment(
    AppointmentModel appointment,
  ) async {
    final userId = _auth.currentUser?.uid;
    final isCustomer = userId == appointment.customerId;
    final isBusinessOwner = userId == appointment.businessOwnerId;
    if (userId == null || (!isCustomer && !isBusinessOwner)) {
      throw const AppointmentException(
        'You are not allowed to cancel this appointment.',
      );
    }
    try {
      final status = isCustomer ? 'cancelled' : 'declined';
      await _firestore.updateDocument(
        collection: _collection,
        documentId: appointment.id,
        data: {'status': status, 'updatedAt': _firestore.serverTimestamp},
      );
      final dateKey = _dateKey(appointment.date);
      for (final slotStart in _slotStarts(
        start: appointment.startMinutes,
        end: appointment.endMinutes,
      )) {
        await _firestore.deleteDocument(
          collection: _slotCollection,
          documentId:
              '${_availabilityKey(businessId: appointment.businessId, providerId: appointment.providerId, dateKey: dateKey)}-$slotStart',
        );
      }
      log(
        'Appointment ${appointment.id} $status by ${isCustomer ? 'customer' : 'business owner'}.',
        name: 'AppointmentRepository',
      );
      return appointment.copyWith(status: status);
    } catch (error, stackTrace) {
      log(
        'Could not cancel appointment.',
        name: 'AppointmentRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw const AppointmentException(
        'We could not update this appointment. Please try again.',
      );
    }
  }

  Future<AppointmentModel> rescheduleAppointment({
    required AppointmentModel appointment,
    required DateTime date,
    required int startMinutes,
  }) async {
    final userId = _auth.currentUser?.uid;
    final isCustomer = userId == appointment.customerId;
    final isBusinessOwner = userId == appointment.businessOwnerId;
    if (userId == null || (!isCustomer && !isBusinessOwner)) {
      throw const AppointmentException(
        'You are not allowed to reschedule this appointment.',
      );
    }
    if (isCustomer && appointment.rescheduleCount >= 1) {
      throw const AppointmentException(
        'This appointment has already been rescheduled once.',
      );
    }
    if (appointment.status != 'confirmed') {
      throw const AppointmentException(
        'Only confirmed appointments can be rescheduled.',
      );
    }

    final business = await _businessRepository.getBusiness(
      businessId: appointment.businessId,
    );
    final provider = business?.serviceDetails?.availableProviders
        .where((item) => item.id == appointment.providerId)
        .firstOrNull;
    if (provider == null) {
      throw const AppointmentException('This service provider is unavailable.');
    }
    final endMinutes =
        startMinutes + (appointment.endMinutes - appointment.startMinutes);
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final isWithinAvailability = provider.availabilitySlots.any(
      (slot) =>
          slot.weekday.index + 1 == normalizedDate.weekday &&
          startMinutes >= slot.startMinutes &&
          endMinutes <= slot.endMinutes,
    );
    if (!isWithinAvailability) {
      throw const AppointmentException(
        'The selected time is no longer available for this provider.',
      );
    }

    final blockedSlotStarts = await _serviceAvailabilityRepository
        .getBlockedSlotStarts(
          businessId: appointment.businessId,
          providerId: appointment.providerId,
          date: normalizedDate,
        );
    if (_slotStarts(
      start: startMinutes,
      end: endMinutes,
    ).any(blockedSlotStarts.contains)) {
      throw const AppointmentException(
        'One or more selected times are unavailable.',
      );
    }

    final updated = appointment.copyWith(
      date: normalizedDate,
      startMinutes: startMinutes,
      endMinutes: endMinutes,
      rescheduleCount: isCustomer
          ? appointment.rescheduleCount + 1
          : appointment.rescheduleCount,
    );
    final newDateKey = _dateKey(normalizedDate);
    final oldDateKey = _dateKey(appointment.date);
    final newSlotWrites = _slotStarts(start: startMinutes, end: endMinutes)
        .map(
          (slotStart) => _slotWrite(
            appointment: updated,
            customerId: appointment.customerId,
            dateKey: newDateKey,
            slotStart: slotStart,
          ),
        )
        .toList();
    final oldSlotPaths =
        _slotStarts(
              start: appointment.startMinutes,
              end: appointment.endMinutes,
            )
            .map(
              (slotStart) => FirestoreDocumentPath(
                collection: _slotCollection,
                documentId:
                    '${_availabilityKey(businessId: appointment.businessId, providerId: appointment.providerId, dateKey: oldDateKey)}-$slotStart',
              ),
            )
            .toList();

    try {
      final didReschedule = await _firestore.createDocumentsIfAbsent(
        documentsToCheck: newSlotWrites,
        documentsToCreate: newSlotWrites,
        documentsToUpdate: [
          FirestoreDocumentWrite(
            collection: _collection,
            documentId: appointment.id,
            data: {
              'date': updated.date,
              'dateKey': newDateKey,
              'startMinutes': updated.startMinutes,
              'endMinutes': updated.endMinutes,
              'rescheduleCount': updated.rescheduleCount,
              'updatedAt': _firestore.serverTimestamp,
            },
          ),
        ],
        documentsToDelete: oldSlotPaths,
      );
      if (!didReschedule) {
        throw const AppointmentException(
          'One or more selected times were just booked. Please choose another time.',
        );
      }
      return updated;
    } on AppointmentException {
      rethrow;
    } catch (error, stackTrace) {
      log(
        'Could not reschedule appointment.',
        name: 'AppointmentRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw const AppointmentException(
        'We could not reschedule your appointment. Please try again.',
      );
    }
  }

  DataCursor<AppointmentModel> getCustomerAppointmentsCursor({
    int pageSize = 20,
  }) {
    final customerId = _auth.currentUser?.uid;
    if (customerId == null) {
      throw const AppointmentException(
        'You need to sign in to view appointments.',
      );
    }
    return _firestore.createCursorWhere<AppointmentModel>(
      collection: _collection,
      field: 'customerId',
      value: customerId,
      pageSize: pageSize,
      listSerializer: (documents) => documents.map(_fromDocument).toList(),
    );
  }

  Future<List<AppointmentModel>> enrichAppointmentsWithBusinessData(
    List<AppointmentModel> appointments,
  ) async => Future.wait(
    appointments.map((appointment) async {
      final hasBusinessName =
          appointment.businessName.isNotEmpty &&
          appointment.businessName != 'Service business';
      final hasBusinessImage = appointment.businessImageUrl.isNotEmpty;
      if (hasBusinessName && hasBusinessImage) return appointment;

      final business = await _businessRepository.getBusiness(
        businessId: appointment.businessId,
      );
      if (business == null) return appointment;
      return appointment.copyWith(
        businessName: hasBusinessName ? null : business.name,
        businessImageUrl: hasBusinessImage
            ? null
            : business.coverPhotoUrl ?? business.logoUrl ?? '',
      );
    }),
  );

  AppointmentModel _fromDocument(Map<String, dynamic> document) {
    final date = document['date'];
    return AppointmentModel(
      id: document['id'] as String? ?? '',
      businessId: document['businessId'] as String? ?? '',
      businessOwnerId: document['businessOwnerId'] as String? ?? '',
      businessName: document['businessName'] as String? ?? 'Service business',
      businessImageUrl: document['businessImageUrl'] as String? ?? '',
      customerId: document['customerId'] as String? ?? '',
      customerName: document['customerName'] as String? ?? '',
      customerEmail: document['customerEmail'] as String? ?? '',
      customerPhone: document['customerPhone'] as String? ?? '',
      customerAvatarUrl: document['customerAvatarUrl'] as String?,
      providerId: document['providerId'] as String? ?? '',
      providerName: document['providerName'] as String? ?? '',
      providerCommissionRate:
          (document['providerCommissionRate'] as num?)?.toDouble() ?? 100,
      providerEarnings:
          (document['providerEarnings'] as num?)?.toDouble() ??
          ((document['serviceCost'] as num?)?.toDouble() ?? 0),
      serviceIds: List<String>.from(
        document['serviceIds'] as List? ?? const [],
      ),
      serviceNames: List<String>.from(
        document['serviceNames'] as List? ?? const [],
      ),
      date: date is Timestamp ? date.toDate() : DateTime.now(),
      startMinutes: (document['startMinutes'] as num?)?.toInt() ?? 0,
      endMinutes: (document['endMinutes'] as num?)?.toInt() ?? 0,
      serviceCost: (document['serviceCost'] as num?)?.toInt() ?? 0,
      originalServiceCost:
          (document['originalServiceCost'] as num?)?.toInt() ??
          (document['serviceCost'] as num?)?.toInt() ??
          0,
      discountAmount: (document['discountAmount'] as num?)?.toInt() ?? 0,
      addOnsCost: (document['addOnsCost'] as num?)?.toInt() ?? 0,
      serviceFee: (document['serviceFee'] as num?)?.toDouble() ?? 0,
      taxes: (document['taxes'] as num?)?.toDouble() ?? 0,
      total: (document['total'] as num?)?.toDouble() ?? 0,
      paymentStatus: _paymentStatus(document['paymentStatus']),
      paymentMethod: document['paymentMethod'] as String? ?? '',
      confirmationCode: document['confirmationCode'] as String? ?? '',
      status: document['status'] as String? ?? 'confirmed',
      rescheduleCount: (document['rescheduleCount'] as num?)?.toInt() ?? 0,
    );
  }

  PaymentStatus _paymentStatus(Object? value) =>
      PaymentStatus.values
          .where((status) => status.name == value)
          .firstOrNull ??
      PaymentStatus.pending;

  static String _dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  static String _availabilityKey({
    required String businessId,
    required String providerId,
    required String dateKey,
  }) => '$businessId-$providerId-$dateKey';

  static Iterable<int> _slotStarts({
    required int start,
    required int end,
  }) sync* {
    for (var time = start; time < end; time += 30) {
      yield time;
    }
  }

  FirestoreDocumentWrite _slotWrite({
    required AppointmentModel appointment,
    required String customerId,
    required String dateKey,
    required int slotStart,
  }) {
    final availabilityKey = _availabilityKey(
      businessId: appointment.businessId,
      providerId: appointment.providerId,
      dateKey: dateKey,
    );
    return FirestoreDocumentWrite(
      collection: _slotCollection,
      documentId: '$availabilityKey-$slotStart',
      data: {
        'availabilityKey': availabilityKey,
        'appointmentId': appointment.id,
        'businessId': appointment.businessId,
        'providerId': appointment.providerId,
        'dateKey': dateKey,
        'startMinutes': slotStart,
        'customerId': customerId,
        'createdAt': _firestore.serverTimestamp,
      },
    );
  }

  static String _confirmationCode() => '#AP-${1000 + Random().nextInt(9000)}';
}
