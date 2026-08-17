import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/features/business-side/bookings/bloc/client_bookings_cubit.dart';
import 'package:aquabook/src/features/business-side/bookings/bloc/client_bookings_state.dart';
import 'package:aquabook/src/features/business-side/bookings/presentation/widgets/client_booking_filter_chips.dart';
import 'package:aquabook/src/features/business-side/bookings/presentation/widgets/client_bookings_header.dart';
import 'package:aquabook/src/features/business-side/bookings/presentation/widgets/client_bookings_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BookingsView extends HookWidget {
  const BookingsView({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = useMemoized(() => getIt<ClientBookingsCubit>());
    final scrollController = useScrollController();

    useEffect(() {
      void onScroll() {
        if (scrollController.position.extentAfter < 240) {
          cubit.loadMore();
        }
      }

      scrollController.addListener(onScroll);
      cubit.load();
      return () {
        scrollController.removeListener(onScroll);
        cubit.close();
      };
    }, [cubit, scrollController]);

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<ClientBookingsCubit, ClientBookingsState>(
        builder: (context, state) => SafeArea(
          bottom: false,
          child: Column(
            children: [
              ClientBookingsHeader(
                businesses: state.businesses,
                selectedBusiness: state.selectedBusiness,
                onBusinessSelected: cubit.selectBusiness,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 0, 16),
                child: ClientBookingFilterChips(
                  selected: state.filter,
                  onSelected: (filter) => cubit.load(filter: filter),
                ),
              ),
              Expanded(
                child: ClientBookingsList(
                  state: state,
                  controller: scrollController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
