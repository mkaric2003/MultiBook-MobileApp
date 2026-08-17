import 'package:aquabook/src/features/customer-side/bookings/bloc/customer_bookings_cubit.dart';
import 'package:aquabook/src/features/customer-side/bookings/bloc/customer_bookings_state.dart';
import 'package:aquabook/src/features/customer-side/bookings/domain/enums/customer_booking_type.dart';
import 'package:aquabook/src/features/customer-side/bookings/presentation/widgets/customer_bookings_header.dart';
import 'package:aquabook/src/features/customer-side/bookings/presentation/widgets/customer_bookings_list.dart';
import 'package:aquabook/src/features/customer-side/bookings/presentation/widgets/customer_bookings_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomerBookingsBody extends HookWidget {
  const CustomerBookingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    useEffect(() {
      void onScroll() {
        if (controller.position.extentAfter < 260) {
          context.read<CustomerBookingsCubit>().loadMore();
        }
      }

      controller.addListener(onScroll);
      return () => controller.removeListener(onScroll);
    }, [controller]);

    return BlocBuilder<CustomerBookingsCubit, CustomerBookingsState>(
      builder: (context, state) => SafeArea(
        child: Column(
          children: [
            const CustomerBookingsHeader(),
            CustomerBookingsTypeSelector(
              selectedType: state.selectedType,
              onChanged: context.read<CustomerBookingsCubit>().selectType,
            ),
            Expanded(
              child: state.selectedType == CustomerBookingType.stays
                  ? CustomerBookingsList(state: state, controller: controller)
                  : const Center(child: Text('Services bookings coming soon')),
            ),
          ],
        ),
      ),
    );
  }
}
