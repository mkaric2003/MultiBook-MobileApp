import 'package:aquabook/src/features/customer-side/home/bloc/customer_home_event.dart';
import 'package:aquabook/src/features/customer-side/home/bloc/customer_home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerHomeBloc extends Bloc<CustomerHomeEvent, CustomerHomeState> {
  CustomerHomeBloc() : super(const CustomerHomeState()) {
    on<CustomerTabChanged>(_onCustomerTabChanged);
  }

  void _onCustomerTabChanged(
    CustomerTabChanged event,
    Emitter<CustomerHomeState> emit,
  ) {
    emit(CustomerHomeState(currentTabIndex: event.index));
  }
}
