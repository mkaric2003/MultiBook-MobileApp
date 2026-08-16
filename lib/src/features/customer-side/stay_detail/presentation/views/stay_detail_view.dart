import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/cubit/stay_detail_cubit.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/cubit/stay_detail_state.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/presentation/widgets/amenities_section.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/presentation/widgets/available_rooms_section.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/presentation/widgets/stay_about_section.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/presentation/widgets/stay_booking_panel.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/presentation/widgets/stay_detail_hero.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/presentation/widgets/stay_guest_reviews_section.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/presentation/widgets/stay_location_section.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/presentation/widgets/stay_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
                child: Text(state.errorMessage ?? 'This stay is unavailable.'),
              ),
            );
          }

          final business = state.business!;
          final listing = StayListing.fromBusiness(business);
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StayDetailHero(stay: listing, onBack: () => context.pop()),
                    StayOverview(stay: listing),
                    const StayBookingPanel(),
                    AvailableRoomsSection(business: business),
                    AmenitiesSection(business: business),
                    StayAboutSection(business: business),
                    StayGuestReviewsSection(stay: listing),
                    StayLocationSection(stay: listing),
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
