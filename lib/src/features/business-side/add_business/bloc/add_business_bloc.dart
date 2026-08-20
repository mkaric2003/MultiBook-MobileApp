import 'package:aquabook/src/data/data_sources/image_picker_data_source.dart';
import 'package:aquabook/src/data/enums/stay_extra_type.dart';
import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/features/business-side/add_business/bloc/add_business_event.dart';
import 'package:aquabook/src/features/business-side/add_business/bloc/add_business_state.dart';
import 'package:aquabook/src/features/business-side/add_business/domain/enums/business_image_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class AddBusinessBloc extends Bloc<AddBusinessEvent, AddBusinessState> {
  AddBusinessBloc(
    this._imagePickerDataSource,
    this._sharedPreferences,
    this._businessRepository,
  ) : super(const AddBusinessState()) {
    on<BusinessTypeChanged>(_onBusinessTypeChanged);
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
  final BusinessRepository _businessRepository;

  void _onBusinessTypeChanged(
    BusinessTypeChanged event,
    Emitter<AddBusinessState> emit,
  ) {
    emit(state.copyWith(businessType: event.type, categoryId: null));
  }

  void _onBusinessCategoryChanged(
    BusinessCategoryChanged event,
    Emitter<AddBusinessState> emit,
  ) {
    emit(state.copyWith(categoryId: event.categoryId));
  }

  void _onStayInventoryTypeChanged(
    StayInventoryTypeChanged event,
    Emitter<AddBusinessState> emit,
  ) => emit(state.copyWith(stayInventoryType: event.inventoryType));

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
    final location = await _businessRepository.resolveBusinessLocation(
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
    final hasBusinesses = await _businessRepository.hasBusinesses();
    emit(state.copyWith(hasExistingBusiness: hasBusinesses));
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
      await _businessRepository.createBusiness(
        type: state.businessType,
        name: event.name,
        categoryId: state.categoryId!,
        city: event.city,
        address: event.address,
        shortDescription: event.shortDescription,
        pricePerNight: event.pricePerNight,
        stayInventoryType: state.stayInventoryType,
        amenities: event.amenities,
        rooms: event.rooms,
        extras: event.extras,
        featuredCollectionIds: state.selectedCollectionIds,
        serviceOfferings: event.serviceOfferings,
        availabilitySlots: event.availabilitySlots,
        serviceProviderName: event.serviceProviderName,
        serviceProviders: event.serviceProviders,
        latitude: state.latitude,
        longitude: state.longitude,
        logoPath: state.logoPath,
        coverPhotoPath: state.coverPhotoPath,
        photoPaths: state.businessPhotoPaths,
      );
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          hasExistingBusiness: true,
        ),
      );
    } on BusinessException catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.message));
    }
  }

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
      final seededCount = await _businessRepository.seedDemoStays();
      emit(
        state.copyWith(
          isLoading: false,
          hasExistingBusiness: seededCount > 0 || state.hasExistingBusiness,
          successMessage: '$seededCount demo stays created.',
        ),
      );
    } on BusinessException catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.message));
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
      final seededCount = await _businessRepository.seedDemoServices();
      emit(
        state.copyWith(
          isLoading: false,
          hasExistingBusiness: seededCount > 0 || state.hasExistingBusiness,
          successMessage: '$seededCount demo service businesses created.',
        ),
      );
    } on BusinessException catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.message));
    }
  }
}
