import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:multibook/src/features/customer-side/stay_detail/cubit/stay_detail_cubit.dart';
import 'package:multibook/src/features/customer-side/stay_detail/cubit/stay_detail_state.dart';
import 'package:multibook/src/features/customer-side/stay_detail/presentation/widgets/amenities_section.dart';
import 'package:multibook/src/features/customer-side/stay_detail/presentation/widgets/available_rooms_section.dart';
import 'package:multibook/src/features/customer-side/stay_detail/presentation/widgets/stay_about_section.dart';
import 'package:multibook/src/features/customer-side/stay_detail/presentation/widgets/stay_booking_panel.dart';
import 'package:multibook/src/features/customer-side/stay_detail/presentation/widgets/stay_detail_hero.dart';
import 'package:multibook/src/features/customer-side/stay_detail/presentation/widgets/stay_guest_reviews_section.dart';
import 'package:multibook/src/features/customer-side/stay_detail/presentation/widgets/stay_location_section.dart';
import 'package:multibook/src/features/customer-side/stay_detail/presentation/widgets/stay_overview.dart';
import 'package:multibook/src/features/shared/business_reviews/presentation/widgets/business_reviews_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class StayDetailView extends StatelessWidget {
  const StayDetailView({super.key, required this.stay});

  final StayListing stay;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<StayDetailCubit>()..loadStay(stay.id),
      child: BlocBuilder<StayDetailCubit, StayDetailState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.business == null) {
            return Scaffold(
              body: Center(
                child: Text(state.errorMessage ?? context.l10n.stayUnavailable),
              ),
            );
          }

          final business = state.business!;
          final listing = StayListing.fromBusiness(business);
          return Scaffold(
            backgroundColor: context.appPalette.background,
            body: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StayDetailHero(
                      stay: listing,
                      onBack: () => context.pop(),
                      isSaved: state.isSaved,
                      onSaved: () async {
                        final wasSaved = state.isSaved;
                        final changed = await context
                            .read<StayDetailCubit>()
                            .toggleSaved(listing);
                        if (context.mounted && changed) {
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
                    StayOverview(stay: listing),
                    StayBookingPanel(stay: listing),
                    AvailableRoomsSection(business: business, stay: listing),
                    AmenitiesSection(business: business),
                    StayAboutSection(business: business),
                    if (state.reviews.isNotEmpty)
                      StayGuestReviewsSection(
                        stay: listing,
                        reviews: state.reviews,
                        onViewAll: () async => showModalBottomSheet<void>(
                          context: context,
                          backgroundColor: context.appPalette.background,
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
                    StayLocationSection(business: business),
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
