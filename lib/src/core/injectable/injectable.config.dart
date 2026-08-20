// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:aquabook/src/core/modules/firebase_module.dart' as _i211;
import 'package:aquabook/src/core/modules/shared_preferences_module.dart'
    as _i144;
import 'package:aquabook/src/data/data_sources/authentication_data_source.dart'
    as _i137;
import 'package:aquabook/src/data/data_sources/chat_data_source.dart' as _i511;
import 'package:aquabook/src/data/data_sources/device_location_data_source.dart'
    as _i986;
import 'package:aquabook/src/data/data_sources/firebase_storage_data_source.dart'
    as _i83;
import 'package:aquabook/src/data/data_sources/firestore_data_source.dart'
    as _i151;
import 'package:aquabook/src/data/data_sources/image_picker_data_source.dart'
    as _i1069;
import 'package:aquabook/src/data/data_sources/in_app_notification_data_source.dart'
    as _i763;
import 'package:aquabook/src/data/data_sources/nominatim_data_source.dart'
    as _i377;
import 'package:aquabook/src/data/data_sources/notification_data_source.dart'
    as _i805;
import 'package:aquabook/src/data/data_sources/service_search_data_source.dart'
    as _i206;
import 'package:aquabook/src/data/data_sources/stay_search_data_source.dart'
    as _i873;
import 'package:aquabook/src/data/models/booking_model.dart' as _i405;
import 'package:aquabook/src/data/repositories/appointment_draft_repository.dart'
    as _i363;
import 'package:aquabook/src/data/repositories/appointment_repository.dart'
    as _i567;
import 'package:aquabook/src/data/repositories/authentication_repository.dart'
    as _i472;
import 'package:aquabook/src/data/repositories/booking_draft_repository.dart'
    as _i64;
import 'package:aquabook/src/data/repositories/booking_repository.dart'
    as _i961;
import 'package:aquabook/src/data/repositories/business_repository.dart'
    as _i1065;
import 'package:aquabook/src/data/repositories/chat_repository.dart' as _i525;
import 'package:aquabook/src/data/repositories/notification_repository.dart'
    as _i113;
import 'package:aquabook/src/data/repositories/onboarding_repository.dart'
    as _i366;
import 'package:aquabook/src/data/repositories/saved_business_repository.dart'
    as _i390;
import 'package:aquabook/src/data/repositories/service_availability_repository.dart'
    as _i1064;
import 'package:aquabook/src/data/repositories/service_search_repository.dart'
    as _i760;
import 'package:aquabook/src/data/repositories/stay_search_repository.dart'
    as _i285;
import 'package:aquabook/src/data/repositories/user_location_repository.dart'
    as _i417;
import 'package:aquabook/src/data/repositories/user_repository.dart' as _i747;
import 'package:aquabook/src/features/business-side/account_settings/bloc/account_settings_cubit.dart'
    as _i57;
import 'package:aquabook/src/features/business-side/add_business/bloc/add_business_bloc.dart'
    as _i458;
import 'package:aquabook/src/features/business-side/availability_calendar/bloc/availability_calendar_cubit.dart'
    as _i519;
import 'package:aquabook/src/features/business-side/bookings/bloc/client_bookings_cubit.dart'
    as _i488;
import 'package:aquabook/src/features/business-side/dashboard/bloc/dashboard_cubit.dart'
    as _i758;
import 'package:aquabook/src/features/business-side/home/bloc/client_entry_cubit.dart'
    as _i1018;
import 'package:aquabook/src/features/business-side/home/bloc/home_bloc.dart'
    as _i952;
import 'package:aquabook/src/features/business-side/more/bloc/more_cubit.dart'
    as _i556;
import 'package:aquabook/src/features/business-side/my_businesses/bloc/my_businesses_cubit.dart'
    as _i908;
import 'package:aquabook/src/features/customer-side/appointment_details/cubit/appointment_details_cubit.dart'
    as _i270;
import 'package:aquabook/src/features/customer-side/appointment_payment/cubit/appointment_payment_cubit.dart'
    as _i167;
import 'package:aquabook/src/features/customer-side/booking_details/bloc/booking_details_cubit.dart'
    as _i259;
import 'package:aquabook/src/features/customer-side/bookings/bloc/customer_bookings_cubit.dart'
    as _i274;
import 'package:aquabook/src/features/customer-side/create_appointment/cubit/appointment_availability_cubit.dart'
    as _i492;
import 'package:aquabook/src/features/customer-side/create_appointment/cubit/appointment_draft_cubit.dart'
    as _i451;
import 'package:aquabook/src/features/customer-side/customer_booking_details/cubit/customer_booking_details_cubit.dart'
    as _i690;
import 'package:aquabook/src/features/customer-side/dashboard/bloc/customer_dashboard_cubit.dart'
    as _i567;
import 'package:aquabook/src/features/customer-side/payment/cubit/payment_cubit.dart'
    as _i415;
import 'package:aquabook/src/features/customer-side/profile/cubit/customer_profile_cubit.dart'
    as _i897;
import 'package:aquabook/src/features/customer-side/reschedule_appointment/cubit/reschedule_appointment_cubit.dart'
    as _i569;
import 'package:aquabook/src/features/customer-side/review_stay/cubit/review_stay_cubit.dart'
    as _i192;
import 'package:aquabook/src/features/customer-side/saved/cubit/saved_cubit.dart'
    as _i551;
import 'package:aquabook/src/features/customer-side/search/cubit/customer_search_cubit.dart'
    as _i940;
import 'package:aquabook/src/features/customer-side/service_detail/cubit/service_detail_cubit.dart'
    as _i390;
import 'package:aquabook/src/features/customer-side/stay_detail/cubit/stay_detail_cubit.dart'
    as _i386;
import 'package:aquabook/src/features/shared/chat/cubit/chat_conversation_cubit.dart'
    as _i1047;
import 'package:aquabook/src/features/shared/chat/cubit/chat_list_cubit.dart'
    as _i409;
import 'package:aquabook/src/features/shared/notifications/cubit/notifications_cubit.dart'
    as _i600;
import 'package:aquabook/src/features/shared/onboarding/cubit/onboarding_cubit.dart'
    as _i680;
import 'package:aquabook/src/features/shared/sign_in/cubit/signin_cubit.dart'
    as _i44;
import 'package:aquabook/src/features/shared/sign_up/cubit/signup_cubit.dart'
    as _i1028;
import 'package:aquabook/src/features/shared/user_location/cubit/user_location_cubit.dart'
    as _i104;
import 'package:aquabook/src/features/shared/user_type_checker/cubit/user_type_checker_cubit.dart'
    as _i30;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:cloud_functions/cloud_functions.dart' as _i809;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    final sharedPrefsModule = _$SharedPrefsModule();
    await gh.singletonAsync<_i982.FirebaseApp>(
      () => firebaseModule.firebaseApp,
      preResolve: true,
    );
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPrefsModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i377.NominatimDataSource>(
      () => _i377.NominatimDataSourceImpl(),
    );
    gh.lazySingleton<_i1069.ImagePickerDataSource>(
      () => _i1069.ImagePickerDataSourceImpl(),
    );
    gh.lazySingleton<_i986.DeviceLocationDataSource>(
      () => _i986.DeviceLocationDataSourceImpl(),
    );
    gh.lazySingleton<_i366.OnboardingRepository>(
      () => _i366.OnboardingRepository(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i59.FirebaseAuth>(
      () => firebaseModule.firebaseAuth(gh<_i982.FirebaseApp>()),
    );
    gh.singleton<_i457.FirebaseStorage>(
      () => firebaseModule.firebaseStorage(gh<_i982.FirebaseApp>()),
    );
    gh.singleton<_i974.FirebaseFirestore>(
      () => firebaseModule.firebaseFirestore(gh<_i982.FirebaseApp>()),
    );
    gh.singleton<_i892.FirebaseMessaging>(
      () => firebaseModule.firebaseMessaging(gh<_i982.FirebaseApp>()),
    );
    gh.singleton<_i809.FirebaseFunctions>(
      () => firebaseModule.firebaseFunctions(gh<_i982.FirebaseApp>()),
    );
    gh.factory<_i680.OnboardingCubit>(
      () => _i680.OnboardingCubit(gh<_i366.OnboardingRepository>()),
    );
    gh.lazySingleton<_i206.ServiceSearchDataSource>(
      () => _i206.ServiceSearchDataSourceImpl(gh<_i809.FirebaseFunctions>()),
    );
    gh.lazySingleton<_i511.ChatDataSource>(
      () => _i511.ChatDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i151.FirestoreDataSource>(
      () => _i151.FirestoreDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i805.NotificationDataSource>(
      () => _i805.NotificationDataSourceImpl(gh<_i892.FirebaseMessaging>()),
    );
    gh.lazySingleton<_i83.FirebaseStorageDataSource>(
      () => _i83.FirebaseStorageDataSourceImpl(gh<_i457.FirebaseStorage>()),
    );
    gh.lazySingleton<_i873.StaySearchDataSource>(
      () => _i873.StaySearchDataSourceImpl(gh<_i809.FirebaseFunctions>()),
    );
    gh.lazySingleton<_i137.AuthenticationDataSource>(
      () => _i137.AuthenticationDataSourceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i525.ChatRepository>(
      () => _i525.ChatRepository(
        gh<_i137.AuthenticationDataSource>(),
        gh<_i511.ChatDataSource>(),
      ),
    );
    gh.lazySingleton<_i763.InAppNotificationDataSource>(
      () =>
          _i763.InAppNotificationDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i747.UserRepository>(
      () => _i747.UserRepository(
        gh<_i137.AuthenticationDataSource>(),
        gh<_i151.FirestoreDataSource>(),
        gh<_i83.FirebaseStorageDataSource>(),
      ),
    );
    gh.lazySingleton<_i1065.BusinessRepository>(
      () => _i1065.BusinessRepository(
        gh<_i137.AuthenticationDataSource>(),
        gh<_i151.FirestoreDataSource>(),
        gh<_i83.FirebaseStorageDataSource>(),
        gh<_i377.NominatimDataSource>(),
        gh<_i747.UserRepository>(),
      ),
    );
    gh.factory<_i940.CustomerSearchCubit>(
      () => _i940.CustomerSearchCubit(gh<_i1065.BusinessRepository>()),
    );
    gh.factory<_i30.UserTypeCheckerCubit>(
      () => _i30.UserTypeCheckerCubit(gh<_i747.UserRepository>()),
    );
    gh.factory<_i1018.ClientEntryCubit>(
      () => _i1018.ClientEntryCubit(
        gh<_i1065.BusinessRepository>(),
        gh<_i747.UserRepository>(),
      ),
    );
    gh.factory<_i908.MyBusinessesCubit>(
      () => _i908.MyBusinessesCubit(
        gh<_i1065.BusinessRepository>(),
        gh<_i747.UserRepository>(),
      ),
    );
    gh.lazySingleton<_i417.UserLocationRepository>(
      () => _i417.UserLocationRepository(
        gh<_i986.DeviceLocationDataSource>(),
        gh<_i377.NominatimDataSource>(),
        gh<_i747.UserRepository>(),
      ),
    );
    gh.factory<_i409.ChatListCubit>(
      () => _i409.ChatListCubit(gh<_i525.ChatRepository>()),
    );
    gh.lazySingleton<_i113.NotificationRepository>(
      () => _i113.NotificationRepository(
        gh<_i137.AuthenticationDataSource>(),
        gh<_i151.FirestoreDataSource>(),
        gh<_i805.NotificationDataSource>(),
        gh<_i763.InAppNotificationDataSource>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i961.BookingRepository>(
      () => _i961.BookingRepository(
        gh<_i137.AuthenticationDataSource>(),
        gh<_i151.FirestoreDataSource>(),
        gh<_i1065.BusinessRepository>(),
      ),
    );
    gh.factory<_i57.AccountSettingsCubit>(
      () => _i57.AccountSettingsCubit(
        gh<_i747.UserRepository>(),
        gh<_i1069.ImagePickerDataSource>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i458.AddBusinessBloc>(
      () => _i458.AddBusinessBloc(
        gh<_i1069.ImagePickerDataSource>(),
        gh<_i460.SharedPreferences>(),
        gh<_i1065.BusinessRepository>(),
      ),
    );
    gh.lazySingleton<_i760.ServiceSearchRepository>(
      () => _i760.ServiceSearchRepository(
        gh<_i206.ServiceSearchDataSource>(),
        gh<_i1065.BusinessRepository>(),
      ),
    );
    gh.factory<_i1047.ChatConversationCubit>(
      () => _i1047.ChatConversationCubit(
        gh<_i525.ChatRepository>(),
        gh<_i747.UserRepository>(),
      ),
    );
    gh.lazySingleton<_i363.AppointmentDraftRepository>(
      () => _i363.AppointmentDraftRepository(
        gh<_i137.AuthenticationDataSource>(),
        gh<_i151.FirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i390.SavedBusinessRepository>(
      () => _i390.SavedBusinessRepository(
        gh<_i137.AuthenticationDataSource>(),
        gh<_i151.FirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i64.BookingDraftRepository>(
      () => _i64.BookingDraftRepository(
        gh<_i137.AuthenticationDataSource>(),
        gh<_i151.FirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i1064.ServiceAvailabilityRepository>(
      () => _i1064.ServiceAvailabilityRepository(
        gh<_i137.AuthenticationDataSource>(),
        gh<_i151.FirestoreDataSource>(),
      ),
    );
    gh.factoryParam<
      _i690.CustomerBookingDetailsCubit,
      _i405.BookingModel,
      dynamic
    >(
      (booking, _) => _i690.CustomerBookingDetailsCubit(
        gh<_i961.BookingRepository>(),
        booking,
      ),
    );
    gh.factory<_i556.MoreCubit>(
      () => _i556.MoreCubit(
        gh<_i1065.BusinessRepository>(),
        gh<_i747.UserRepository>(),
        gh<_i525.ChatRepository>(),
      ),
    );
    gh.factory<_i451.AppointmentDraftCubit>(
      () => _i451.AppointmentDraftCubit(gh<_i363.AppointmentDraftRepository>()),
    );
    gh.factory<_i600.NotificationsCubit>(
      () => _i600.NotificationsCubit(gh<_i113.NotificationRepository>()),
    );
    gh.factory<_i758.DashboardCubit>(
      () => _i758.DashboardCubit(
        gh<_i747.UserRepository>(),
        gh<_i1065.BusinessRepository>(),
      ),
    );
    gh.lazySingleton<_i285.StaySearchRepository>(
      () => _i285.StaySearchRepository(
        gh<_i873.StaySearchDataSource>(),
        gh<_i1065.BusinessRepository>(),
      ),
    );
    gh.factory<_i192.ReviewStayCubit>(
      () => _i192.ReviewStayCubit(
        gh<_i1065.BusinessRepository>(),
        gh<_i64.BookingDraftRepository>(),
      ),
    );
    gh.factory<_i104.UserLocationCubit>(
      () => _i104.UserLocationCubit(gh<_i417.UserLocationRepository>()),
    );
    gh.lazySingleton<_i567.AppointmentRepository>(
      () => _i567.AppointmentRepository(
        gh<_i137.AuthenticationDataSource>(),
        gh<_i151.FirestoreDataSource>(),
        gh<_i1065.BusinessRepository>(),
        gh<_i1064.ServiceAvailabilityRepository>(),
      ),
    );
    gh.factory<_i567.CustomerDashboardCubit>(
      () => _i567.CustomerDashboardCubit(
        gh<_i1065.BusinessRepository>(),
        gh<_i285.StaySearchRepository>(),
        gh<_i760.ServiceSearchRepository>(),
        gh<_i64.BookingDraftRepository>(),
        gh<_i363.AppointmentDraftRepository>(),
        gh<_i747.UserRepository>(),
        gh<_i417.UserLocationRepository>(),
      ),
    );
    gh.factory<_i270.AppointmentDetailsCubit>(
      () => _i270.AppointmentDetailsCubit(
        gh<_i1065.BusinessRepository>(),
        gh<_i567.AppointmentRepository>(),
      ),
    );
    gh.factory<_i488.ClientBookingsCubit>(
      () => _i488.ClientBookingsCubit(
        gh<_i961.BookingRepository>(),
        gh<_i567.AppointmentRepository>(),
        gh<_i1065.BusinessRepository>(),
        gh<_i747.UserRepository>(),
      ),
    );
    gh.factory<_i551.SavedCubit>(
      () => _i551.SavedCubit(gh<_i390.SavedBusinessRepository>()),
    );
    gh.factory<_i519.AvailabilityCalendarCubit>(
      () => _i519.AvailabilityCalendarCubit(
        gh<_i961.BookingRepository>(),
        gh<_i1065.BusinessRepository>(),
        gh<_i747.UserRepository>(),
      ),
    );
    gh.factory<_i274.CustomerBookingsCubit>(
      () => _i274.CustomerBookingsCubit(
        gh<_i961.BookingRepository>(),
        gh<_i567.AppointmentRepository>(),
      ),
    );
    gh.factory<_i569.RescheduleAppointmentCubit>(
      () => _i569.RescheduleAppointmentCubit(gh<_i567.AppointmentRepository>()),
    );
    gh.factory<_i415.PaymentCubit>(
      () => _i415.PaymentCubit(
        gh<_i961.BookingRepository>(),
        gh<_i64.BookingDraftRepository>(),
      ),
    );
    gh.lazySingleton<_i472.AuthenticationRepository>(
      () => _i472.AuthenticationRepository(
        gh<_i137.AuthenticationDataSource>(),
        gh<_i151.FirestoreDataSource>(),
        gh<_i113.NotificationRepository>(),
      ),
    );
    gh.factory<_i492.AppointmentAvailabilityCubit>(
      () => _i492.AppointmentAvailabilityCubit(
        gh<_i567.AppointmentRepository>(),
        gh<_i1064.ServiceAvailabilityRepository>(),
      ),
    );
    gh.factory<_i259.BookingDetailsCubit>(
      () => _i259.BookingDetailsCubit(
        gh<_i961.BookingRepository>(),
        gh<_i64.BookingDraftRepository>(),
      ),
    );
    gh.factory<_i390.ServiceDetailCubit>(
      () => _i390.ServiceDetailCubit(
        gh<_i1065.BusinessRepository>(),
        gh<_i390.SavedBusinessRepository>(),
      ),
    );
    gh.factory<_i386.StayDetailCubit>(
      () => _i386.StayDetailCubit(
        gh<_i1065.BusinessRepository>(),
        gh<_i390.SavedBusinessRepository>(),
      ),
    );
    gh.factory<_i1028.SignupCubit>(
      () => _i1028.SignupCubit(gh<_i472.AuthenticationRepository>()),
    );
    gh.factory<_i952.HomeBloc>(
      () => _i952.HomeBloc(gh<_i472.AuthenticationRepository>()),
    );
    gh.factory<_i897.CustomerProfileCubit>(
      () => _i897.CustomerProfileCubit(
        gh<_i472.AuthenticationRepository>(),
        gh<_i747.UserRepository>(),
        gh<_i525.ChatRepository>(),
      ),
    );
    gh.factory<_i167.AppointmentPaymentCubit>(
      () => _i167.AppointmentPaymentCubit(
        gh<_i567.AppointmentRepository>(),
        gh<_i363.AppointmentDraftRepository>(),
      ),
    );
    gh.factory<_i44.SigninCubit>(
      () => _i44.SigninCubit(
        gh<_i472.AuthenticationRepository>(),
        gh<_i747.UserRepository>(),
      ),
    );
    return this;
  }
}

class _$FirebaseModule extends _i211.FirebaseModule {}

class _$SharedPrefsModule extends _i144.SharedPrefsModule {}
