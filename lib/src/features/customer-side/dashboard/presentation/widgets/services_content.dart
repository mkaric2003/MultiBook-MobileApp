import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/customer_section_title.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/other_services_grid.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/popular_services_list.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/promotion_banner.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/quick_filter_chips.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/continue_appointment_card.dart';
import 'package:aquabook/src/data/models/appointment_draft_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ServicesContent extends HookWidget {
  const ServicesContent({
    required this.popularServices,
    required this.isPopularServicesLoading,
    required this.otherServices,
    required this.isOtherServicesLoading,
    required this.hasMoreOtherServices,
    required this.isFiltering,
    required this.onLoadMoreServices,
    this.appointmentDraft,
    this.onContinueAppointment,
    super.key,
  });

  final List<ServiceListing> popularServices;
  final bool isPopularServicesLoading;
  final List<ServiceListing> otherServices;
  final bool isOtherServicesLoading;
  final bool hasMoreOtherServices;
  final bool isFiltering;
  final Future<void> Function() onLoadMoreServices;
  final AppointmentDraftModel? appointmentDraft;
  final VoidCallback? onContinueAppointment;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    useEffect(() {
      void loadMoreWhenNeeded() {
        if (!scrollController.hasClients || !hasMoreOtherServices) return;
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 300) {
          onLoadMoreServices();
        }
      }

      scrollController.addListener(loadMoreWhenNeeded);
      return () => scrollController.removeListener(loadMoreWhenNeeded);
    }, [scrollController, hasMoreOtherServices, onLoadMoreServices]);

    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isFiltering) ...[
            const CustomerSectionTitle(title: 'Search results'),
            const SizedBox(height: 14),
            OtherServicesGrid(
              services: otherServices,
              isLoading: isOtherServicesLoading || isPopularServicesLoading,
              emptyMessage: 'No services match your filters.',
            ),
          ] else ...[
            const QuickFilterChips(),
            const SizedBox(height: 28),
            const PromotionBanner(),
            const SizedBox(height: 28),
            if (appointmentDraft != null && onContinueAppointment != null) ...[
              const CustomerSectionTitle(title: 'Continue appointment'),
              const SizedBox(height: 14),
              ContinueAppointmentCard(
                draft: appointmentDraft!,
                onTap: onContinueAppointment!,
              ),
              const SizedBox(height: 28),
            ],
            const CustomerSectionTitle(title: 'Popular near you'),
            const SizedBox(height: 14),
            PopularServicesList(
              services: popularServices,
              isLoading: isPopularServicesLoading,
            ),
            const SizedBox(height: 28),
            OtherServicesGrid(
              services: otherServices,
              isLoading: isOtherServicesLoading,
            ),
          ],
        ],
      ),
    );
  }
}
