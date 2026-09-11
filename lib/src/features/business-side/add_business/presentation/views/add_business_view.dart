import 'package:multibook/app.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/enums/stay_extra_type.dart';
import 'package:multibook/src/data/enums/stay_inventory_type.dart';
import 'package:multibook/src/data/models/stay_extra_model.dart';
import 'package:multibook/src/data/models/stay_room_model.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/features/business-side/add_business/bloc/add_business_bloc.dart';
import 'package:multibook/src/features/business-side/add_business/bloc/add_business_event.dart';
import 'package:multibook/src/features/business-side/add_business/bloc/add_business_state.dart';
import 'package:multibook/src/features/business-side/add_business/domain/enums/business_image_type.dart';
import 'package:multibook/src/features/business-side/add_business/domain/models/add_business_categories.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/amenities_selector.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/business_location_map.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/business_media/business_media_section.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/business_type_selector.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/form_field_label.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/image_source_picker_sheet.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/service_offerings_section.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/service_providers_section.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/stay_collections_selector.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/stay_extras_selector.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/stay_inventory_type_selector.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/stay_units_editor.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:multibook/src/global_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddBusinessView extends HookWidget {
  const AddBusinessView({this.editingBusiness, super.key});

  final BusinessModel? editingBusiness;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final cityController = useTextEditingController();
    final addressController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final priceController = useTextEditingController();
    useEffect(() {
      final business = editingBusiness;
      if (business == null) return null;
      nameController.text = business.name;
      cityController.text = business.location.city;
      addressController.text = business.location.address;
      descriptionController.text = business.shortDescription ?? '';
      final price = business.stayDetails?.pricePerNight;
      if (price != null) {
        priceController.text = (price / 100).toStringAsFixed(2);
      }
      return null;
    }, [editingBusiness?.id]);

    useListenable(nameController);
    useListenable(cityController);
    useListenable(addressController);
    useListenable(priceController);
    return BlocProvider(
      create: (_) {
        final bloc = getIt<AddBusinessBloc>();
        final business = editingBusiness;
        if (business != null) {
          bloc.add(BusinessEditFetchRequested(business.id));
        }
        return bloc;
      },
      child: BlocConsumer<AddBusinessBloc, AddBusinessState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage ||
            previous.successMessage != current.successMessage ||
            previous.isSuccess != current.isSuccess ||
            previous.editingBusiness != current.editingBusiness ||
            previous.resolvedCity != current.resolvedCity ||
            previous.resolvedAddress != current.resolvedAddress,
        listener: (context, state) {
          final business = state.editingBusiness;
          if (business != null) {
            nameController.text = business.name;
            cityController.text = business.location.city;
            addressController.text = business.location.address;
            descriptionController.text = business.shortDescription ?? '';
            final price = business.stayDetails?.pricePerNight;
            if (price != null) {
              priceController.text = (price / 100).toStringAsFixed(2);
            }
          }
          if (state.resolvedCity?.isNotEmpty ?? false) {
            cityController.text = state.resolvedCity!;
          }
          if (state.resolvedAddress?.isNotEmpty ?? false) {
            addressController.text = state.resolvedAddress!;
          }

          final message =
              state.errorMessage ??
              state.successMessage ??
              (state.isSuccess ? 'Business created successfully.' : null);
          if (message != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          }

          if (state.isSuccess) {
            context.go(AppRoutes.BUSINESS_HOME);
          }
        },
        builder: (context, state) {
          final categories = AddBusinessCategories.forType(state.businessType);
          int parsePrice(String value) =>
              ((double.tryParse(value.replaceAll(',', '.')) ?? 0) * 100)
                  .round();

          final canCreate =
              nameController.text.trim().isNotEmpty &&
              cityController.text.trim().isNotEmpty &&
              addressController.text.trim().isNotEmpty &&
              state.latitude != null &&
              state.longitude != null &&
              state.categoryId != null &&
              (state.businessType != BusinessType.stays ||
                  (state.stayInventoryType == StayInventoryType.singleUnit
                      ? parsePrice(priceController.text) > 0
                      : state.stayRooms.isNotEmpty &&
                            state.stayRooms.every(
                              (room) =>
                                  room.name.trim().isNotEmpty &&
                                  room.maxGuests > 0 &&
                                  room.sizeSquareMeters > 0 &&
                                  room.pricePerNight > 0 &&
                                  room.quantity > 0,
                            ))) &&
              (state.businessType != BusinessType.services ||
                  (state.serviceOfferings.isNotEmpty &&
                      state.serviceProviders.isNotEmpty &&
                      state.serviceProviders.every(
                        (provider) => provider.availabilitySlots.isNotEmpty,
                      ))) &&
              true;

          void selectImage(BusinessImageType imageType) {
            showModalBottomSheet<void>(
              context: context,
              backgroundColor: AppColors.surface,
              builder: (sheetContext) => ImageSourcePickerSheet(
                onSourceSelected: (ImageSource source) {
                  Navigator.of(sheetContext).pop();
                  context.read<AddBusinessBloc>().add(
                    BusinessImagePickRequested(
                      imageType: imageType,
                      source: source,
                    ),
                  );
                },
              ),
            );
          }

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  CustomAppBar(
                    title: state.isEditing
                        ? context.l10n.saveChanges
                        : state.isCheckingExistingBusiness
                        ? context.l10n.addBusiness
                        : state.hasExistingBusiness
                        ? context.l10n.addBusiness
                        : context.l10n.addYourFirstBusiness,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(25, 24, 25, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.addBusinessIntro,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: AppColors.muted,
                            ),
                          ),
                          const SizedBox(height: 30),
                          FormFieldLabel(context.l10n.businessType),
                          const SizedBox(height: 12),
                          IgnorePointer(
                            ignoring: state.isEditing,
                            child: Opacity(
                              opacity: state.isEditing ? 0.7 : 1,
                              child: BusinessTypeSelector(
                                selectedType: state.businessType,
                                onChanged: (type) => context
                                    .read<AddBusinessBloc>()
                                    .add(BusinessTypeChanged(type)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            state.businessType == BusinessType.stays
                                ? context.l10n.stayBusinessExamples
                                : context.l10n.serviceBusinessExamples,
                            style: const TextStyle(
                              color: AppColors.muted,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 28),
                          FormFieldLabel(context.l10n.businessNameRequired),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: context.l10n.enterBusinessName,
                            controller: nameController,
                          ),
                          const SizedBox(height: 26),
                          FormFieldLabel(context.l10n.businessCategoryRequired),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            key: ValueKey(state.businessType),
                            initialValue: state.categoryId,
                            dropdownColor: AppColors.surface,
                            iconEnabledColor: AppColors.muted,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            hint: Text(
                              context.l10n.selectCategory,
                              style: const TextStyle(color: AppColors.white),
                            ),
                            items: categories
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category.id,
                                    child: Text(
                                      context.l10n.businessCategoryName(
                                        category.id,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (categoryId) => context
                                .read<AddBusinessBloc>()
                                .add(BusinessCategoryChanged(categoryId)),
                          ),
                          const SizedBox(height: 26),
                          if (state.businessType == BusinessType.stays) ...[
                            FormFieldLabel(context.l10n.stayInventoryRequired),
                            const SizedBox(height: 10),
                            StayInventoryTypeSelector(
                              selectedType: state.stayInventoryType,
                              onChanged: (inventoryType) => context
                                  .read<AddBusinessBloc>()
                                  .add(StayInventoryTypeChanged(inventoryType)),
                            ),
                            const SizedBox(height: 26),
                            if (state.stayInventoryType ==
                                StayInventoryType.singleUnit) ...[
                              FormFieldLabel(
                                context.l10n.pricePerNightRequired,
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                hintText: context.l10n.enterPricePerNight,
                                controller: priceController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*([.,]\d{0,2})?$'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 26),
                            ],
                            FormFieldLabel(context.l10n.amenities),
                            const SizedBox(height: 10),
                            AmenitiesSelector(
                              selectedAmenities: state.selectedAmenities,
                              onChanged: (amenity) => context
                                  .read<AddBusinessBloc>()
                                  .add(BusinessAmenityToggled(amenity)),
                            ),
                            const SizedBox(height: 26),
                            FormFieldLabel(context.l10n.optionalExtras),
                            const SizedBox(height: 10),
                            StayExtrasSelector(
                              selectedExtras: state.selectedExtras,
                              extraPrices: state.extraPrices,
                              onChanged: (extra) => context
                                  .read<AddBusinessBloc>()
                                  .add(BusinessExtraToggled(extra)),
                              onPriceChanged: (extra, price) =>
                                  context.read<AddBusinessBloc>().add(
                                    BusinessExtraPriceChanged(
                                      extra: extra,
                                      price: price,
                                    ),
                                  ),
                            ),
                            const SizedBox(height: 26),
                            FormFieldLabel(context.l10n.featuredCollections),
                            const SizedBox(height: 10),
                            StayCollectionsSelector(
                              selectedCollectionIds:
                                  state.selectedCollectionIds,
                              onChanged: (collection) => context
                                  .read<AddBusinessBloc>()
                                  .add(StayCollectionToggled(collection)),
                            ),
                            const SizedBox(height: 28),
                            if (state.stayInventoryType ==
                                StayInventoryType.multipleUnits) ...[
                              FormFieldLabel(context.l10n.bookableUnits),
                              const SizedBox(height: 10),
                              StayUnitsEditor(
                                rooms: state.stayRooms,
                                onRoomChanged: (room) => context
                                    .read<AddBusinessBloc>()
                                    .add(StayRoomUpdated(room)),
                                onRoomRemoved: (roomId) => context
                                    .read<AddBusinessBloc>()
                                    .add(StayRoomRemoved(roomId)),
                                onRoomAdded: () =>
                                    context.read<AddBusinessBloc>().add(
                                      StayRoomAdded(
                                        StayRoomModel(
                                          id: 'room-${DateTime.now().microsecondsSinceEpoch}',
                                          name: '',
                                          maxGuests: 0,
                                          sizeSquareMeters: 0,
                                          pricePerNight: 0,
                                        ),
                                      ),
                                    ),
                              ),
                              const SizedBox(height: 28),
                            ],
                          ],
                          if (state.businessType == BusinessType.services) ...[
                            ServiceProvidersSection(
                              providers: state.serviceProviders,
                              onProviderAdded: (provider) => context
                                  .read<AddBusinessBloc>()
                                  .add(ServiceProviderAdded(provider)),
                              onProviderRemoved: (providerId) => context
                                  .read<AddBusinessBloc>()
                                  .add(ServiceProviderRemoved(providerId)),
                              onSlotAdded: (providerId, slot) =>
                                  context.read<AddBusinessBloc>().add(
                                    ServiceProviderAvailabilitySlotAdded(
                                      providerId: providerId,
                                      slot: slot,
                                    ),
                                  ),
                              onSlotRemoved: (providerId, slotId) =>
                                  context.read<AddBusinessBloc>().add(
                                    ServiceProviderAvailabilitySlotRemoved(
                                      providerId: providerId,
                                      slotId: slotId,
                                    ),
                                  ),
                            ),
                            const SizedBox(height: 28),
                            ServiceOfferingsSection(
                              offerings: state.serviceOfferings,
                              onOfferingAdded: (offering) => context
                                  .read<AddBusinessBloc>()
                                  .add(ServiceOfferingAdded(offering)),
                              onOfferingRemoved: (offeringId) => context
                                  .read<AddBusinessBloc>()
                                  .add(ServiceOfferingRemoved(offeringId)),
                            ),
                            const SizedBox(height: 28),
                          ],
                          FormFieldLabel(context.l10n.cityRequired),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: context.l10n.enterCity,
                            controller: cityController,
                          ),
                          const SizedBox(height: 26),
                          FormFieldLabel(context.l10n.addressRequired),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: context.l10n.enterBusinessAddress,
                            controller: addressController,
                          ),
                          const SizedBox(height: 10),
                          BusinessLocationMap(
                            latitude: state.latitude,
                            longitude: state.longitude,
                            onLocationSelected: (location) =>
                                context.read<AddBusinessBloc>().add(
                                  BusinessLocationChanged(
                                    latitude: location.latitude,
                                    longitude: location.longitude,
                                  ),
                                ),
                          ),
                          const SizedBox(height: 26),
                          FormFieldLabel(context.l10n.shortDescription),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: state.businessType == BusinessType.stays
                                ? context.l10n.describeYourBusiness
                                : context.l10n.describeYourBusinessServices,
                            controller: descriptionController,
                            maxLines: 4,
                          ),
                          const SizedBox(height: 30),
                          BusinessMediaSection(
                            businessType: state.businessType,
                            logoPath: state.logoPath,
                            coverPhotoPath: state.coverPhotoPath,
                            businessPhotoPaths: state.businessPhotoPaths,
                            onLogoTap: () =>
                                selectImage(BusinessImageType.logo),
                            onCoverPhotoTap: () =>
                                selectImage(BusinessImageType.coverPhoto),
                            onBusinessPhotosTap: () =>
                                selectImage(BusinessImageType.businessPhotos),
                            onBusinessPhotoRemoved: (imagePath) => context
                                .read<AddBusinessBloc>()
                                .add(BusinessPhotoRemoved(imagePath)),
                          ),
                          const SizedBox(height: 30),
                          if (!state.isEditing &&
                              state.businessType == BusinessType.stays) ...[
                            CustomButton(
                              buttonName: context.l10n.seedDemoStays,
                              color: AppColors.surface,
                              textColor: AppColors.primary,
                              borderColor: AppColors.primary,
                              onPressed: state.isLoading
                                  ? null
                                  : () => context.read<AddBusinessBloc>().add(
                                      const DemoStaysSeedRequested(),
                                    ),
                              enabled: !state.isLoading,
                            ),
                            const SizedBox(height: 14),
                          ],
                          if (!state.isEditing &&
                              state.businessType == BusinessType.services) ...[
                            CustomButton(
                              buttonName: context.l10n.seedDemoServices,
                              color: AppColors.surface,
                              textColor: AppColors.primary,
                              borderColor: AppColors.primary,
                              onPressed: state.isLoading
                                  ? null
                                  : () => context.read<AddBusinessBloc>().add(
                                      const DemoServicesSeedRequested(),
                                    ),
                              enabled: !state.isLoading,
                            ),
                            const SizedBox(height: 14),
                          ],
                          CustomButton(
                            buttonName: state.isEditing
                                ? context.l10n.saveChanges
                                : context.l10n.createBusiness,
                            onPressed: canCreate && !state.isLoading
                                ? () => context.read<AddBusinessBloc>().add(
                                    BusinessCreationRequested(
                                      name: nameController.text,
                                      city: cityController.text,
                                      address: addressController.text,
                                      shortDescription:
                                          descriptionController.text,
                                      pricePerNight:
                                          state.businessType ==
                                                  BusinessType.stays &&
                                              state.stayInventoryType ==
                                                  StayInventoryType.singleUnit
                                          ? parsePrice(priceController.text)
                                          : null,
                                      amenities: state.selectedAmenities,
                                      rooms:
                                          state.stayInventoryType ==
                                              StayInventoryType.multipleUnits
                                          ? state.stayRooms
                                          : const [],
                                      extras: state.selectedExtras
                                          .map(
                                            (extra) => StayExtraModel(
                                              type: extra,
                                              price:
                                                  state.extraPrices[extra
                                                      .name] ??
                                                  extra.defaultPrice,
                                              isPerNight: extra.isPerNight,
                                              isPerHour: extra.isPerHour,
                                            ),
                                          )
                                          .toList(),
                                      serviceOfferings: state.serviceOfferings,
                                      serviceProviders: state.serviceProviders,
                                    ),
                                  )
                                : null,
                            enabled: canCreate && !state.isLoading,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
