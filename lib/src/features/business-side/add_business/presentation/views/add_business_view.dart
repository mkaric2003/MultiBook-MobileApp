import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/business_type.dart';
import 'package:aquabook/src/data/enums/stay_extra_type.dart';
import 'package:aquabook/src/data/models/stay_extra_model.dart';
import 'package:aquabook/src/data/models/stay_room_model.dart';
import 'package:aquabook/src/features/business-side/add_business/bloc/add_business_bloc.dart';
import 'package:aquabook/src/features/business-side/add_business/bloc/add_business_event.dart';
import 'package:aquabook/src/features/business-side/add_business/bloc/add_business_state.dart';
import 'package:aquabook/src/features/business-side/add_business/domain/enums/business_image_type.dart';
import 'package:aquabook/src/features/business-side/add_business/domain/models/add_business_categories.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/amenities_selector.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/business_location_map.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/business_media/business_media_section.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/business_type_selector.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/form_field_label.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/image_source_picker_sheet.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/hotel_room_form.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/stay_extras_selector.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:aquabook/src/global_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddBusinessView extends HookWidget {
  const AddBusinessView({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final cityController = useTextEditingController();
    final addressController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final priceController = useTextEditingController();
    final roomNameController = useTextEditingController();
    final roomGuestsController = useTextEditingController();
    final roomSizeController = useTextEditingController();
    final roomPriceController = useTextEditingController();
    final roomQuantityController = useTextEditingController();

    useListenable(nameController);
    useListenable(cityController);
    useListenable(addressController);
    useListenable(priceController);
    useListenable(roomNameController);
    useListenable(roomGuestsController);
    useListenable(roomSizeController);
    useListenable(roomPriceController);
    useListenable(roomQuantityController);

    return BlocProvider(
      create: (_) => getIt<AddBusinessBloc>(),
      child: BlocConsumer<AddBusinessBloc, AddBusinessState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage ||
            previous.successMessage != current.successMessage ||
            previous.isSuccess != current.isSuccess ||
            previous.resolvedCity != current.resolvedCity ||
            previous.resolvedAddress != current.resolvedAddress,
        listener: (context, state) {
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
          final canCreate =
              nameController.text.trim().isNotEmpty &&
              cityController.text.trim().isNotEmpty &&
              addressController.text.trim().isNotEmpty &&
              state.latitude != null &&
              state.longitude != null &&
              state.categoryId != null &&
              (state.businessType != BusinessType.stays ||
                  (int.tryParse(priceController.text) ?? 0) > 0) &&
              (state.categoryId != 'hotel' ||
                  (roomNameController.text.trim().isNotEmpty &&
                      (int.tryParse(roomGuestsController.text) ?? 0) > 0 &&
                      (int.tryParse(roomSizeController.text) ?? 0) > 0 &&
                      (int.tryParse(roomPriceController.text) ?? 0) > 0 &&
                      (int.tryParse(roomQuantityController.text) ?? 0) > 0));

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
                    title: state.hasExistingBusiness
                        ? 'Add business'
                        : 'Add your first business',
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(25, 24, 25, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start by setting up your stays or services.',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: AppColors.muted,
                            ),
                          ),
                          const SizedBox(height: 30),
                          const FormFieldLabel('Business Type'),
                          const SizedBox(height: 12),
                          BusinessTypeSelector(
                            selectedType: state.businessType,
                            onChanged: (type) => context
                                .read<AddBusinessBloc>()
                                .add(BusinessTypeChanged(type)),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            state.businessType == BusinessType.stays
                                ? 'Hotels, apartments, cabins'
                                : 'Salons, clinics, professionals',
                            style: const TextStyle(
                              color: AppColors.muted,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 28),
                          const FormFieldLabel('Business name*'),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: 'Enter business name',
                            controller: nameController,
                          ),
                          const SizedBox(height: 26),
                          const FormFieldLabel('Business category*'),
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
                            hint: const Text(
                              'Select category',
                              style: TextStyle(color: AppColors.white),
                            ),
                            items: categories
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category.id,
                                    child: Text(category.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (categoryId) => context
                                .read<AddBusinessBloc>()
                                .add(BusinessCategoryChanged(categoryId)),
                          ),
                          const SizedBox(height: 26),
                          if (state.businessType == BusinessType.stays) ...[
                            const FormFieldLabel('Price per night*'),
                            const SizedBox(height: 10),
                            CustomTextField(
                              hintText: 'Enter price per night',
                              controller: priceController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                            const SizedBox(height: 26),
                            const FormFieldLabel('Amenities'),
                            const SizedBox(height: 10),
                            AmenitiesSelector(
                              selectedAmenities: state.selectedAmenities,
                              onChanged: (amenity) => context
                                  .read<AddBusinessBloc>()
                                  .add(BusinessAmenityToggled(amenity)),
                            ),
                            const SizedBox(height: 26),
                            const FormFieldLabel('Optional extras'),
                            const SizedBox(height: 10),
                            StayExtrasSelector(
                              selectedExtras: state.selectedExtras,
                              onChanged: (extra) => context
                                  .read<AddBusinessBloc>()
                                  .add(BusinessExtraToggled(extra)),
                            ),
                            const SizedBox(height: 28),
                            if (state.categoryId == 'hotel') ...[
                              const FormFieldLabel('Rooms'),
                              const SizedBox(height: 10),
                              HotelRoomForm(
                                nameController: roomNameController,
                                guestsController: roomGuestsController,
                                sizeController: roomSizeController,
                                priceController: roomPriceController,
                                quantityController: roomQuantityController,
                              ),
                              const SizedBox(height: 28),
                            ],
                          ],
                          const FormFieldLabel('City*'),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: 'Enter city',
                            controller: cityController,
                          ),
                          const SizedBox(height: 26),
                          const FormFieldLabel('Address*'),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: 'Enter business address',
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
                          const FormFieldLabel('Short description'),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: state.businessType == BusinessType.stays
                                ? 'Describe your business...'
                                : 'Describe your business services...',
                            controller: descriptionController,
                            maxLines: 4,
                          ),
                          const SizedBox(height: 30),
                          BusinessMediaSection(
                            businessType: state.businessType,
                            logoPath: state.logoPath,
                            coverPhotoPath: state.coverPhotoPath,
                            onLogoTap: () =>
                                selectImage(BusinessImageType.logo),
                            onCoverPhotoTap: () =>
                                selectImage(BusinessImageType.coverPhoto),
                          ),
                          const SizedBox(height: 30),
                          CustomButton(
                            buttonName: 'Seed 20 demo stays',
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
                          CustomButton(
                            buttonName: 'Create business',
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
                                              BusinessType.stays
                                          ? int.tryParse(priceController.text)
                                          : null,
                                      amenities: state.selectedAmenities,
                                      rooms: state.categoryId == 'hotel'
                                          ? [
                                              StayRoomModel(
                                                id: 'room-${DateTime.now().microsecondsSinceEpoch}',
                                                name: roomNameController.text
                                                    .trim(),
                                                maxGuests: int.parse(
                                                  roomGuestsController.text,
                                                ),
                                                sizeSquareMeters: int.parse(
                                                  roomSizeController.text,
                                                ),
                                                pricePerNight: int.parse(
                                                  roomPriceController.text,
                                                ),
                                                quantity: int.parse(
                                                  roomQuantityController.text,
                                                ),
                                              ),
                                            ]
                                          : const [],
                                      extras: state.selectedExtras
                                          .map(
                                            (extra) => StayExtraModel(
                                              type: extra,
                                              price: switch (extra) {
                                                StayExtraType.breakfast => 20,
                                                StayExtraType.parking => 15,
                                                StayExtraType.spaAccess => 40,
                                              },
                                              isPerNight:
                                                  extra !=
                                                  StayExtraType.spaAccess,
                                            ),
                                          )
                                          .toList(),
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
