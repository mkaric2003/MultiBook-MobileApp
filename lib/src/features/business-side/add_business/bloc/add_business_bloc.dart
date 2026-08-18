import 'package:aquabook/src/data/data_sources/image_picker_data_source.dart';
import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/features/business-side/add_business/bloc/add_business_event.dart';
import 'package:aquabook/src/features/business-side/add_business/bloc/add_business_state.dart';
import 'package:aquabook/src/features/business-side/add_business/domain/enums/business_image_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
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
    on<BusinessAmenityToggled>(_onBusinessAmenityToggled);
    on<BusinessExtraToggled>(_onBusinessExtraToggled);
    on<BusinessLocationChanged>(_onBusinessLocationChanged);
    on<BusinessImagePickRequested>(_onBusinessImagePickRequested);
    on<LostBusinessImageRestoreRequested>(_onLostBusinessImageRestoreRequested);
    on<ExistingBusinessesLoadRequested>(_onExistingBusinessesLoadRequested);
    on<DemoStaysSeedRequested>(_onDemoStaysSeedRequested);
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

  void _onBusinessExtraToggled(
    BusinessExtraToggled event,
    Emitter<AddBusinessState> emit,
  ) {
    final extras = [...state.selectedExtras];
    extras.contains(event.extra)
        ? extras.remove(event.extra)
        : extras.add(event.extra);
    emit(state.copyWith(selectedExtras: extras));
  }

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
    }
  }

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
        amenities: event.amenities,
        rooms: event.rooms,
        extras: event.extras,
        latitude: state.latitude,
        longitude: state.longitude,
        logoPath: state.logoPath,
        coverPhotoPath: state.coverPhotoPath,
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
}
