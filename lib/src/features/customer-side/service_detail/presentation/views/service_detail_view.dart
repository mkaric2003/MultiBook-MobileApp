import 'package:aquabook/app.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:aquabook/src/features/customer-side/create_appointment/domain/models/create_appointment_arguments.dart';
import 'package:aquabook/src/features/customer-side/service_detail/cubit/service_detail_cubit.dart';
import 'package:aquabook/src/features/customer-side/service_detail/cubit/service_detail_state.dart';
import 'package:aquabook/src/features/customer-side/service_detail/presentation/widgets/service_about_section.dart';
import 'package:aquabook/src/features/customer-side/service_detail/presentation/widgets/service_detail_hero.dart';
import 'package:aquabook/src/features/customer-side/service_detail/presentation/widgets/service_gallery_section.dart';
import 'package:aquabook/src/features/customer-side/service_detail/presentation/widgets/service_location_section.dart';
import 'package:aquabook/src/features/customer-side/service_detail/presentation/widgets/service_overview.dart';
import 'package:aquabook/src/features/customer-side/service_detail/presentation/widgets/service_reviews_section.dart';
import 'package:aquabook/src/features/customer-side/service_detail/presentation/widgets/services_offered_section.dart';
import 'package:aquabook/src/features/shared/business_reviews/presentation/widgets/business_reviews_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class ServiceDetailView extends StatelessWidget {
  const ServiceDetailView({required this.service, super.key});

  final ServiceListing service;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ServiceDetailCubit>()..loadService(service.id),
      child: BlocBuilder<ServiceDetailCubit, ServiceDetailState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.business == null) {
            return Scaffold(
              body: Center(
                child: Text(
                  state.errorMessage ?? context.l10n.serviceUnavailable,
                ),
              ),
            );
          }

          final business = state.business!;
          final listing = ServiceListing.fromBusiness(business);
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ServiceDetailHero(
                      service: listing,
                      onBack: () => context.pop(),
                      isSaved: state.isSaved,
                      onSaved: () async {
                        final wasSaved = state.isSaved;
                        await context.read<ServiceDetailCubit>().toggleSaved(
                          listing,
                        );
                        if (context.mounted) {
                          toastification.show(
                            context: context,
                            autoCloseDuration: const Duration(seconds: 2),
                            type: wasSaved
                                ? ToastificationType.warning
                                : ToastificationType.success,
                            alignment: Alignment.bottomCenter,
                            title: Text(
                              wasSaved
                                  ? context.l10n.removedFromSaved
                                  : context.l10n.addedToSaved,
                            ),
                          );
                        }
                      },
                    ),
                    ServiceOverview(business: business, service: listing),
                    ServicesOfferedSection(
                      business: business,
                      onBook: (offering) => context.push(
                        AppRoutes.CREATE_APPOINTMENT,
                        extra: CreateAppointmentArguments(
                          business: business,
                          initialOfferingId: offering.id,
                        ),
                      ),
                    ),
                    ServiceAboutSection(business: business),
                    ServiceGallerySection(business: business),
                    if (state.reviews.isNotEmpty)
                      ServiceReviewsSection(
                        service: listing,
                        reviews: state.reviews,
                        onViewAll: () async => showModalBottomSheet<void>(
                          context: context,
                          backgroundColor: AppColors.background,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          builder: (_) =>
                              BusinessReviewsSheet(businessId: business.id),
                        ),
                      ),
                    ServiceLocationSection(business: business),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
