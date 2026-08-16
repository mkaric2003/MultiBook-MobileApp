import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/business_type.dart';
import 'package:aquabook/src/features/business-side/add_business/bloc/add_business_bloc.dart';
import 'package:aquabook/src/features/business-side/add_business/bloc/add_business_event.dart';
import 'package:aquabook/src/features/business-side/add_business/bloc/add_business_state.dart';
import 'package:aquabook/src/features/business-side/add_business/domain/enums/business_image_type.dart';
import 'package:aquabook/src/features/business-side/add_business/domain/models/add_business_categories.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/business_location_placeholder.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/business_media/business_media_section.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/business_type_selector.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/form_field_label.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/image_source_picker_sheet.dart';
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
    final addressController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final priceController = useTextEditingController();

    useListenable(nameController);
    useListenable(addressController);
    useListenable(priceController);

    return BlocProvider(
      create: (_) => getIt<AddBusinessBloc>(),
      child: BlocConsumer<AddBusinessBloc, AddBusinessState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage ||
            previous.successMessage != current.successMessage ||
            previous.isSuccess != current.isSuccess,
        listener: (context, state) {
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
              addressController.text.trim().isNotEmpty &&
              state.categoryId != null &&
              (state.businessType != BusinessType.stays ||
                  (int.tryParse(priceController.text) ?? 0) > 0);

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
                          ],
                          const FormFieldLabel('Address*'),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: 'Enter business address',
                            controller: addressController,
                          ),
                          const SizedBox(height: 10),
                          const BusinessLocationPlaceholder(),
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
                                      address: addressController.text,
                                      shortDescription:
                                          descriptionController.text,
                                      pricePerNight:
                                          state.businessType ==
                                              BusinessType.stays
                                          ? int.tryParse(priceController.text)
                                          : null,
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
