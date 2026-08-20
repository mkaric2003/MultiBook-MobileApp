import 'dart:developer';

import 'package:aquabook/src/data/data_cursor.dart';
import 'package:aquabook/src/data/data_sources/authentication_data_source.dart';
import 'package:aquabook/src/data/data_sources/firebase_storage_data_source.dart';
import 'package:aquabook/src/data/data_sources/firestore_data_source.dart';
import 'package:aquabook/src/data/data_sources/nominatim_data_source.dart';
import 'package:aquabook/src/data/enums/business_type.dart';
import 'package:aquabook/src/data/enums/service_weekday.dart';
import 'package:aquabook/src/data/enums/stay_amenity.dart';
import 'package:aquabook/src/data/enums/stay_extra_type.dart';
import 'package:aquabook/src/data/models/business_location_model.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/data/models/service_availability_slot_model.dart';
import 'package:aquabook/src/data/models/service_details_model.dart';
import 'package:aquabook/src/data/models/service_offering_model.dart';
import 'package:aquabook/src/data/models/service_provider_model.dart';
import 'package:aquabook/src/data/models/stay_details_model.dart';
import 'package:aquabook/src/data/models/stay_extra_model.dart';
import 'package:aquabook/src/data/models/stay_room_model.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
import 'package:aquabook/utils/image_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

class BusinessException implements Exception {
  const BusinessException(this.message);

  final String message;
}

@lazySingleton
class BusinessRepository {
  BusinessRepository(
    this._authenticationDataSource,
    this._firestoreDataSource,
    this._storageDataSource,
    this._nominatimDataSource,
    this._userRepository,
  );

  static const _businessesCollection = 'businesses';
  static const _demoStayNames = [
    'Oceanview Resort',
    'Mountain Cabin Retreat',
    'City Center Hotel',
    'Sunset Beach Villa',
    'Old Town Apartment',
    'Pinewood Lodge',
    'Riverside Guesthouse',
    'Azure Bay Hotel',
    'Golden Peak Chalet',
    'Harbor View Suites',
    'Lakehouse Escape',
    'Downtown Loft',
    'Seaside Boutique Hotel',
    'Forest Edge Cabin',
    'Skyline Residence',
    'Meadowbrook Villa',
    'Coastal Breeze Apartment',
    'Alpine Hideaway',
    'The Grand Terrace',
    'Palm Grove Resort',
  ];
  static const _demoStayImageUrls = [
    'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1000&q=85',
    'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1000&q=85',
    'https://images.unsplash.com/photo-1564501049412-61c2a3083791?auto=format&fit=crop&w=1000&q=85',
    'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=1000&q=85',
    'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1000&q=85',
  ];
  static const _demoStayCities = [
    'Sarajevo',
    'Mostar',
    'Banja Luka',
    'Tuzla',
    'Zenica',
    'Bihać',
    'Trebinje',
    'Neum',
    'Jajce',
    'Travnik',
    'Konjic',
    'Visoko',
    'Prijedor',
    'Brčko',
    'Bijeljina',
    'Goražde',
    'Livno',
    'Foča',
    'Jahorina',
    'Srebrenik',
  ];
  static const _demoServices = <Map<String, String>>[
    {
      'name': 'Studio Glow',
      'categoryId': 'hair_salon',
      'serviceName': 'Women\'s haircut & styling',
      'city': 'Sarajevo',
    },
    {
      'name': 'Gentleman\'s Cut',
      'categoryId': 'barbershop',
      'serviceName': 'Haircut and beard trim',
      'city': 'Mostar',
    },
    {
      'name': 'Pearl Dental Care',
      'categoryId': 'dental_clinic',
      'serviceName': 'Dental examination',
      'city': 'Banja Luka',
    },
    {
      'name': 'Nails by Lana',
      'categoryId': 'nail_salon',
      'serviceName': 'Gel manicure',
      'city': 'Tuzla',
    },
    {
      'name': 'Volt Elektro',
      'categoryId': 'electrician',
      'serviceName': 'Electrical inspection',
      'city': 'Zenica',
    },
    {
      'name': 'Relax Point Spa',
      'categoryId': 'massage_spa',
      'serviceName': 'Full body massage',
      'city': 'Bihać',
    },
    {
      'name': 'Move Better Physio',
      'categoryId': 'physiotherapy',
      'serviceName': 'Physiotherapy session',
      'city': 'Trebinje',
    },
    {
      'name': 'Beauty Lab',
      'categoryId': 'beauty_salon',
      'serviceName': 'Facial treatment',
      'city': 'Neum',
    },
    {
      'name': 'FitCore Training',
      'categoryId': 'personal_training',
      'serviceName': 'Personal training session',
      'city': 'Jajce',
    },
    {
      'name': 'Bright Minds',
      'categoryId': 'tutoring',
      'serviceName': 'One-to-one math lesson',
      'city': 'Travnik',
    },
    {
      'name': 'AquaFix Plumbing',
      'categoryId': 'plumber',
      'serviceName': 'Plumbing consultation',
      'city': 'Konjic',
    },
    {
      'name': 'Fresh Home Cleaning',
      'categoryId': 'cleaning_service',
      'serviceName': 'Home cleaning visit',
      'city': 'Visoko',
    },
    {
      'name': 'AutoPro Service',
      'categoryId': 'automotive_service',
      'serviceName': 'Vehicle diagnostic',
      'city': 'Prijedor',
    },
    {
      'name': 'MediPlus Clinic',
      'categoryId': 'medical_clinic',
      'serviceName': 'General consultation',
      'city': 'Brčko',
    },
    {
      'name': 'Glow Pedi Studio',
      'categoryId': 'nail_salon',
      'serviceName': 'Spa pedicure',
      'city': 'Bijeljina',
    },
  ];

  final AuthenticationDataSource _authenticationDataSource;
  final FirestoreDataSource _firestoreDataSource;
  final FirebaseStorageDataSource _storageDataSource;
  final NominatimDataSource _nominatimDataSource;
  final UserRepository _userRepository;

  Future<bool> hasBusinesses() async {
    final ownerId = _authenticationDataSource.currentUser?.uid;
    if (ownerId == null) {
      return false;
    }

    try {
      return await _firestoreDataSource.hasDocumentWhere(
        collection: _businessesCollection,
        field: 'ownerId',
        value: ownerId,
      );
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Could not determine whether the user has businesses: ${error.code}',
        name: 'BusinessRepository',
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<BusinessLocationModel?> resolveBusinessLocation({
    required double latitude,
    required double longitude,
  }) => _nominatimDataSource.reverseGeocode(
    latitude: latitude,
    longitude: longitude,
  );

  Future<BusinessModel?> getBusiness({required String businessId}) async {
    try {
      final businessData = await _firestoreDataSource.getDocument(
        collection: _businessesCollection,
        documentId: businessId,
      );
      return businessData == null ? null : _businessFromData(businessData);
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Could not load business $businessId: ${error.code}',
        name: 'BusinessRepository',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<BusinessModel?> getFirstOwnedBusiness() async {
    final ownerId = _authenticationDataSource.currentUser?.uid;
    if (ownerId == null) {
      return null;
    }

    try {
      final businessData = await _firestoreDataSource.getFirstDocumentWhere(
        collection: _businessesCollection,
        field: 'ownerId',
        value: ownerId,
      );
      return businessData == null ? null : _businessFromData(businessData);
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Could not load the owner business: ${error.code}',
        name: 'BusinessRepository',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<List<BusinessModel>> getOwnedBusinesses() async {
    final ownerId = _authenticationDataSource.currentUser?.uid;
    if (ownerId == null) {
      return const [];
    }

    try {
      final businessesData = await _firestoreDataSource.getDocumentsWhere(
        collection: _businessesCollection,
        field: 'ownerId',
        value: ownerId,
      );
      return businessesData.map(_businessFromData).toList();
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Could not load the owner businesses: ${error.code}',
        name: 'BusinessRepository',
        error: error,
        stackTrace: stackTrace,
      );
      return const [];
    }
  }

  Future<List<BusinessModel>> getRecommendedStays({int limit = 3}) async {
    try {
      final businessesData = await _firestoreDataSource.getDocumentsWhere(
        collection: _businessesCollection,
        field: 'type',
        value: BusinessType.stays.name,
      );
      final stays = businessesData
          .map(_businessFromData)
          .where((business) => business.isActive)
          .toList();
      final ratedStays =
          stays.where((business) => business.averageRating > 0).toList()
            ..sort((first, second) {
              final ratingComparison = second.averageRating.compareTo(
                first.averageRating,
              );
              return ratingComparison != 0
                  ? ratingComparison
                  : second.reviewCount.compareTo(first.reviewCount);
            });

      if (ratedStays.isEmpty) {
        return stays.take(limit).toList();
      }

      final unratedStays = stays
          .where((business) => business.averageRating <= 0)
          .toList();
      return [...ratedStays, ...unratedStays].take(limit).toList();
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Could not load recommended stays: ${error.code}',
        name: 'BusinessRepository',
        error: error,
        stackTrace: stackTrace,
      );
      return const [];
    }
  }

  Future<List<BusinessModel>> getStays() async {
    try {
      final businessesData = await _firestoreDataSource.getDocumentsWhere(
        collection: _businessesCollection,
        field: 'type',
        value: BusinessType.stays.name,
      );
      return businessesData
          .map(_businessFromData)
          .where((business) => business.isActive)
          .toList();
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Could not load stays: ${error.code}',
        name: 'BusinessRepository',
        error: error,
        stackTrace: stackTrace,
      );
      return const [];
    }
  }

  Future<List<String>> getStayCities() async {
    try {
      final businessesData = await _firestoreDataSource.getDocumentsWhere(
        collection: _businessesCollection,
        field: 'type',
        value: BusinessType.stays.name,
      );
      final cities =
          businessesData
              .map(_businessFromData)
              .where((business) => business.isActive)
              .map((business) => business.location.city.trim())
              .where((city) => city.isNotEmpty)
              .toSet()
              .toList()
            ..sort();
      return cities;
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Could not load stay cities: ${error.code}',
        name: 'BusinessRepository',
        error: error,
        stackTrace: stackTrace,
      );
      return const [];
    }
  }

  Future<List<BusinessModel>> getPopularServices({int limit = 3}) async {
    try {
      final businessesData = await _firestoreDataSource.getDocumentsWhere(
        collection: _businessesCollection,
        field: 'type',
        value: BusinessType.services.name,
      );
      final services =
          businessesData
              .map(_businessFromData)
              .where((business) => business.isActive)
              .toList()
            ..shuffle();
      return services.take(limit).toList();
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Could not load popular services: ${error.code}',
        name: 'BusinessRepository',
        error: error,
        stackTrace: stackTrace,
      );
      return const [];
    }
  }

  Future<List<BusinessModel>> searchStays(String query) async {
    final normalizedQuery = _normalizeSearchValue(query);
    if (normalizedQuery.isEmpty) {
      return const [];
    }

    try {
      final results = await Future.wait([
        _firestoreDataSource.getDocumentsWherePrefix(
          collection: _businessesCollection,
          equalityField: 'type',
          equalityValue: BusinessType.stays.name,
          prefixField: 'nameLowercase',
          prefix: normalizedQuery,
        ),
        _firestoreDataSource.getDocumentsWherePrefix(
          collection: _businessesCollection,
          equalityField: 'type',
          equalityValue: BusinessType.stays.name,
          prefixField: 'location.cityLowercase',
          prefix: normalizedQuery,
        ),
      ]);
      final stays = results
          .expand((documents) => documents)
          .map(_businessFromData)
          .where((business) => business.isActive)
          .toList();
      if (stays.isNotEmpty) {
        return {for (final stay in stays) stay.id: stay}.values.toList();
      }

      // Existing documents created before the normalized fields were added are
      // kept searchable until their data is migrated.
      final legacyStays = await _firestoreDataSource.getDocumentsWhere(
        collection: _businessesCollection,
        field: 'type',
        value: BusinessType.stays.name,
      );
      return legacyStays
          .map(_businessFromData)
          .where(
            (business) =>
                business.isActive &&
                (_normalizeSearchValue(
                      business.name,
                    ).contains(normalizedQuery) ||
                    _normalizeSearchValue(
                      business.location.city,
                    ).startsWith(normalizedQuery)),
          )
          .toList();
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Could not search stays: ${error.code}',
        name: 'BusinessRepository',
        error: error,
        stackTrace: stackTrace,
      );
      return const [];
    }
  }

  Future<List<BusinessModel>> searchServices(String query) async {
    final normalizedQuery = _normalizeSearchValue(query);
    if (normalizedQuery.isEmpty) {
      return const [];
    }

    try {
      final results = await Future.wait([
        _firestoreDataSource.getDocumentsWherePrefix(
          collection: _businessesCollection,
          equalityField: 'type',
          equalityValue: BusinessType.services.name,
          prefixField: 'nameLowercase',
          prefix: normalizedQuery,
        ),
        _firestoreDataSource.getDocumentsWherePrefix(
          collection: _businessesCollection,
          equalityField: 'type',
          equalityValue: BusinessType.services.name,
          prefixField: 'location.cityLowercase',
          prefix: normalizedQuery,
        ),
      ]);
      final services = results
          .expand((documents) => documents)
          .map(_businessFromData)
          .where((business) => business.isActive)
          .toList();
      if (services.isNotEmpty) {
        return {
          for (final service in services) service.id: service,
        }.values.toList();
      }

      final legacyServices = await _firestoreDataSource.getDocumentsWhere(
        collection: _businessesCollection,
        field: 'type',
        value: BusinessType.services.name,
      );
      return legacyServices
          .map(_businessFromData)
          .where(
            (business) =>
                business.isActive &&
                (_normalizeSearchValue(
                      business.name,
                    ).contains(normalizedQuery) ||
                    _normalizeSearchValue(
                      business.location.city,
                    ).startsWith(normalizedQuery)),
          )
          .toList();
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Could not search services: ${error.code}',
        name: 'BusinessRepository',
        error: error,
        stackTrace: stackTrace,
      );
      return const [];
    }
  }

  DataCursor<BusinessModel> getStaysCursor({int pageSize = 6}) {
    return _firestoreDataSource.createCursorWhere<BusinessModel>(
      collection: _businessesCollection,
      field: 'type',
      value: BusinessType.stays.name,
      pageSize: pageSize,
      listSerializer: (documents) => documents.map(_businessFromData).toList(),
    );
  }

  DataCursor<BusinessModel> getServicesCursor({int pageSize = 6}) {
    return _firestoreDataSource.createCursorWhere<BusinessModel>(
      collection: _businessesCollection,
      field: 'type',
      value: BusinessType.services.name,
      pageSize: pageSize,
      listSerializer: (documents) => documents.map(_businessFromData).toList(),
    );
  }

  Future<int> seedDemoStays() async {
    final ownerId = _authenticationDataSource.currentUser?.uid;
    if (ownerId == null) {
      throw const BusinessException(
        'You need to sign in before creating demo stays.',
      );
    }

    String? firstBusinessId;
    try {
      for (var index = 0; index < _demoStayNames.length; index++) {
        final businessId = _firestoreDataSource.createDocumentId(
          collection: _businessesCollection,
        );
        firstBusinessId ??= businessId;
        final pricePerNight = 80 + (index * 15);
        final rating = index.isEven ? 4.1 + ((index % 5) * 0.18) : 0.0;
        final imageUrl = _demoStayImageUrls[index % _demoStayImageUrls.length];
        final city = _demoStayCities[index % _demoStayCities.length];
        final categoryId = ['hotel', 'apartment', 'cabin'][index % 3];
        final amenities = StayAmenity.values
            .take(2 + (index % 5))
            .map((amenity) => amenity.name)
            .toList();
        final rooms = categoryId == 'hotel'
            ? [
                {
                  'id': 'deluxe-room',
                  'name': 'Deluxe Room',
                  'maxGuests': 2,
                  'sizeSquareMeters': 32,
                  'pricePerNight': pricePerNight,
                  'quantity': 12,
                },
                {
                  'id': 'executive-suite',
                  'name': 'Executive Suite',
                  'maxGuests': 4,
                  'sizeSquareMeters': 55,
                  'pricePerNight': pricePerNight + 90,
                  'quantity': 6,
                },
              ]
            : const <Map<String, Object>>[];

        await _firestoreDataSource.setDocument(
          collection: _businessesCollection,
          documentId: businessId,
          data: {
            'id': businessId,
            'ownerId': ownerId,
            'type': BusinessType.stays.name,
            'name': _demoStayNames[index],
            'categoryId': categoryId,
            'nameLowercase': _normalizeSearchValue(_demoStayNames[index]),
            'cityLowercase': _normalizeSearchValue(city),
            'stayPricePerNight': pricePerNight,
            'maxGuestCapacity': rooms.isEmpty
                ? 99
                : rooms
                      .map((room) => room['maxGuests'] as int)
                      .reduce(
                        (first, second) => first > second ? first : second,
                      ),
            'location': {
              'address': '${index + 1} Demo Street, $city',
              'city': city,
              'cityLowercase': _normalizeSearchValue(city),
              'latitude': 43.8563 + (index * 0.002),
              'longitude': 18.4131 + (index * 0.002),
            },
            'shortDescription': 'A comfortable stay for your next trip.',
            'logoUrl': imageUrl,
            'coverPhotoUrl': imageUrl,
            'photoUrls': [imageUrl],
            'isActive': true,
            'averageRating': rating,
            'reviewCount': rating > 0 ? 40 + (index * 11) : 0,
            'stayDetails': {
              'pricePerNight': pricePerNight,
              'amenities': amenities,
              'rooms': rooms,
              'extras': [
                {
                  'type': StayExtraType.breakfast.name,
                  'price': 20,
                  'isPerNight': true,
                },
                {
                  'type': StayExtraType.parking.name,
                  'price': 15,
                  'isPerNight': true,
                },
                {
                  'type': StayExtraType.spaAccess.name,
                  'price': 40,
                  'isPerNight': false,
                },
              ],
            },
            'createdAt': _firestoreDataSource.serverTimestamp,
            'updatedAt': _firestoreDataSource.serverTimestamp,
          },
        );
      }
      if (firstBusinessId != null) {
        await _setSelectedBusiness(firstBusinessId);
      }
      log(
        'Created ${_demoStayNames.length} demo stays.',
        name: 'BusinessRepository',
      );
      return _demoStayNames.length;
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Could not seed demo stays: ${error.code}',
        name: 'BusinessRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw const BusinessException('We could not create the demo stays.');
    }
  }

  Future<int> seedDemoServices() async {
    final ownerId = _authenticationDataSource.currentUser?.uid;
    if (ownerId == null) {
      throw const BusinessException(
        'You need to sign in before creating demo services.',
      );
    }

    String? firstBusinessId;
    try {
      for (var index = 0; index < _demoServices.length; index++) {
        final service = _demoServices[index];
        final businessId = _firestoreDataSource.createDocumentId(
          collection: _businessesCollection,
        );
        firstBusinessId ??= businessId;
        final imageUrl = _demoStayImageUrls[index % _demoStayImageUrls.length];
        final price = 25 + (index * 7);
        final duration = 30 + ((index % 3) * 15);
        final rating = 4.2 + ((index % 4) * 0.15);
        final city = service['city']!;
        final name = service['name']!;

        await _firestoreDataSource.setDocument(
          collection: _businessesCollection,
          documentId: businessId,
          data: {
            'id': businessId,
            'ownerId': ownerId,
            'type': BusinessType.services.name,
            'name': name,
            'nameLowercase': _normalizeSearchValue(name),
            'categoryId': service['categoryId'],
            'location': {
              'address': '${index + 1} Service Street, $city',
              'city': city,
              'cityLowercase': _normalizeSearchValue(city),
              'latitude': 43.8563 + (index * 0.0025),
              'longitude': 18.4131 + (index * 0.0025),
            },
            'shortDescription':
                'Book a convenient appointment with ${service['name']}.',
            'logoUrl': imageUrl,
            'coverPhotoUrl': imageUrl,
            'photoUrls': [imageUrl],
            'isActive': true,
            'averageRating': rating,
            'reviewCount': 28 + (index * 9),
            'stayDetails': null,
            'serviceDetails': {
              'offerings': [
                {
                  'id': 'primary-service',
                  'name': service['serviceName'],
                  'durationMinutes': duration,
                  'price': price,
                  'description': 'A bookable ${service['serviceName']}.',
                },
                {
                  'id': 'extended-service',
                  'name': '${service['serviceName']} – extended',
                  'durationMinutes': duration + 30,
                  'price': price + 20,
                  'description': 'A longer appointment with extra care.',
                },
              ],
              'availabilitySlots': [
                {
                  'id': 'weekday-morning',
                  'weekday': ServiceWeekday.monday.name,
                  'startMinutes': 540,
                  'endMinutes': 1020,
                },
                {
                  'id': 'weekday-morning-tuesday',
                  'weekday': ServiceWeekday.tuesday.name,
                  'startMinutes': 540,
                  'endMinutes': 1020,
                },
                {
                  'id': 'weekday-morning-wednesday',
                  'weekday': ServiceWeekday.wednesday.name,
                  'startMinutes': 540,
                  'endMinutes': 1020,
                },
                {
                  'id': 'weekday-morning-thursday',
                  'weekday': ServiceWeekday.thursday.name,
                  'startMinutes': 540,
                  'endMinutes': 1020,
                },
                {
                  'id': 'weekday-morning-friday',
                  'weekday': ServiceWeekday.friday.name,
                  'startMinutes': 540,
                  'endMinutes': 1020,
                },
              ],
              'provider': {
                'name': [
                  'Amina Hadzic',
                  'Lejla Kovacevic',
                  'Marko Jovic',
                  'Sara Begic',
                  'Emir Mujic',
                ][index % 5],
                'title': 'Service provider',
              },
              'providers': [
                {
                  'id': 'provider-primary',
                  'name': [
                    'Amina Hadzic',
                    'Lejla Kovacevic',
                    'Marko Jovic',
                    'Sara Begic',
                    'Emir Mujic',
                  ][index % 5],
                  'title': 'Service provider',
                  'availabilitySlots': [
                    {
                      'id': 'provider-primary-monday',
                      'weekday': ServiceWeekday.monday.name,
                      'startMinutes': 540,
                      'endMinutes': 1020,
                    },
                    {
                      'id': 'provider-primary-tuesday',
                      'weekday': ServiceWeekday.tuesday.name,
                      'startMinutes': 540,
                      'endMinutes': 1020,
                    },
                    {
                      'id': 'provider-primary-wednesday',
                      'weekday': ServiceWeekday.wednesday.name,
                      'startMinutes': 540,
                      'endMinutes': 1020,
                    },
                    {
                      'id': 'provider-primary-thursday',
                      'weekday': ServiceWeekday.thursday.name,
                      'startMinutes': 540,
                      'endMinutes': 1020,
                    },
                    {
                      'id': 'provider-primary-friday',
                      'weekday': ServiceWeekday.friday.name,
                      'startMinutes': 540,
                      'endMinutes': 1020,
                    },
                  ],
                },
                {
                  'id': 'provider-secondary',
                  'name': [
                    'Nina Basic',
                    'Tarik Memic',
                    'Mia Knezic',
                    'Haris Causevic',
                    'Ena Colic',
                  ][index % 5],
                  'title': 'Service provider',
                  'availabilitySlots': [
                    {
                      'id': 'provider-secondary-monday',
                      'weekday': ServiceWeekday.monday.name,
                      'startMinutes': 600,
                      'endMinutes': 1080,
                    },
                    {
                      'id': 'provider-secondary-tuesday',
                      'weekday': ServiceWeekday.tuesday.name,
                      'startMinutes': 600,
                      'endMinutes': 1080,
                    },
                    {
                      'id': 'provider-secondary-wednesday',
                      'weekday': ServiceWeekday.wednesday.name,
                      'startMinutes': 600,
                      'endMinutes': 1080,
                    },
                    {
                      'id': 'provider-secondary-thursday',
                      'weekday': ServiceWeekday.thursday.name,
                      'startMinutes': 600,
                      'endMinutes': 1080,
                    },
                    {
                      'id': 'provider-secondary-friday',
                      'weekday': ServiceWeekday.friday.name,
                      'startMinutes': 600,
                      'endMinutes': 1080,
                    },
                  ],
                },
              ],
            },
            'createdAt': _firestoreDataSource.serverTimestamp,
            'updatedAt': _firestoreDataSource.serverTimestamp,
          },
        );
      }
      if (firstBusinessId != null) {
        await _setSelectedBusiness(firstBusinessId);
      }
      log(
        'Created ${_demoServices.length} demo service businesses.',
        name: 'BusinessRepository',
      );
      return _demoServices.length;
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Could not seed demo services: ${error.code}',
        name: 'BusinessRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw const BusinessException(
        'We could not create the demo service businesses.',
      );
    }
  }

  Future<void> deleteBusiness(BusinessModel business) async {
    final ownerId = _authenticationDataSource.currentUser?.uid;
    if (ownerId == null || business.ownerId != ownerId) {
      throw const BusinessException(
        'You are not allowed to delete this business.',
      );
    }

    try {
      await _firestoreDataSource.deleteDocument(
        collection: _businessesCollection,
        documentId: business.id,
      );
      await _deleteBusinessImages(business);
      log('Business ${business.id} deleted.', name: 'BusinessRepository');
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Business deletion failed: ${error.code}',
        name: 'BusinessRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw const BusinessException(
        'We could not delete this business. Please try again.',
      );
    }
  }

  Future<BusinessModel> createBusiness({
    required BusinessType type,
    required String name,
    required String categoryId,
    required String city,
    required String address,
    required String shortDescription,
    required double? latitude,
    required double? longitude,
    int? pricePerNight,
    List<StayAmenity> amenities = const [],
    List<StayRoomModel> rooms = const [],
    List<StayExtraModel> extras = const [],
    List<ServiceOfferingModel> serviceOfferings = const [],
    List<ServiceAvailabilitySlotModel> availabilitySlots = const [],
    String? serviceProviderName,
    List<ServiceProviderModel> serviceProviders = const [],
    String? logoPath,
    String? coverPhotoPath,
  }) async {
    final ownerId = _authenticationDataSource.currentUser?.uid;
    if (ownerId == null) {
      throw const BusinessException(
        'You need to sign in before creating a business.',
      );
    }
    if (type == BusinessType.stays &&
        (pricePerNight == null || pricePerNight <= 0)) {
      throw const BusinessException('Please enter a valid price per night.');
    }
    if (type == BusinessType.services && serviceOfferings.isEmpty) {
      throw const BusinessException('Please add at least one service.');
    }
    if (type == BusinessType.services && serviceProviders.isEmpty) {
      throw const BusinessException(
        'Please add at least one service provider.',
      );
    }
    if (type == BusinessType.services &&
        serviceProviders.any(
          (provider) => provider.availabilitySlots.isEmpty,
        )) {
      throw const BusinessException(
        'Please add availability for every service provider.',
      );
    }
    if (latitude == null || longitude == null) {
      throw const BusinessException(
        'Please select your business location on the map.',
      );
    }

    final businessId = _firestoreDataSource.createDocumentId(
      collection: _businessesCollection,
    );
    final uploadedStoragePaths = <String>[];

    try {
      log('Creating business $businessId.', name: 'BusinessRepository');
      final logoUrl = await _uploadImage(
        ownerId: ownerId,
        businessId: businessId,
        imagePath: logoPath,
        fileName: 'logo',
        uploadedStoragePaths: uploadedStoragePaths,
      );
      final coverPhotoUrl = await _uploadImage(
        ownerId: ownerId,
        businessId: businessId,
        imagePath: coverPhotoPath,
        fileName: 'cover_photo',
        uploadedStoragePaths: uploadedStoragePaths,
      );
      final business = BusinessModel(
        id: businessId,
        ownerId: ownerId,
        type: type,
        name: name.trim(),
        categoryId: categoryId,
        location: BusinessLocationModel(
          city: city.trim(),
          address: address.trim(),
          latitude: latitude,
          longitude: longitude,
        ),
        shortDescription: shortDescription.trim().isEmpty
            ? null
            : shortDescription.trim(),
        logoUrl: logoUrl,
        coverPhotoUrl: coverPhotoUrl,
        stayDetails: type == BusinessType.stays
            ? StayDetailsModel(
                pricePerNight: pricePerNight,
                amenities: amenities,
                rooms: rooms,
                extras: extras,
              )
            : null,
        serviceDetails: type == BusinessType.services
            ? ServiceDetailsModel(
                offerings: serviceOfferings,
                availabilitySlots: availabilitySlots,
                provider: serviceProviders.first,
                providers: serviceProviders,
              )
            : null,
      );

      await _firestoreDataSource.setDocument(
        collection: _businessesCollection,
        documentId: businessId,
        data: {
          'id': business.id,
          'ownerId': business.ownerId,
          'type': business.type.name,
          'name': business.name,
          'nameLowercase': _normalizeSearchValue(business.name),
          'cityLowercase': _normalizeSearchValue(business.location.city),
          'stayPricePerNight': business.stayDetails?.pricePerNight,
          'maxGuestCapacity': business.stayDetails == null
              ? null
              : business.stayDetails!.rooms.isEmpty
              ? 99
              : business.stayDetails!.rooms
                    .map((room) => room.maxGuests)
                    .reduce((first, second) => first > second ? first : second),
          'categoryId': business.categoryId,
          'location': {
            'city': business.location.city,
            'cityLowercase': _normalizeSearchValue(business.location.city),
            'address': business.location.address,
            'latitude': business.location.latitude,
            'longitude': business.location.longitude,
          },
          'shortDescription': business.shortDescription,
          'logoUrl': business.logoUrl,
          'coverPhotoUrl': business.coverPhotoUrl,
          'photoUrls': business.photoUrls,
          'isActive': business.isActive,
          'averageRating': business.averageRating,
          'reviewCount': business.reviewCount,
          'stayDetails': business.stayDetails == null
              ? null
              : {
                  'pricePerNight': business.stayDetails!.pricePerNight,
                  'amenities': business.stayDetails!.amenities
                      .map((amenity) => amenity.name)
                      .toList(),
                  'rooms': business.stayDetails!.rooms
                      .map(
                        (room) => {
                          'id': room.id,
                          'name': room.name,
                          'maxGuests': room.maxGuests,
                          'sizeSquareMeters': room.sizeSquareMeters,
                          'pricePerNight': room.pricePerNight,
                          'quantity': room.quantity,
                        },
                      )
                      .toList(),
                  'extras': business.stayDetails!.extras
                      .map(
                        (extra) => {
                          'type': extra.type.name,
                          'price': extra.price,
                          'isPerNight': extra.isPerNight,
                        },
                      )
                      .toList(),
                },
          'serviceDetails': business.serviceDetails == null
              ? null
              : {
                  'offerings': business.serviceDetails!.offerings
                      .map(
                        (offering) => {
                          'id': offering.id,
                          'name': offering.name,
                          'durationMinutes': offering.durationMinutes,
                          'price': offering.price,
                          'description': offering.description,
                        },
                      )
                      .toList(),
                  'availabilitySlots': business
                      .serviceDetails!
                      .availabilitySlots
                      .map(
                        (slot) => {
                          'id': slot.id,
                          'weekday': slot.weekday.name,
                          'startMinutes': slot.startMinutes,
                          'endMinutes': slot.endMinutes,
                        },
                      )
                      .toList(),
                  'provider': business.serviceDetails!.provider == null
                      ? null
                      : {
                          'name': business.serviceDetails!.provider!.name,
                          'title': business.serviceDetails!.provider!.title,
                        },
                  'providers': business.serviceDetails!.providers
                      .map(
                        (provider) => {
                          'id': provider.id,
                          'name': provider.name,
                          'title': provider.title,
                          'availabilitySlots': provider.availabilitySlots
                              .map(
                                (slot) => {
                                  'id': slot.id,
                                  'weekday': slot.weekday.name,
                                  'startMinutes': slot.startMinutes,
                                  'endMinutes': slot.endMinutes,
                                },
                              )
                              .toList(),
                        },
                      )
                      .toList(),
                },
          'createdAt': _firestoreDataSource.serverTimestamp,
          'updatedAt': _firestoreDataSource.serverTimestamp,
        },
      );
      await _setSelectedBusiness(businessId);
      log('Business $businessId created.', name: 'BusinessRepository');

      return business;
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Firebase business creation failed: ${error.code}',
        name: 'BusinessRepository',
        error: error,
        stackTrace: stackTrace,
      );
      await _deleteUploadedImages(uploadedStoragePaths);
      throw const BusinessException(
        'We could not create your business. Please check your connection and try again.',
      );
    } on BusinessException {
      rethrow;
    } catch (error, stackTrace) {
      log(
        'Unexpected business creation failure.',
        name: 'BusinessRepository',
        error: error,
        stackTrace: stackTrace,
      );
      await _deleteUploadedImages(uploadedStoragePaths);
      throw const BusinessException(
        'We could not create your business. Please try again.',
      );
    }
  }

  BusinessModel _businessFromData(Map<String, dynamic> data) {
    final locationData = Map<String, dynamic>.from(
      data['location'] as Map<String, dynamic>,
    );
    final typeName = data['type'] as String?;
    final stayDetailsData = data['stayDetails'];
    final serviceDetailsData = data['serviceDetails'];
    final businessType = BusinessType.values.where(
      (type) => type.name == typeName,
    );

    return BusinessModel(
      id: data['id'] as String,
      ownerId: data['ownerId'] as String,
      type: businessType.isEmpty ? BusinessType.stays : businessType.first,
      name: data['name'] as String,
      categoryId: data['categoryId'] as String,
      location: BusinessLocationModel(
        city: locationData['city'] as String? ?? '',
        address: locationData['address'] as String,
        latitude: (locationData['latitude'] as num).toDouble(),
        longitude: (locationData['longitude'] as num).toDouble(),
      ),
      shortDescription: data['shortDescription'] as String?,
      logoUrl: data['logoUrl'] as String?,
      coverPhotoUrl: data['coverPhotoUrl'] as String?,
      photoUrls: List<String>.from(data['photoUrls'] as List? ?? const []),
      isActive: data['isActive'] as bool? ?? true,
      averageRating: (data['averageRating'] as num?)?.toDouble() ?? 0,
      reviewCount: (data['reviewCount'] as num?)?.toInt() ?? 0,
      stayDetails: stayDetailsData is Map
          ? StayDetailsModel(
              pricePerNight: (stayDetailsData['pricePerNight'] as num?)
                  ?.toInt(),
              amenities: (stayDetailsData['amenities'] as List? ?? const [])
                  .map(
                    (name) => StayAmenity.values.where(
                      (amenity) => amenity.name == name,
                    ),
                  )
                  .where((matches) => matches.isNotEmpty)
                  .map((matches) => matches.first)
                  .toList(),
              rooms: (stayDetailsData['rooms'] as List? ?? const [])
                  .whereType<Map>()
                  .map(
                    (room) => StayRoomModel(
                      id:
                          room['id'] as String? ??
                          room['name'] as String? ??
                          '',
                      name: room['name'] as String? ?? '',
                      maxGuests: (room['maxGuests'] as num?)?.toInt() ?? 1,
                      sizeSquareMeters:
                          (room['sizeSquareMeters'] as num?)?.toInt() ?? 0,
                      pricePerNight:
                          (room['pricePerNight'] as num?)?.toInt() ?? 0,
                      quantity: (room['quantity'] as num?)?.toInt() ?? 1,
                    ),
                  )
                  .toList(),
              extras: (stayDetailsData['extras'] as List? ?? const [])
                  .whereType<Map>()
                  .map((extra) {
                    final types = StayExtraType.values.where(
                      (type) => type.name == extra['type'],
                    );
                    if (types.isEmpty) return null;
                    return StayExtraModel(
                      type: types.first,
                      price: (extra['price'] as num?)?.toInt() ?? 0,
                      isPerNight: extra['isPerNight'] as bool? ?? false,
                    );
                  })
                  .whereType<StayExtraModel>()
                  .toList(),
            )
          : null,
      serviceDetails: serviceDetailsData is Map
          ? ServiceDetailsModel(
              offerings: (serviceDetailsData['offerings'] as List? ?? const [])
                  .whereType<Map>()
                  .map(
                    (offering) => ServiceOfferingModel(
                      id: offering['id'] as String? ?? '',
                      name: offering['name'] as String? ?? '',
                      durationMinutes:
                          (offering['durationMinutes'] as num?)?.toInt() ?? 0,
                      price: (offering['price'] as num?)?.toInt() ?? 0,
                      description: offering['description'] as String?,
                    ),
                  )
                  .toList(),
              availabilitySlots:
                  (serviceDetailsData['availabilitySlots'] as List? ?? const [])
                      .whereType<Map>()
                      .map((slot) {
                        final weekdays = ServiceWeekday.values.where(
                          (weekday) => weekday.name == slot['weekday'],
                        );
                        if (weekdays.isEmpty) return null;
                        return ServiceAvailabilitySlotModel(
                          id: slot['id'] as String? ?? '',
                          weekday: weekdays.first,
                          startMinutes:
                              (slot['startMinutes'] as num?)?.toInt() ?? 0,
                          endMinutes:
                              (slot['endMinutes'] as num?)?.toInt() ?? 0,
                        );
                      })
                      .whereType<ServiceAvailabilitySlotModel>()
                      .toList(),
              provider: serviceDetailsData['provider'] is Map
                  ? ServiceProviderModel(
                      id: 'legacy-provider',
                      name:
                          (serviceDetailsData['provider'] as Map)['name']
                              as String? ??
                          '',
                      title:
                          (serviceDetailsData['provider'] as Map)['title']
                              as String?,
                    )
                  : null,
              providers: (serviceDetailsData['providers'] as List? ?? const [])
                  .whereType<Map>()
                  .map(
                    (provider) => ServiceProviderModel(
                      id: provider['id'] as String? ?? '',
                      name: provider['name'] as String? ?? '',
                      title: provider['title'] as String?,
                      availabilitySlots:
                          (provider['availabilitySlots'] as List? ?? const [])
                              .whereType<Map>()
                              .map((slot) {
                                final weekdays = ServiceWeekday.values.where(
                                  (weekday) => weekday.name == slot['weekday'],
                                );
                                if (weekdays.isEmpty) return null;
                                return ServiceAvailabilitySlotModel(
                                  id: slot['id'] as String? ?? '',
                                  weekday: weekdays.first,
                                  startMinutes:
                                      (slot['startMinutes'] as num?)?.toInt() ??
                                      0,
                                  endMinutes:
                                      (slot['endMinutes'] as num?)?.toInt() ??
                                      0,
                                );
                              })
                              .whereType<ServiceAvailabilitySlotModel>()
                              .toList(),
                    ),
                  )
                  .toList(),
            )
          : null,
    );
  }

  BusinessModel deserializeBusiness(Map<String, dynamic> data) =>
      _businessFromData(data);

  Future<void> _setSelectedBusiness(String businessId) async {
    try {
      await _userRepository.setSelectedBusiness(businessId: businessId);
    } on FirebaseException catch (error, stackTrace) {
      log(
        'Business was created but could not be selected: ${error.code}',
        name: 'BusinessRepository',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  String _normalizeSearchValue(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll('č', 'c')
        .replaceAll('ć', 'c')
        .replaceAll('š', 's')
        .replaceAll('ž', 'z')
        .replaceAll(RegExp(r'[^a-z0-9 ]'), '')
        .replaceAll(RegExp(r'\s+'), ' ');
  }

  Future<String?> _uploadImage({
    required String ownerId,
    required String businessId,
    required String? imagePath,
    required String fileName,
    required List<String> uploadedStoragePaths,
  }) async {
    if (imagePath == null) {
      return null;
    }

    final compressedImageBytes = await compressImage(XFile(imagePath));
    final storagePath = 'businesses/$ownerId/$businessId/$fileName.webp';
    final imageUrl = await _storageDataSource.uploadImage(
      storagePath: storagePath,
      imageBytes: compressedImageBytes,
      contentType: 'image/webp',
    );
    uploadedStoragePaths.add(storagePath);
    return imageUrl;
  }

  Future<void> _deleteUploadedImages(List<String> storagePaths) async {
    for (final storagePath in storagePaths) {
      try {
        await _storageDataSource.deleteFile(storagePath: storagePath);
      } catch (error, stackTrace) {
        log(
          'Could not remove incomplete business image.',
          name: 'BusinessRepository',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
  }

  Future<void> _deleteBusinessImages(BusinessModel business) async {
    final imageUrls = [
      business.logoUrl,
      business.coverPhotoUrl,
      ...business.photoUrls,
    ].whereType<String>();

    for (final imageUrl in imageUrls) {
      try {
        await _storageDataSource.deleteFileByUrl(downloadUrl: imageUrl);
      } catch (error, stackTrace) {
        log(
          'Could not remove a deleted business image.',
          name: 'BusinessRepository',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
  }
}
