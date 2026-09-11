import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/use_cases/appointments/cancel_customer_appointment_use_case.dart';
import 'package:multibook/src/domain/use_cases/reviews/has_business_review_use_case.dart';
import 'package:multibook/src/domain/use_cases/customer_discovery/get_business_detail_use_case.dart';
import 'package:multibook/src/features/customer-side/appointment_details/cubit/appointment_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppointmentDetailsCubit extends Cubit<AppointmentDetailsState> {
  AppointmentDetailsCubit(
    this._getBusinessDetail,
    this._cancelCustomerAppointmentUseCase,
    this._hasBusinessReview,
  ) : super(const AppointmentDetailsState());

  final GetBusinessDetailUseCase _getBusinessDetail;
  final CancelCustomerAppointmentUseCase _cancelCustomerAppointmentUseCase;
  final HasBusinessReviewUseCase _hasBusinessReview;

  Future<void> load(String businessId) async {
    final result = await _getBusinessDetail.execute(businessId);
    if (result case Success<BusinessModel>(:final value)) {
      emit(AppointmentDetailsState(business: value));
    } else {
      emit(
        const AppointmentDetailsState(
          isLoading: false,
          errorMessage: 'We could not load current business details.',
        ),
      );
    }
  }

  Future<void> loadReviewStatus(AppointmentModel appointment) async {
    final result = await _hasBusinessReview.execute(appointment.businessId);
    if (result is Success<bool>) {
      emit(
        AppointmentDetailsState(
          isLoading: state.isLoading,
          business: state.business,
          appointment: state.appointment,
          isCancelling: state.isCancelling,
          hasSubmittedReview: result.value,
        ),
      );
    }
  }

  void markReviewSubmitted() => emit(
    AppointmentDetailsState(
      isLoading: state.isLoading,
      business: state.business,
      appointment: state.appointment,
      isCancelling: state.isCancelling,
      hasSubmittedReview: true,
    ),
  );

  Future<void> cancel(AppointmentModel appointment) async {
    if (state.isCancelling) return;
    emit(
      AppointmentDetailsState(
        isLoading: false,
        isCancelling: true,
        business: state.business,
      ),
    );
    final result = await _cancelCustomerAppointmentUseCase.execute(
      appointment.id,
    );
    if (result is Success<AppointmentModel>) {
      emit(
        AppointmentDetailsState(
          isLoading: false,
          business: state.business,
          appointment: result.value,
        ),
      );
      return;
    }
    emit(
      AppointmentDetailsState(
        isLoading: false,
        business: state.business,
        errorMessage: 'We could not cancel this appointment. Please try again.',
      ),
    );
  }
}
