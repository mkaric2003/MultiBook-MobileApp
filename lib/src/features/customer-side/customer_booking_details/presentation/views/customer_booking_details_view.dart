import 'package:multibook/app.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/booking_status.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/features/customer-side/customer_booking_details/cubit/customer_booking_details_cubit.dart';
import 'package:multibook/src/features/customer-side/customer_booking_details/cubit/customer_booking_details_state.dart';
import 'package:multibook/src/features/customer-side/customer_booking_details/presentation/widgets/customer_booking_actions.dart';
import 'package:multibook/src/features/customer-side/customer_booking_details/presentation/widgets/customer_booking_business_card.dart';
import 'package:multibook/src/features/customer-side/customer_booking_details/presentation/widgets/customer_booking_information_card.dart';
import 'package:multibook/src/features/customer-side/customer_booking_details/presentation/widgets/customer_booking_price_card.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:multibook/src/features/shared/rate_business/domain/models/rate_business_target.dart';
import 'package:multibook/src/features/shared/rate_business/presentation/widgets/rate_business_sheet.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomerBookingDetailsView extends StatelessWidget {
  const CustomerBookingDetailsView({super.key, required this.booking});
  final BookingModel booking;
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) =>
        getIt<CustomerBookingDetailsCubit>(param1: booking)..loadReviewStatus(),
    child:
        BlocBuilder<CustomerBookingDetailsCubit, CustomerBookingDetailsState>(
          builder: (context, state) => Scaffold(
            backgroundColor: context.appPalette.background,
            body: SafeArea(
              child: Column(
                children: [
                  CustomAppBar(title: context.l10n.bookingDetails),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        children: [
                          CustomerBookingBusinessCard(booking: state.booking),
                          const SizedBox(height: 20),
                          CustomerBookingInformationCard(
                            booking: state.booking,
                          ),
                          const SizedBox(height: 20),
                          CustomerBookingPriceCard(booking: state.booking),
                          if (state.errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: Text(
                                state.errorMessage!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          const SizedBox(height: 28),
                          CustomerBookingActions(
                            booking: state.booking,
                            isCancelling: state.isCancelling,
                            hasSubmittedReview: state.hasSubmittedReview,
                            onCancel: () async {
                              final cubit = context
                                  .read<CustomerBookingDetailsCubit>();
                              await cubit.cancelBooking();
                              if (context.mounted &&
                                  cubit.state.booking.status ==
                                      BookingStatus.cancelled) {
                                context.pop(cubit.state.booking);
                              }
                            },
                            onLeaveReview: () async {
                              final submitted =
                                  await showModalBottomSheet<bool>(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor:
                                        context.appPalette.background,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(24),
                                      ),
                                    ),
                                    builder: (_) => RateBusinessSheet(
                                      target: RateBusinessTarget.stay(
                                        businessId: state.booking.businessId,
                                        sourceId: state.booking.id,
                                        businessName:
                                            state.booking.businessName,
                                      ),
                                    ),
                                  );
                              if (submitted == true && context.mounted) {
                                context
                                    .read<CustomerBookingDetailsCubit>()
                                    .markReviewSubmitted();
                              }
                            },
                            onBookAgain: () async => context.push(
                              AppRoutes.STAY_DETAIL,
                              extra: StayListing(
                                id: state.booking.businessId,
                                name: state.booking.businessName,
                                location: state.booking.businessCity,
                                rating: 0,
                                reviewCount: 0,
                                imageUrl: state.booking.businessImageUrl,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
  );
}
