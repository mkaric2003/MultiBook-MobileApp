import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/features/customer-side/bookings/bloc/customer_bookings_cubit.dart';
import 'package:multibook/src/features/customer-side/bookings/presentation/widgets/customer_bookings_body.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerBookingsView extends StatelessWidget {
  const CustomerBookingsView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<CustomerBookingsCubit>()..load(),
    child: const CustomerBookingsBody(),
  );
}
