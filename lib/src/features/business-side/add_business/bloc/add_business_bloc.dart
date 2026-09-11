import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/authentication_data_source.dart';
import 'package:multibook/src/data/data_sources/firebase_storage_data_source.dart';
import 'package:multibook/src/data/data_sources/image_picker_data_source.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/enums/currency_code.dart';
import 'package:multibook/src/data/enums/stay_amenity.dart';
import 'package:multibook/src/data/enums/stay_extra_type.dart';
import 'package:multibook/src/data/enums/stay_inventory_type.dart';
import 'package:multibook/src/data/models/business_location_model.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/models/service_details_model.dart';
import 'package:multibook/src/data/models/service_provider_model.dart';
import 'package:multibook/src/data/models/stay_details_model.dart';
import 'package:multibook/src/data/models/stay_room_model.dart';
import 'package:multibook/src/domain/use_cases/businesses/resolve_business_location_use_case.dart';
import 'package:multibook/src/domain/use_cases/businesses/create_business_use_case.dart';
import 'package:multibook/src/domain/use_cases/businesses/get_owned_business_use_case.dart';
import 'package:multibook/src/domain/use_cases/businesses/get_owned_businesses_use_case.dart';
import 'package:multibook/src/domain/use_cases/businesses/update_business_use_case.dart';
import 'package:multibook/src/domain/use_cases/development_seed/development_seed_use_case.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/business-side/add_business/bloc/add_business_event.dart';
import 'package:multibook/src/features/business-side/add_business/bloc/add_business_state.dart';
import 'package:multibook/src/features/business-side/add_business/domain/enums/business_image_type.dart';
import 'package:multibook/utils/image_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class AddBusinessBloc extends Bloc<AddBusinessEvent, AddBusinessState> {
  AddBusinessBloc(
    this._imagePickerDataSource,
    this._sharedPreferences,
    this._resolveBusinessLocation,
    this._createBusinessUseCase,
    this._getOwnedBusinessesUseCase,
    this._getOwnedBusinessUseCase,
    this._updateBusinessUseCase,
    this._authenticationDataSource,
    this._storageDataSource,
    this._developmentSeedUseCase,
    this._userProfileUseCase,
  ) : super(const AddBusinessState()) {
    on<BusinessTypeChanged>(_onBusinessTypeChanged);
    on<BusinessEditLoaded>(_onBusinessEditLoaded);
    on<BusinessEditFetchRequested>(_onBusinessEditFetchRequested);
    on<StayRoomAdded>(_onStayRoomAdded);
    on<StayRoomRemoved>(_onStayRoomRemoved);
    on<StayRoomUpdated>(_onStayRoomUpdated);
    on<BusinessCategoryChanged>(_onBusinessCategoryChanged);
    on<StayInventoryTypeChanged>(_onStayInventoryTypeChanged);
    on<BusinessAmenityToggled>(_onBusinessAmenityToggled);
    on<StayCollectionToggled>(_onStayCollectionToggled);
    on<BusinessExtraToggled>(_onBusinessExtraToggled);
    on<BusinessExtraPriceChanged>(_onBusinessExtraPriceChanged);
    on<ServiceOfferingAdded>(_onServiceOfferingAdded);
    on<ServiceOfferingRemoved>(_onServiceOfferingRemoved);
    on<ServiceAvailabilitySlotAdded>(_onServiceAvailabilitySlotAdded);
    on<ServiceAvailabilitySlotRemoved>(_onServiceAvailabilitySlotRemoved);
    on<ServiceProviderAdded>(_onServiceProviderAdded);
    on<ServiceProviderRemoved>(_onServiceProviderRemoved);
    on<ServiceProviderAvailabilitySlotAdded>(
      _onServiceProviderAvailabilitySlotAdded,
    );
    on<ServiceProviderAvailabilitySlotRemoved>(
      _onServiceProviderAvailabilitySlotRemoved,
    );
    on<BusinessLocationChanged>(_onBusinessLocationChanged);
    on<BusinessImagePickRequested>(_onBusinessImagePickRequested);
    on<BusinessPhotoRemoved>(_onBusinessPhotoRemoved);
    on<LostBusinessImageRestoreRequested>(_onLostBusinessImageRestoreRequested);
    on<ExistingBusinessesLoadRequested>(_onExistingBusinessesLoadRequested);
    on<DemoStaysSeedRequested>(_onDemoStaysSeedRequested);
    on<DemoServicesSeedRequested>(_onDemoServicesSeedRequested);
    on<BusinessCreationRequested>(_onBusinessCreationRequested);

    add(const LostBusinessImageRestoreRequested());
    add(const ExistingBusinessesLoadRequested());
  }

  static const _pendingImageTypeKey = 'add_business_pending_image_type';

  final ImagePickerDataSource _imagePickerDataSource;
  final SharedPreferences _sharedPreferences;
  final ResolveBusinessLocationUseCase _resolveBusinessLocation;
  final CreateBusinessUseCase _createBusinessUseCase;
  final GetOwnedBusinessesUseCase _getOwnedBusinessesUseCase;
  final GetOwnedBusinessUseCase _getOwnedBusinessUseCase;
  final UpdateBusinessUseCase _updateBusinessUseCase;
  final AuthenticationDataSource _authenticationDataSource;
  final FirebaseStorageDataSource _storageDataSource;
  final DevelopmentSeedUseCase _developmentSeedUseCase;
  final UserProfileUseCase _userProfileUseCase;

  void _onBusinessTypeChanged(
    BusinessTypeChanged event,
    Emitter<AddBusinessState> emit,
  ) {
    emit(
      state.copyWith(
        businessType: event.type,
        categoryId: null,
        selectedCollectionIds: const [],
      ),
    );
  }

  void _onBusinessEditLoaded(
    BusinessEditLoaded event,
    Emitter<AddBusinessState> emit,
  ) {
    final business = event.business;
    final stayDetails = business.stayDetails;
    final serviceDetails = business.serviceDetails;
    final extras = stayDetails?.extras ?? const [];
    emit(
      state.copyWith(
        editingBusiness: business,
        businessType: business.type,
        categoryId: business.categoryId,
        stayInventoryType:
            stayDetails?.inventoryType ?? StayInventoryType.singleUnit,
        selectedAmenities: stayDetails?.amenities ?? const <StayAmenity>[],
        selectedCollectionIds: business.featuredCollectionIds,
        selectedExtras: extras.map((extra) => extra.type).toList(),
        extraPrices: {for (final extra in extras) extra.type.name: extra.price},
        stayRooms: stayDetails?.rooms ?? const [],
        serviceOfferings: serviceDetails?.offerings ?? const [],
        availabilitySlots: serviceDetails?.availabilitySlots ?? const [],
        serviceProviders: serviceDetails?.providers ?? const [],
        latitude: business.location.latitude,
        longitude: business.location.longitude,
        resolvedCity: business.location.city,
        resolvedAddress: business.location.address,
        logoPath: business.logoUrl,
        coverPhotoPath: business.coverPhotoUrl,
        businessPhotoPaths: business.photoUrls,
        hasExistingBusiness: true,
      ),
    );
  }

  Future<void> _onBusinessEditFetchRequested(
    BusinessEditFetchRequested event,
    Emitter<AddBusinessState> emit,
  ) async {
    final result = await _getOwnedBusinessUseCase.execute(event.businessId);
    switch (result) {
      case Success(value: final business):
        add(BusinessEditLoaded(business));
      case FailureResult(failure: final failure):
        emit(state.copyWith(errorMessage: _failureMessage(failure)));
    }
  }

  void _onStayRoomAdded(StayRoomAdded event, Emitter<AddBusinessState> emit) =>
      emit(state.copyWith(stayRooms: [...state.stayRooms, event.room]));

  void _onStayRoomRemoved(
    StayRoomRemoved event,
    Emitter<AddBusinessState> emit,
  ) => emit(
    state.copyWith(
      stayRooms: state.stayRooms
          .where((room) => room.id != event.roomId)
          .toList(),
    ),
  );

  void _onStayRoomUpdated(
    StayRoomUpdated event,
    Emitter<AddBusinessState> emit,
  ) => emit(
    state.copyWith(
      stayRooms: state.stayRooms
          .map((room) => room.id == event.room.id ? event.room : room)
          .toList(),
    ),
  );

  void _onBusinessCategoryChanged(
    BusinessCategoryChanged event,
    Emitter<AddBusinessState> emit,
  ) {
    emit(state.copyWith(categoryId: event.categoryId));
  }

  void _onStayInventoryTypeChanged(
    StayInventoryTypeChanged event,
    Emitter<AddBusinessState> emit,
  ) {
    final rooms =
        event.inventoryType == StayInventoryType.multipleUnits &&
            state.stayRooms.isEmpty
        ? [
            StayRoomModel(
              id: 'room-${DateTime.now().microsecondsSinceEpoch}',
              name: '',
              maxGuests: 0,
              sizeSquareMeters: 0,
              pricePerNight: 0,
            ),
          ]
        : state.stayRooms;
    emit(
      state.copyWith(stayInventoryType: event.inventoryType, stayRooms: rooms),
    );
  }

  void _onBusinessAmenityToggled(
    BusinessAmenityToggled event,
    Emitter<AddBusinessState> emit,
  ) {
    final amenities = [...state.selectedAmenities];
    if (amenities.contains(event.amenity)) {
      amenities.remove(event.amenity);
    } else {
      amenities.add(event.amenity);
    }
    emit(state.copyWith(selectedAmenities: amenities));
  }

  void _onStayCollectionToggled(
    StayCollectionToggled event,
    Emitter<AddBusinessState> emit,
  ) {
    final collectionIds = [...state.selectedCollectionIds];
    if (collectionIds.contains(event.collection.id)) {
      collectionIds.remove(event.collection.id);
    } else {
      collectionIds.add(event.collection.id);
    }
    emit(state.copyWith(selectedCollectionIds: collectionIds));
  }

  void _onBusinessExtraToggled(
    BusinessExtraToggled event,
    Emitter<AddBusinessState> emit,
  ) {
    final extras = [...state.selectedExtras];
    final prices = {...state.extraPrices};
    if (extras.contains(event.extra)) {
      extras.remove(event.extra);
      prices.remove(event.extra.name);
    } else {
      extras.add(event.extra);
      prices[event.extra.name] = event.extra.defaultPrice;
    }
    emit(state.copyWith(selectedExtras: extras, extraPrices: prices));
  }

  void _onBusinessExtraPriceChanged(
    BusinessExtraPriceChanged event,
    Emitter<AddBusinessState> emit,
  ) => emit(
    state.copyWith(
      extraPrices: {...state.extraPrices, event.extra.name: event.price},
    ),
  );

  void _onServiceOfferingAdded(
    ServiceOfferingAdded event,
    Emitter<AddBusinessState> emit,
  ) {
    emit(
      state.copyWith(
        serviceOfferings: [...state.serviceOfferings, event.offering],
      ),
    );
  }

  void _onServiceOfferingRemoved(
    ServiceOfferingRemoved event,
    Emitter<AddBusinessState> emit,
  ) {
    emit(
      state.copyWith(
        serviceOfferings: state.serviceOfferings
            .where((offering) => offering.id != event.offeringId)
            .toList(),
      ),
    );
  }

  void _onServiceAvailabilitySlotAdded(
    ServiceAvailabilitySlotAdded event,
    Emitter<AddBusinessState> emit,
  ) {
    emit(
      state.copyWith(
        availabilitySlots: [...state.availabilitySlots, event.slot],
      ),
    );
  }

  void _onServiceAvailabilitySlotRemoved(
    ServiceAvailabilitySlotRemoved event,
    Emitter<AddBusinessState> emit,
  ) {
    emit(
      state.copyWith(
        availabilitySlots: state.availabilitySlots
            .where((slot) => slot.id != event.slotId)
            .toList(),
      ),
    );
  }

  void _onServiceProviderAdded(
    ServiceProviderAdded event,
    Emitter<AddBusinessState> emit,
  ) => emit(
    state.copyWith(
      serviceProviders: [...state.serviceProviders, event.provider],
    ),
  );

  void _onServiceProviderRemoved(
    ServiceProviderRemoved event,
    Emitter<AddBusinessState> emit,
  ) => emit(
    state.copyWith(
      serviceProviders: state.serviceProviders
          .where((provider) => provider.id != event.providerId)
          .toList(),
    ),
  );

  void _onServiceProviderAvailabilitySlotAdded(
    ServiceProviderAvailabilitySlotAdded event,
    Emitter<AddBusinessState> emit,
  ) => emit(
    state.copyWith(
      serviceProviders: state.serviceProviders
          .map(
            (provider) => provider.id == event.providerId
                ? provider.copyWith(
                    availabilitySlots: [
                      ...provider.availabilitySlots,
                      event.slot,
                    ],
                  )
                : provider,
          )
          .toList(),
    ),
  );

  void _onServiceProviderAvailabilitySlotRemoved(
    ServiceProviderAvailabilitySlotRemoved event,
    Emitter<AddBusinessState> emit,
  ) => emit(
    state.copyWith(
      serviceProviders: state.serviceProviders
          .map(
            (provider) => provider.id == event.providerId
                ? provider.copyWith(
                    availabilitySlots: provider.availabilitySlots
                        .where((slot) => slot.id != event.slotId)
                        .toList(),
                  )
                : provider,
          )
          .toList(),
    ),
  );

  Future<void> _onBusinessLocationChanged(
    BusinessLocationChanged event,
    Emitter<AddBusinessState> emit,
  ) async {
    emit(
      state.copyWith(
        latitude: event.latitude,
        longitude: event.longitude,
        isResolvingLocation: true,
      ),
    );
    final location = await _resolveBusinessLocation.execute(
      latitude: event.latitude,
      longitude: event.longitude,
    );
    emit(
      state.copyWith(
        latitude: event.latitude,
        longitude: event.longitude,
        resolvedCity: location?.city,
        resolvedAddress: location?.address,
        isResolvingLocation: false,
      ),
    );
  }

  Future<void> _onBusinessImagePickRequested(
    BusinessImagePickRequested event,
    Emitter<AddBusinessState> emit,
  ) async {
    if (event.imageType == BusinessImageType.businessPhotos &&
        event.source == ImageSource.gallery) {
      final images = await _imagePickerDataSource.pickImages();
      final availableSlots = 7 - state.businessPhotoPaths.length;
      if (availableSlots <= 0 || images.isEmpty) return;
      emit(
        state.copyWith(
          businessPhotoPaths: [
            ...state.businessPhotoPaths,
            ...images.take(availableSlots).map((image) => image.path),
          ],
        ),
      );
      return;
    }

    await _sharedPreferences.setString(
      _pendingImageTypeKey,
      event.imageType.name,
    );
    final image = await _imagePickerDataSource.pickImage(source: event.source);
    await _sharedPreferences.remove(_pendingImageTypeKey);

    if (image == null) {
      return;
    }

    _emitSelectedImage(emit, event.imageType, image.path);
  }

  Future<void> _onLostBusinessImageRestoreRequested(
    LostBusinessImageRestoreRequested event,
    Emitter<AddBusinessState> emit,
  ) async {
    final imageTypeName = _sharedPreferences.getString(_pendingImageTypeKey);
    if (imageTypeName == null) {
      return;
    }

    final image = await _imagePickerDataSource.retrieveLostImage();
    await _sharedPreferences.remove(_pendingImageTypeKey);
    final imageType = BusinessImageType.values.where(
      (type) => type.name == imageTypeName,
    );

    if (image == null || imageType.isEmpty) {
      return;
    }

    _emitSelectedImage(emit, imageType.first, image.path);
  }

  void _emitSelectedImage(
    Emitter<AddBusinessState> emit,
    BusinessImageType imageType,
    String imagePath,
  ) {
    switch (imageType) {
      case BusinessImageType.logo:
        emit(state.copyWith(logoPath: imagePath));
        return;
      case BusinessImageType.coverPhoto:
        emit(state.copyWith(coverPhotoPath: imagePath));
        return;
      case BusinessImageType.businessPhotos:
        if (state.businessPhotoPaths.length >= 7) return;
        emit(
          state.copyWith(
            businessPhotoPaths: [...state.businessPhotoPaths, imagePath],
          ),
        );
        return;
    }
  }

  void _onBusinessPhotoRemoved(
    BusinessPhotoRemoved event,
    Emitter<AddBusinessState> emit,
  ) => emit(
    state.copyWith(
      businessPhotoPaths: state.businessPhotoPaths
          .where((path) => path != event.imagePath)
          .toList(),
    ),
  );

  Future<void> _onExistingBusinessesLoadRequested(
    ExistingBusinessesLoadRequested event,
    Emitter<AddBusinessState> emit,
  ) async {
    emit(state.copyWith(isCheckingExistingBusiness: true));
    final user = await _userProfileUseCase.getCurrentUser(forceRefresh: true);
    final selectedBusinessID = user?.selectedBusinessId;
    final hasBusinesses =
        selectedBusinessID != null &&
        (await _getOwnedBusinessUseCase.execute(selectedBusinessID))
            is Success<BusinessModel>;
    emit(
      state.copyWith(
        hasExistingBusiness: hasBusinesses,
        isCheckingExistingBusiness: false,
      ),
    );
  }

  Future<void> _onBusinessCreationRequested(
    BusinessCreationRequested event,
    Emitter<AddBusinessState> emit,
  ) async {
    if (state.isLoading || state.categoryId == null) {
      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
        errorMessage: null,
        successMessage: null,
      ),
    );
    try {
      final existingBusiness = state.editingBusiness;
      if (existingBusiness != null) {
        final updated = existingBusiness.copyWith(
          name: event.name.trim(),
          categoryId: state.categoryId!,
          shortDescription: event.shortDescription.trim().isEmpty
              ? null
              : event.shortDescription.trim(),
          location: existingBusiness.location.copyWith(
            city: event.city.trim(),
            address: event.address.trim(),
            latitude: state.latitude ?? existingBusiness.location.latitude,
            longitude: state.longitude ?? existingBusiness.location.longitude,
          ),
          featuredCollectionIds: state.selectedCollectionIds,
          stayDetails: existingBusiness.stayDetails?.copyWith(
            pricePerNight: event.pricePerNight,
            inventoryType: state.stayInventoryType,
            amenities: event.amenities,
            rooms: event.rooms,
            extras: event.extras,
          ),
          serviceDetails: existingBusiness.serviceDetails?.copyWith(
            offerings: event.serviceOfferings,
            providers: event.serviceProviders,
          ),
        );
        final result = await _updateBusinessUseCase.execute(updated);
        if (result case FailureResult(failure: final failure)) {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: _failureMessage(failure),
            ),
          );
          return;
        }
        _getOwnedBusinessesUseCase.invalidate();
      } else {
        if (_authenticationDataSource.currentUser == null ||
            state.latitude == null ||
            state.longitude == null) {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: 'Please select your business location on the map.',
            ),
          );
          return;
        }
        final business = await _buildNewBusiness(event);
        final result = await _createBusinessUseCase.execute(business);
        if (result case FailureResult(failure: final failure)) {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: _failureMessage(failure),
            ),
          );
          return;
        }
        _getOwnedBusinessesUseCase.invalidate();
      }
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          hasExistingBusiness: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'We could not create this business. Please try again.',
        ),
      );
    }
  }

  Future<BusinessModel> _buildNewBusiness(
    BusinessCreationRequested event,
  ) async {
    final ownerId = _authenticationDataSource.currentUser?.uid;
    if (ownerId == null || state.latitude == null || state.longitude == null) {
      throw StateError('Business location is required.');
    }
    final uploadKey = DateTime.now().microsecondsSinceEpoch.toString();
    final logoPath = await _uploadBusinessImage(
      ownerId,
      uploadKey,
      state.logoPath,
      'logo',
    );
    final coverPath = await _uploadBusinessImage(
      ownerId,
      uploadKey,
      state.coverPhotoPath,
      'cover',
    );
    final photos = <String>[];
    for (final entry in state.businessPhotoPaths.indexed) {
      final path = await _uploadBusinessImage(
        ownerId,
        uploadKey,
        entry.$2,
        'gallery_${entry.$1}',
      );
      if (path != null) photos.add(path);
    }
    final providers = event.serviceProviders.isNotEmpty
        ? event.serviceProviders
        : event.serviceProviderName == null
        ? const <ServiceProviderModel>[]
        : [
            ServiceProviderModel(
              id: 'provider-$uploadKey',
              name: event.serviceProviderName!,
            ),
          ];
    return BusinessModel(
      id: 'draft-$uploadKey',
      ownerId: ownerId,
      type: state.businessType,
      name: event.name.trim(),
      categoryId: state.categoryId!,
      location: BusinessLocationModel(
        city: event.city.trim(),
        address: event.address.trim(),
        latitude: state.latitude!,
        longitude: state.longitude!,
      ),
      currency: CurrencyCode.bam,
      shortDescription: event.shortDescription.trim().isEmpty
          ? null
          : event.shortDescription.trim(),
      logoUrl: logoPath,
      coverPhotoUrl: coverPath,
      photoUrls: photos,
      featuredCollectionIds: state.selectedCollectionIds,
      stayDetails: state.businessType == BusinessType.stays
          ? StayDetailsModel(
              pricePerNight: event.pricePerNight,
              inventoryType: state.stayInventoryType,
              amenities: event.amenities,
              rooms: event.rooms,
              extras: event.extras,
            )
          : null,
      serviceDetails: state.businessType == BusinessType.services
          ? ServiceDetailsModel(
              offerings: event.serviceOfferings,
              availabilitySlots: event.availabilitySlots,
              providers: providers,
            )
          : null,
    );
  }

  Future<String?> _uploadBusinessImage(
    String ownerId,
    String uploadKey,
    String? imagePath,
    String name,
  ) async {
    if (imagePath == null) return null;
    if (Uri.tryParse(imagePath)?.hasScheme == true) return imagePath;
    final storagePath = 'businesses/$ownerId/$uploadKey/$name.webp';
    await _storageDataSource.uploadImage(
      storagePath: storagePath,
      imageBytes: await compressImage(XFile(imagePath)),
      contentType: 'image/webp',
    );
    return storagePath;
  }

  String _failureMessage(AppFailure failure) => switch (failure) {
    ValidationFailure(message: final message) =>
      message ?? 'Please check the business details.',
    _ => 'We could not create this business. Please try again.',
  };

  Future<void> _onDemoStaysSeedRequested(
    DemoStaysSeedRequested event,
    Emitter<AddBusinessState> emit,
  ) async {
    if (state.isLoading) {
      return;
    }

    emit(
      state.copyWith(isLoading: true, errorMessage: null, successMessage: null),
    );
    try {
      final result = await _developmentSeedUseCase.seedStays();
      if (result case FailureResult(failure: final failure)) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: _failureMessage(failure),
          ),
        );
        return;
      }
      final seededCount = (result as Success<int>).value;
      _getOwnedBusinessesUseCase.invalidate();
      await _userProfileUseCase.getCurrentUser(forceRefresh: true);
      emit(
        state.copyWith(
          isLoading: false,
          hasExistingBusiness: seededCount > 0 || state.hasExistingBusiness,
          successMessage: '$seededCount demo stays created.',
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'We could not create this business. Please try again.',
        ),
      );
    }
  }

  Future<void> _onDemoServicesSeedRequested(
    DemoServicesSeedRequested event,
    Emitter<AddBusinessState> emit,
  ) async {
    if (state.isLoading) {
      return;
    }

    emit(
      state.copyWith(isLoading: true, errorMessage: null, successMessage: null),
    );
    try {
      final result = await _developmentSeedUseCase.seedServices();
      if (result case FailureResult(failure: final failure)) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: _failureMessage(failure),
          ),
        );
        return;
      }
      final seededCount = (result as Success<int>).value;
      _getOwnedBusinessesUseCase.invalidate();
      await _userProfileUseCase.getCurrentUser(forceRefresh: true);
      emit(
        state.copyWith(
          isLoading: false,
          hasExistingBusiness: seededCount > 0 || state.hasExistingBusiness,
          successMessage: '$seededCount demo service businesses created.',
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'We could not create this business. Please try again.',
        ),
      );
    }
  }
}
