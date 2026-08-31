import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/data/data_sources/customer_drafts_api_data_source.dart';
import 'package:multibook/src/data/models/appointment_draft_model.dart';
import 'package:multibook/src/data/models/booking_draft_model.dart';
import 'package:multibook/src/domain/repositories/customer_drafts_repository.dart';

@LazySingleton(as: CustomerDraftsRepository)
class CustomerDraftsRepositoryImpl implements CustomerDraftsRepository {
  CustomerDraftsRepositoryImpl(this._dataSource, this._executor);

  final CustomerDraftsApiDataSource _dataSource;
  final RestRepositoryExecutor _executor;

  @override
  Future<Result<BookingDraftModel?>> getBookingDraft() =>
      _executor.execute(_dataSource.getBookingDraft);

  @override
  Future<Result<BookingDraftModel>> saveBookingDraft(BookingDraftModel draft) =>
      _executor.execute(() => _dataSource.saveBookingDraft(draft));

  @override
  Future<Result<void>> deleteBookingDraft() =>
      _executor.execute(_dataSource.deleteBookingDraft);

  @override
  Future<Result<AppointmentDraftModel?>> getAppointmentDraft() =>
      _executor.execute(_dataSource.getAppointmentDraft);

  @override
  Future<Result<AppointmentDraftModel>> saveAppointmentDraft(
    AppointmentDraftModel draft,
  ) => _executor.execute(() => _dataSource.saveAppointmentDraft(draft));

  @override
  Future<Result<void>> deleteAppointmentDraft() =>
      _executor.execute(_dataSource.deleteAppointmentDraft);
}
