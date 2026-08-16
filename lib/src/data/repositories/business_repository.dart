import 'dart:developer';

import 'package:aquabook/src/data/data_sources/authentication_data_source.dart';
import 'package:aquabook/src/data/data_cursor.dart';
import 'package:aquabook/src/data/data_sources/firebase_storage_data_source.dart';
import 'package:aquabook/src/data/data_sources/firestore_data_source.dart';
import 'package:aquabook/src/data/enums/business_type.dart';
import 'package:aquabook/src/data/models/business_location_model.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/data/models/stay_details_model.dart';
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

  final AuthenticationDataSource _authenticationDataSource;
  final FirestoreDataSource _firestoreDataSource;
  final FirebaseStorageDataSource _storageDataSource;
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

  DataCursor<BusinessModel> getStaysCursor({int pageSize = 6}) {
    return _firestoreDataSource.createCursorWhere<BusinessModel>(
      collection: _businessesCollection,
      field: 'type',
      value: BusinessType.stays.name,
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

        await _firestoreDataSource.setDocument(
          collection: _businessesCollection,
          documentId: businessId,
          data: {
            'id': businessId,
            'ownerId': ownerId,
            'type': BusinessType.stays.name,
            'name': _demoStayNames[index],
            'categoryId': ['hotel', 'apartment', 'cabin'][index % 3],
            'location': {
              'address': '${index + 1} Demo Street, Sarajevo',
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
            'stayDetails': {'pricePerNight': pricePerNight},
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
    required String address,
    required String shortDescription,
    int? pricePerNight,
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
          address: address.trim(),
          latitude: 0,
          longitude: 0,
        ),
        shortDescription: shortDescription.trim().isEmpty
            ? null
            : shortDescription.trim(),
        logoUrl: logoUrl,
        coverPhotoUrl: coverPhotoUrl,
        stayDetails: type == BusinessType.stays
            ? StayDetailsModel(pricePerNight: pricePerNight)
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
          'categoryId': business.categoryId,
          'location': {
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
              : {'pricePerNight': business.stayDetails!.pricePerNight},
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
            )
          : null,
    );
  }

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
