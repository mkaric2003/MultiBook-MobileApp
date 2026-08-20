import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/data/enums/user_type.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/views/add_business_view.dart';
import 'package:aquabook/src/features/business-side/home/bloc/client_entry_cubit.dart';
import 'package:aquabook/src/features/business-side/home/bloc/client_entry_state.dart';
import 'package:aquabook/src/features/business-side/home/presentation/views/home_view.dart';
import 'package:aquabook/src/features/customer-side/home/presentation/views/customer_home_view.dart';
import 'package:aquabook/src/features/shared/user_location/presentation/widgets/user_location_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientEntryView extends StatelessWidget {
  const ClientEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ClientEntryCubit>()..load(),
      child: BlocBuilder<ClientEntryCubit, ClientEntryState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final entryView = state.userType == UserType.customer
              ? const CustomerHomeView()
              : state.hasExistingBusiness
              ? const HomeView()
              : const AddBusinessView();

          return UserLocationGate(user: state.user, child: entryView);
        },
      ),
    );
  }
}
