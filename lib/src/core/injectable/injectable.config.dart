// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:cloud_functions/cloud_functions.dart' as _i809;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:multibook/src/core/errors/rest_repository_executor.dart'
    as _i411;
import 'package:multibook/src/core/modules/firebase_module.dart' as _i548;
import 'package:multibook/src/core/modules/shared_preferences_module.dart'
    as _i92;
import 'package:multibook/src/core/session/session_stream_registry.dart'
    as _i1025;
import 'package:multibook/src/data/data_sources/api_client.dart' as _i189;
import 'package:multibook/src/data/data_sources/authentication_data_source.dart'
    as _i715;
import 'package:multibook/src/data/data_sources/business_metrics_data_source.dart'
    as _i468;
import 'package:multibook/src/data/data_sources/businesses_api_data_source.dart'
    as _i768;
import 'package:multibook/src/data/data_sources/chat_data_source.dart' as _i3;
import 'package:multibook/src/data/data_sources/customer_checkout_api_data_source.dart'
    as _i563;
import 'package:multibook/src/data/data_sources/customer_discovery_api_data_source.dart'
    as _i677;
import 'package:multibook/src/data/data_sources/customer_drafts_api_data_source.dart'
    as _i127;
import 'package:multibook/src/data/data_sources/development_seed_api_data_source.dart'
    as _i82;
import 'package:multibook/src/data/data_sources/device_location_data_source.dart'
    as _i397;
import 'package:multibook/src/data/data_sources/firebase_storage_data_source.dart'
    as _i594;
import 'package:multibook/src/data/data_sources/firestore_data_source.dart'
    as _i198;
import 'package:multibook/src/data/data_sources/image_picker_data_source.dart'
    as _i157;
import 'package:multibook/src/data/data_sources/in_app_notification_data_source.dart'
    as _i467;
import 'package:multibook/src/data/data_sources/nominatim_data_source.dart'
    as _i117;
import 'package:multibook/src/data/data_sources/notification_data_source.dart'
    as _i190;
import 'package:multibook/src/data/data_sources/review_data_source.dart'
    as _i911;
import 'package:multibook/src/data/data_sources/service_search_data_source.dart'
    as _i139;
import 'package:multibook/src/data/data_sources/stay_search_data_source.dart'
    as _i665;
import 'package:multibook/src/data/data_sources/users_api_data_source.dart'
    as _i364;
import 'package:multibook/src/data/models/booking_model.dart' as _i259;
import 'package:multibook/src/data/repositories/appointment_repository.dart'
    as _i331;
import 'package:multibook/src/data/repositories/authentication_repository.dart'
    as _i869;
import 'package:multibook/src/data/repositories/booking_repository.dart'
    as _i1068;
import 'package:multibook/src/data/repositories/business_metrics_repository.dart'
    as _i694;
import 'package:multibook/src/data/repositories/business_repository.dart'
    as _i590;
import 'package:multibook/src/data/repositories/businesses_repository_impl.dart'
    as _i48;
import 'package:multibook/src/data/repositories/chat_repository.dart' as _i905;
import 'package:multibook/src/data/repositories/customer_checkout_repository_impl.dart'
    as _i865;
import 'package:multibook/src/data/repositories/customer_discovery_repository_impl.dart'
    as _i614;
import 'package:multibook/src/data/repositories/customer_drafts_repository_impl.dart'
    as _i675;
import 'package:multibook/src/data/repositories/development_seed_repository_impl.dart'
    as _i795;
import 'package:multibook/src/data/repositories/locale_repository.dart'
    as _i724;
import 'package:multibook/src/data/repositories/notification_repository.dart'
    as _i26;
import 'package:multibook/src/data/repositories/onboarding_repository.dart'
    as _i38;
import 'package:multibook/src/data/repositories/payment_methods_repository.dart'
    as _i447;
import 'package:multibook/src/data/repositories/promotion_repository.dart'
    as _i1038;
import 'package:multibook/src/data/repositories/recently_viewed_repository.dart'
    as _i4;
import 'package:multibook/src/data/repositories/review_repository.dart'
    as _i682;
import 'package:multibook/src/data/repositories/saved_business_repository.dart'
    as _i702;
import 'package:multibook/src/data/repositories/service_availability_repository.dart'
    as _i175;
import 'package:multibook/src/data/repositories/service_search_repository.dart'
    as _i459;
import 'package:multibook/src/data/repositories/stay_search_repository.dart'
    as _i1001;
import 'package:multibook/src/data/repositories/support_ticket_repository.dart'
    as _i142;
import 'package:multibook/src/data/repositories/user_location_repository.dart'
    as _i682;
import 'package:multibook/src/data/repositories/users_repository_impl.dart'
    as _i595;
import 'package:multibook/src/domain/repositories/businesses_repository.dart'
    as _i197;
import 'package:multibook/src/domain/repositories/customer_checkout_repository.dart'
    as _i465;
import 'package:multibook/src/domain/repositories/customer_discovery_repository.dart'
    as _i206;
import 'package:multibook/src/domain/repositories/customer_drafts_repository.dart'
    as _i238;
import 'package:multibook/src/domain/repositories/development_seed_repository.dart'
    as _i333;
import 'package:multibook/src/domain/repositories/users_repository.dart'
    as _i946;
import 'package:multibook/src/domain/use_cases/businesses/create_business_use_case.dart'
    as _i673;
import 'package:multibook/src/domain/use_cases/businesses/get_owned_business_use_case.dart'
    as _i829;
import 'package:multibook/src/domain/use_cases/businesses/get_owned_businesses_use_case.dart'
    as _i41;
import 'package:multibook/src/domain/use_cases/businesses/get_selected_business_use_case.dart'
    as _i1063;
import 'package:multibook/src/domain/use_cases/businesses/update_business_use_case.dart'
    as _i835;
import 'package:multibook/src/domain/use_cases/checkout/customer_checkout_use_case.dart'
    as _i903;
import 'package:multibook/src/domain/use_cases/customer_discovery/get_business_detail_use_case.dart'
    as _i742;
import 'package:multibook/src/domain/use_cases/customer_discovery/get_popular_nearby_businesses_use_case.dart'
    as _i88;
import 'package:multibook/src/domain/use_cases/development_seed/development_seed_use_case.dart'
    as _i168;
import 'package:multibook/src/domain/use_cases/drafts/customer_drafts_use_case.dart'
    as _i999;
import 'package:multibook/src/domain/use_cases/users/get_current_user_use_case.dart'
    as _i850;
import 'package:multibook/src/domain/use_cases/users/update_user_profile_use_case.dart'
    as _i928;
import 'package:multibook/src/domain/use_cases/users/update_user_role_use_case.dart'
    as _i919;
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart'
    as _i981;
import 'package:multibook/src/features/business-side/account_settings/bloc/account_settings_cubit.dart'
    as _i328;
import 'package:multibook/src/features/business-side/add_business/bloc/add_business_bloc.dart'
    as _i633;
import 'package:multibook/src/features/business-side/availability_calendar/bloc/availability_calendar_cubit.dart'
    as _i582;
import 'package:multibook/src/features/business-side/bookings/bloc/client_bookings_cubit.dart'
    as _i154;
import 'package:multibook/src/features/business-side/change_password/cubit/change_password_cubit.dart'
    as _i975;
import 'package:multibook/src/features/business-side/dashboard/bloc/dashboard_cubit.dart'
    as _i972;
import 'package:multibook/src/features/business-side/earnings/bloc/earnings_cubit.dart'
    as _i428;
import 'package:multibook/src/features/business-side/home/bloc/client_entry_cubit.dart'
    as _i247;
import 'package:multibook/src/features/business-side/home/bloc/home_bloc.dart'
    as _i738;
import 'package:multibook/src/features/business-side/manage_catalog/bloc/manage_catalog_cubit.dart'
    as _i925;
import 'package:multibook/src/features/business-side/more/bloc/more_cubit.dart'
    as _i223;
import 'package:multibook/src/features/business-side/my_businesses/bloc/my_businesses_cubit.dart'
    as _i739;
import 'package:multibook/src/features/business-side/promotions/bloc/create_promotion_cubit.dart'
    as _i1053;
import 'package:multibook/src/features/business-side/promotions/bloc/promotions_cubit.dart'
    as _i51;
import 'package:multibook/src/features/customer-side/appointment_details/cubit/appointment_details_cubit.dart'
    as _i874;
import 'package:multibook/src/features/customer-side/appointment_payment/cubit/appointment_payment_cubit.dart'
    as _i535;
import 'package:multibook/src/features/customer-side/appointment_payment/cubit/appointment_promotion_cubit.dart'
    as _i305;
import 'package:multibook/src/features/customer-side/booking_details/bloc/booking_details_cubit.dart'
    as _i823;
import 'package:multibook/src/features/customer-side/bookings/bloc/customer_bookings_cubit.dart'
    as _i212;
import 'package:multibook/src/features/customer-side/create_appointment/cubit/appointment_availability_cubit.dart'
    as _i496;
import 'package:multibook/src/features/customer-side/create_appointment/cubit/appointment_draft_cubit.dart'
    as _i52;
import 'package:multibook/src/features/customer-side/customer_booking_details/cubit/customer_booking_details_cubit.dart'
    as _i387;
import 'package:multibook/src/features/customer-side/dashboard/bloc/customer_dashboard_cubit.dart'
    as _i41;
import 'package:multibook/src/features/customer-side/explore/cubit/explore_cubit.dart'
    as _i227;
import 'package:multibook/src/features/customer-side/explore/cubit/explore_service_results_cubit.dart'
    as _i442;
import 'package:multibook/src/features/customer-side/explore/cubit/explore_stay_results_cubit.dart'
    as _i113;
import 'package:multibook/src/features/customer-side/payment/cubit/booking_promotion_cubit.dart'
    as _i455;
import 'package:multibook/src/features/customer-side/payment/cubit/payment_cubit.dart'
    as _i297;
import 'package:multibook/src/features/customer-side/payment_methods/cubit/payment_methods_cubit.dart'
    as _i108;
import 'package:multibook/src/features/customer-side/profile/cubit/customer_profile_cubit.dart'
    as _i103;
import 'package:multibook/src/features/customer-side/reschedule_appointment/cubit/reschedule_appointment_cubit.dart'
    as _i269;
import 'package:multibook/src/features/customer-side/review_stay/cubit/review_stay_cubit.dart'
    as _i243;
import 'package:multibook/src/features/customer-side/saved/cubit/saved_cubit.dart'
    as _i948;
import 'package:multibook/src/features/customer-side/search/cubit/customer_search_cubit.dart'
    as _i378;
import 'package:multibook/src/features/customer-side/service_detail/cubit/service_detail_cubit.dart'
    as _i702;
import 'package:multibook/src/features/customer-side/stay_detail/cubit/stay_detail_cubit.dart'
    as _i648;
import 'package:multibook/src/features/customer-side/support_tickets/cubit/create_support_ticket_cubit.dart'
    as _i974;
import 'package:multibook/src/features/customer-side/support_tickets/cubit/support_tickets_cubit.dart'
    as _i806;
import 'package:multibook/src/features/shared/chat/cubit/chat_conversation_cubit.dart'
    as _i152;
import 'package:multibook/src/features/shared/chat/cubit/chat_list_cubit.dart'
    as _i1005;
import 'package:multibook/src/features/shared/localization/cubit/locale_cubit.dart'
    as _i889;
import 'package:multibook/src/features/shared/notifications/cubit/notifications_cubit.dart'
    as _i272;
import 'package:multibook/src/features/shared/onboarding/cubit/onboarding_cubit.dart'
    as _i400;
import 'package:multibook/src/features/shared/rate_business/cubit/rate_business_cubit.dart'
    as _i115;
import 'package:multibook/src/features/shared/recently_viewed/cubit/recently_viewed_cubit.dart'
    as _i751;
import 'package:multibook/src/features/shared/recently_viewed/cubit/recently_viewed_services_cubit.dart'
    as _i428;
import 'package:multibook/src/features/shared/sign_in/cubit/signin_cubit.dart'
    as _i488;
import 'package:multibook/src/features/shared/sign_up/cubit/signup_cubit.dart'
    as _i379;
import 'package:multibook/src/features/shared/user_location/cubit/user_location_cubit.dart'
    as _i134;
import 'package:multibook/src/features/shared/user_type_checker/cubit/user_type_checker_cubit.dart'
    as _i190;
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
    gh.lazySingleton<_i1025.SessionStreamRegistry>(
      () => _i1025.SessionStreamRegistry(),
    );
    gh.lazySingleton<_i411.RestRepositoryExecutor>(
      () => _i411.RestRepositoryExecutor(),
    );
    gh.lazySingleton<_i117.NominatimDataSource>(
      () => _i117.NominatimDataSourceImpl(),
    );
    gh.lazySingleton<_i157.ImagePickerDataSource>(
      () => _i157.ImagePickerDataSourceImpl(),
    );
    gh.lazySingleton<_i397.DeviceLocationDataSource>(
      () => _i397.DeviceLocationDataSourceImpl(),
    );
    gh.lazySingleton<_i38.OnboardingRepository>(
      () => _i38.OnboardingRepository(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i724.LocaleRepository>(
      () => _i724.LocaleRepository(gh<_i460.SharedPreferences>()),
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
    gh.lazySingleton<_i189.ApiClient>(
      () => _i189.ApiClient(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i715.AuthenticationDataSource>(
      () => _i715.AuthenticationDataSourceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i139.ServiceSearchDataSource>(
      () => _i139.ServiceSearchDataSourceImpl(gh<_i189.ApiClient>()),
    );
    gh.lazySingleton<_i198.FirestoreDataSource>(
      () => _i198.FirestoreDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i400.OnboardingCubit>(
      () => _i400.OnboardingCubit(gh<_i38.OnboardingRepository>()),
    );
    gh.lazySingleton<_i889.LocaleCubit>(
      () => _i889.LocaleCubit(gh<_i724.LocaleRepository>()),
    );
    gh.lazySingleton<_i467.InAppNotificationDataSource>(
      () =>
          _i467.InAppNotificationDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i911.ReviewDataSource>(
      () => _i911.ReviewDataSourceImpl(gh<_i809.FirebaseFunctions>()),
    );
    gh.lazySingleton<_i3.ChatDataSource>(
      () => _i3.ChatDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i905.ChatRepository>(
      () => _i905.ChatRepository(
        gh<_i715.AuthenticationDataSource>(),
        gh<_i3.ChatDataSource>(),
      ),
    );
    gh.lazySingleton<_i190.NotificationDataSource>(
      () => _i190.NotificationDataSourceImpl(gh<_i892.FirebaseMessaging>()),
    );
    gh.lazySingleton<_i594.FirebaseStorageDataSource>(
      () => _i594.FirebaseStorageDataSourceImpl(gh<_i457.FirebaseStorage>()),
    );
    gh.factory<_i1005.ChatListCubit>(
      () => _i1005.ChatListCubit(gh<_i905.ChatRepository>()),
    );
    gh.lazySingleton<_i682.ReviewRepository>(
      () => _i682.ReviewRepository(
        gh<_i911.ReviewDataSource>(),
        gh<_i198.FirestoreDataSource>(),
        gh<_i715.AuthenticationDataSource>(),
      ),
    );
    gh.lazySingleton<_i447.PaymentMethodsRepository>(
      () => _i447.PaymentMethodsRepository(
        gh<_i715.AuthenticationDataSource>(),
        gh<_i198.FirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i4.RecentlyViewedRepository>(
      () => _i4.RecentlyViewedRepository(
        gh<_i715.AuthenticationDataSource>(),
        gh<_i198.FirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i702.SavedBusinessRepository>(
      () => _i702.SavedBusinessRepository(
        gh<_i715.AuthenticationDataSource>(),
        gh<_i198.FirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i1038.PromotionRepository>(
      () => _i1038.PromotionRepository(
        gh<_i715.AuthenticationDataSource>(),
        gh<_i198.FirestoreDataSource>(),
      ),
    );
    gh.lazySingleton<_i175.ServiceAvailabilityRepository>(
      () => _i175.ServiceAvailabilityRepository(
        gh<_i715.AuthenticationDataSource>(),
        gh<_i198.FirestoreDataSource>(),
      ),
    );
    gh.factory<_i751.RecentlyViewedCubit>(
      () => _i751.RecentlyViewedCubit(gh<_i4.RecentlyViewedRepository>()),
    );
    gh.factory<_i428.RecentlyViewedServicesCubit>(
      () =>
          _i428.RecentlyViewedServicesCubit(gh<_i4.RecentlyViewedRepository>()),
    );
    gh.lazySingleton<_i364.UsersApiDataSource>(
      () => _i364.UsersApiDataSource(
        gh<_i189.ApiClient>(),
        gh<_i594.FirebaseStorageDataSource>(),
      ),
    );
    gh.lazySingleton<_i768.BusinessesApiDataSource>(
      () => _i768.BusinessesApiDataSource(
        gh<_i189.ApiClient>(),
        gh<_i594.FirebaseStorageDataSource>(),
      ),
    );
    gh.factory<_i1053.CreatePromotionCubit>(
      () => _i1053.CreatePromotionCubit(gh<_i1038.PromotionRepository>()),
    );
    gh.lazySingleton<_i468.BusinessMetricsDataSource>(
      () => _i468.BusinessMetricsDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i809.FirebaseFunctions>(),
      ),
    );
    gh.lazySingleton<_i677.CustomerDiscoveryApiDataSource>(
      () => _i677.CustomerDiscoveryApiDataSource(
        gh<_i189.ApiClient>(),
        gh<_i594.FirebaseStorageDataSource>(),
      ),
    );
    gh.lazySingleton<_i127.CustomerDraftsApiDataSource>(
      () => _i127.CustomerDraftsApiDataSource(
        gh<_i189.ApiClient>(),
        gh<_i594.FirebaseStorageDataSource>(),
      ),
    );
    gh.lazySingleton<_i665.StaySearchDataSource>(
      () => _i665.StaySearchDataSourceImpl(gh<_i189.ApiClient>()),
    );
    gh.lazySingleton<_i82.DevelopmentSeedApiDataSource>(
      () => _i82.DevelopmentSeedApiDataSource(gh<_i189.ApiClient>()),
    );
    gh.lazySingleton<_i563.CustomerCheckoutApiDataSource>(
      () => _i563.CustomerCheckoutApiDataSource(gh<_i189.ApiClient>()),
    );
    gh.factory<_i948.SavedCubit>(
      () => _i948.SavedCubit(gh<_i702.SavedBusinessRepository>()),
    );
    gh.factory<_i108.PaymentMethodsCubit>(
      () => _i108.PaymentMethodsCubit(gh<_i447.PaymentMethodsRepository>()),
    );
    gh.lazySingleton<_i26.NotificationRepository>(
      () => _i26.NotificationRepository(
        gh<_i715.AuthenticationDataSource>(),
        gh<_i198.FirestoreDataSource>(),
        gh<_i190.NotificationDataSource>(),
        gh<_i467.InAppNotificationDataSource>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i455.BookingPromotionCubit>(
      () => _i455.BookingPromotionCubit(gh<_i1038.PromotionRepository>()),
    );
    gh.factory<_i305.AppointmentPromotionCubit>(
      () => _i305.AppointmentPromotionCubit(gh<_i1038.PromotionRepository>()),
    );
    gh.factory<_i272.NotificationsCubit>(
      () => _i272.NotificationsCubit(gh<_i26.NotificationRepository>()),
    );
    gh.lazySingleton<_i197.BusinessesRepository>(
      () => _i48.BusinessesRepositoryImpl(
        gh<_i768.BusinessesApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.factory<_i673.CreateBusinessUseCase>(
      () => _i673.CreateBusinessUseCase(gh<_i197.BusinessesRepository>()),
    );
    gh.factory<_i835.UpdateBusinessUseCase>(
      () => _i835.UpdateBusinessUseCase(gh<_i197.BusinessesRepository>()),
    );
    gh.factory<_i829.GetOwnedBusinessUseCase>(
      () => _i829.GetOwnedBusinessUseCase(gh<_i197.BusinessesRepository>()),
    );
    gh.lazySingleton<_i41.GetOwnedBusinessesUseCase>(
      () => _i41.GetOwnedBusinessesUseCase(gh<_i197.BusinessesRepository>()),
    );
    gh.factory<_i115.RateBusinessCubit>(
      () => _i115.RateBusinessCubit(gh<_i682.ReviewRepository>()),
    );
    gh.lazySingleton<_i694.BusinessMetricsRepository>(
      () => _i694.BusinessMetricsRepository(
        gh<_i468.BusinessMetricsDataSource>(),
      ),
    );
    gh.lazySingleton<_i946.UsersRepository>(
      () => _i595.UsersRepositoryImpl(
        gh<_i364.UsersApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.lazySingleton<_i465.CustomerCheckoutRepository>(
      () => _i865.CustomerCheckoutRepositoryImpl(
        gh<_i563.CustomerCheckoutApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.factory<_i928.UpdateUserProfileUseCase>(
      () => _i928.UpdateUserProfileUseCase(gh<_i946.UsersRepository>()),
    );
    gh.factory<_i850.GetCurrentUserUseCase>(
      () => _i850.GetCurrentUserUseCase(gh<_i946.UsersRepository>()),
    );
    gh.factory<_i919.UpdateUserRoleUseCase>(
      () => _i919.UpdateUserRoleUseCase(gh<_i946.UsersRepository>()),
    );
    gh.lazySingleton<_i238.CustomerDraftsRepository>(
      () => _i675.CustomerDraftsRepositoryImpl(
        gh<_i127.CustomerDraftsApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.lazySingleton<_i333.DevelopmentSeedRepository>(
      () => _i795.DevelopmentSeedRepositoryImpl(
        gh<_i82.DevelopmentSeedApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.lazySingleton<_i206.CustomerDiscoveryRepository>(
      () => _i614.CustomerDiscoveryRepositoryImpl(
        gh<_i677.CustomerDiscoveryApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.lazySingleton<_i981.UserProfileUseCase>(
      () => _i981.UserProfileUseCase(
        gh<_i715.AuthenticationDataSource>(),
        gh<_i594.FirebaseStorageDataSource>(),
        gh<_i946.UsersRepository>(),
      ),
    );
    gh.lazySingleton<_i869.AuthenticationRepository>(
      () => _i869.AuthenticationRepository(
        gh<_i715.AuthenticationDataSource>(),
        gh<_i928.UpdateUserProfileUseCase>(),
        gh<_i26.NotificationRepository>(),
        gh<_i1025.SessionStreamRegistry>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i1063.GetSelectedBusinessUseCase>(
      () => _i1063.GetSelectedBusinessUseCase(
        gh<_i829.GetOwnedBusinessUseCase>(),
      ),
    );
    gh.lazySingleton<_i682.UserLocationRepository>(
      () => _i682.UserLocationRepository(
        gh<_i397.DeviceLocationDataSource>(),
        gh<_i117.NominatimDataSource>(),
        gh<_i981.UserProfileUseCase>(),
      ),
    );
    gh.factory<_i972.DashboardCubit>(
      () => _i972.DashboardCubit(
        gh<_i981.UserProfileUseCase>(),
        gh<_i1063.GetSelectedBusinessUseCase>(),
        gh<_i694.BusinessMetricsRepository>(),
        gh<_i1025.SessionStreamRegistry>(),
      ),
    );
    gh.factory<_i190.UserTypeCheckerCubit>(
      () => _i190.UserTypeCheckerCubit(gh<_i919.UpdateUserRoleUseCase>()),
    );
    gh.factory<_i379.SignupCubit>(
      () => _i379.SignupCubit(gh<_i869.AuthenticationRepository>()),
    );
    gh.factory<_i738.HomeBloc>(
      () => _i738.HomeBloc(gh<_i869.AuthenticationRepository>()),
    );
    gh.factory<_i975.ChangePasswordCubit>(
      () => _i975.ChangePasswordCubit(gh<_i869.AuthenticationRepository>()),
    );
    gh.factory<_i134.UserLocationCubit>(
      () => _i134.UserLocationCubit(gh<_i682.UserLocationRepository>()),
    );
    gh.lazySingleton<_i590.BusinessRepository>(
      () => _i590.BusinessRepository(
        gh<_i715.AuthenticationDataSource>(),
        gh<_i198.FirestoreDataSource>(),
        gh<_i594.FirebaseStorageDataSource>(),
        gh<_i117.NominatimDataSource>(),
        gh<_i981.UserProfileUseCase>(),
        gh<_i41.GetOwnedBusinessesUseCase>(),
      ),
    );
    gh.factory<_i168.DevelopmentSeedUseCase>(
      () => _i168.DevelopmentSeedUseCase(gh<_i333.DevelopmentSeedRepository>()),
    );
    gh.factory<_i88.GetPopularNearbyBusinessesUseCase>(
      () => _i88.GetPopularNearbyBusinessesUseCase(
        gh<_i206.CustomerDiscoveryRepository>(),
      ),
    );
    gh.lazySingleton<_i742.GetBusinessDetailUseCase>(
      () => _i742.GetBusinessDetailUseCase(
        gh<_i206.CustomerDiscoveryRepository>(),
      ),
    );
    gh.factory<_i428.EarningsCubit>(
      () => _i428.EarningsCubit(
        gh<_i981.UserProfileUseCase>(),
        gh<_i590.BusinessRepository>(),
        gh<_i694.BusinessMetricsRepository>(),
        gh<_i1025.SessionStreamRegistry>(),
      ),
    );
    gh.factory<_i488.SigninCubit>(
      () => _i488.SigninCubit(
        gh<_i869.AuthenticationRepository>(),
        gh<_i981.UserProfileUseCase>(),
      ),
    );
    gh.factory<_i103.CustomerProfileCubit>(
      () => _i103.CustomerProfileCubit(
        gh<_i869.AuthenticationRepository>(),
        gh<_i981.UserProfileUseCase>(),
        gh<_i905.ChatRepository>(),
        gh<_i1025.SessionStreamRegistry>(),
      ),
    );
    gh.lazySingleton<_i1001.StaySearchRepository>(
      () => _i1001.StaySearchRepository(
        gh<_i665.StaySearchDataSource>(),
        gh<_i590.BusinessRepository>(),
      ),
    );
    gh.factory<_i999.CustomerDraftsUseCase>(
      () => _i999.CustomerDraftsUseCase(gh<_i238.CustomerDraftsRepository>()),
    );
    gh.factory<_i52.AppointmentDraftCubit>(
      () => _i52.AppointmentDraftCubit(gh<_i999.CustomerDraftsUseCase>()),
    );
    gh.factory<_i925.ManageCatalogCubit>(
      () => _i925.ManageCatalogCubit(
        gh<_i981.UserProfileUseCase>(),
        gh<_i1063.GetSelectedBusinessUseCase>(),
        gh<_i835.UpdateBusinessUseCase>(),
      ),
    );
    gh.factory<_i152.ChatConversationCubit>(
      () => _i152.ChatConversationCubit(
        gh<_i905.ChatRepository>(),
        gh<_i981.UserProfileUseCase>(),
      ),
    );
    gh.lazySingleton<_i331.AppointmentRepository>(
      () => _i331.AppointmentRepository(
        gh<_i715.AuthenticationDataSource>(),
        gh<_i198.FirestoreDataSource>(),
        gh<_i590.BusinessRepository>(),
        gh<_i175.ServiceAvailabilityRepository>(),
        gh<_i1038.PromotionRepository>(),
      ),
    );
    gh.factory<_i874.AppointmentDetailsCubit>(
      () => _i874.AppointmentDetailsCubit(
        gh<_i590.BusinessRepository>(),
        gh<_i331.AppointmentRepository>(),
        gh<_i682.ReviewRepository>(),
      ),
    );
    gh.factory<_i328.AccountSettingsCubit>(
      () => _i328.AccountSettingsCubit(
        gh<_i981.UserProfileUseCase>(),
        gh<_i157.ImagePickerDataSource>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i903.CustomerCheckoutUseCase>(
      () =>
          _i903.CustomerCheckoutUseCase(gh<_i465.CustomerCheckoutRepository>()),
    );
    gh.factory<_i297.PaymentCubit>(
      () => _i297.PaymentCubit(
        gh<_i903.CustomerCheckoutUseCase>(),
        gh<_i999.CustomerDraftsUseCase>(),
      ),
    );
    gh.factory<_i535.AppointmentPaymentCubit>(
      () => _i535.AppointmentPaymentCubit(
        gh<_i903.CustomerCheckoutUseCase>(),
        gh<_i999.CustomerDraftsUseCase>(),
      ),
    );
    gh.factory<_i247.ClientEntryCubit>(
      () => _i247.ClientEntryCubit(
        gh<_i1063.GetSelectedBusinessUseCase>(),
        gh<_i981.UserProfileUseCase>(),
      ),
    );
    gh.lazySingleton<_i1068.BookingRepository>(
      () => _i1068.BookingRepository(
        gh<_i715.AuthenticationDataSource>(),
        gh<_i198.FirestoreDataSource>(),
        gh<_i590.BusinessRepository>(),
        gh<_i1038.PromotionRepository>(),
      ),
    );
    gh.factory<_i582.AvailabilityCalendarCubit>(
      () => _i582.AvailabilityCalendarCubit(
        gh<_i1068.BookingRepository>(),
        gh<_i590.BusinessRepository>(),
        gh<_i981.UserProfileUseCase>(),
      ),
    );
    gh.factory<_i496.AppointmentAvailabilityCubit>(
      () => _i496.AppointmentAvailabilityCubit(
        gh<_i331.AppointmentRepository>(),
        gh<_i175.ServiceAvailabilityRepository>(),
      ),
    );
    gh.factory<_i269.RescheduleAppointmentCubit>(
      () => _i269.RescheduleAppointmentCubit(gh<_i331.AppointmentRepository>()),
    );
    gh.factory<_i113.ExploreStayResultsCubit>(
      () => _i113.ExploreStayResultsCubit(gh<_i1001.StaySearchRepository>()),
    );
    gh.lazySingleton<_i142.SupportTicketRepository>(
      () => _i142.SupportTicketRepository(
        gh<_i715.AuthenticationDataSource>(),
        gh<_i198.FirestoreDataSource>(),
        gh<_i981.UserProfileUseCase>(),
      ),
    );
    gh.factory<_i243.ReviewStayCubit>(
      () => _i243.ReviewStayCubit(
        gh<_i742.GetBusinessDetailUseCase>(),
        gh<_i999.CustomerDraftsUseCase>(),
      ),
    );
    gh.factory<_i227.ExploreCubit>(
      () => _i227.ExploreCubit(
        gh<_i981.UserProfileUseCase>(),
        gh<_i590.BusinessRepository>(),
      ),
    );
    gh.factory<_i378.CustomerSearchCubit>(
      () => _i378.CustomerSearchCubit(
        gh<_i88.GetPopularNearbyBusinessesUseCase>(),
      ),
    );
    gh.factory<_i739.MyBusinessesCubit>(
      () => _i739.MyBusinessesCubit(
        gh<_i590.BusinessRepository>(),
        gh<_i981.UserProfileUseCase>(),
        gh<_i41.GetOwnedBusinessesUseCase>(),
      ),
    );
    gh.factory<_i51.PromotionsCubit>(
      () => _i51.PromotionsCubit(
        gh<_i590.BusinessRepository>(),
        gh<_i981.UserProfileUseCase>(),
        gh<_i1038.PromotionRepository>(),
      ),
    );
    gh.factory<_i823.BookingDetailsCubit>(
      () => _i823.BookingDetailsCubit(
        gh<_i1068.BookingRepository>(),
        gh<_i999.CustomerDraftsUseCase>(),
      ),
    );
    gh.factory<_i702.ServiceDetailCubit>(
      () => _i702.ServiceDetailCubit(
        gh<_i742.GetBusinessDetailUseCase>(),
        gh<_i702.SavedBusinessRepository>(),
        gh<_i4.RecentlyViewedRepository>(),
        gh<_i682.ReviewRepository>(),
      ),
    );
    gh.factory<_i648.StayDetailCubit>(
      () => _i648.StayDetailCubit(
        gh<_i742.GetBusinessDetailUseCase>(),
        gh<_i702.SavedBusinessRepository>(),
        gh<_i4.RecentlyViewedRepository>(),
        gh<_i682.ReviewRepository>(),
      ),
    );
    gh.factory<_i633.AddBusinessBloc>(
      () => _i633.AddBusinessBloc(
        gh<_i157.ImagePickerDataSource>(),
        gh<_i460.SharedPreferences>(),
        gh<_i590.BusinessRepository>(),
        gh<_i673.CreateBusinessUseCase>(),
        gh<_i41.GetOwnedBusinessesUseCase>(),
        gh<_i829.GetOwnedBusinessUseCase>(),
        gh<_i835.UpdateBusinessUseCase>(),
        gh<_i715.AuthenticationDataSource>(),
        gh<_i594.FirebaseStorageDataSource>(),
        gh<_i168.DevelopmentSeedUseCase>(),
        gh<_i981.UserProfileUseCase>(),
      ),
    );
    gh.factory<_i212.CustomerBookingsCubit>(
      () => _i212.CustomerBookingsCubit(
        gh<_i1068.BookingRepository>(),
        gh<_i331.AppointmentRepository>(),
      ),
    );
    gh.factory<_i223.MoreCubit>(
      () => _i223.MoreCubit(
        gh<_i590.BusinessRepository>(),
        gh<_i981.UserProfileUseCase>(),
        gh<_i905.ChatRepository>(),
        gh<_i1025.SessionStreamRegistry>(),
      ),
    );
    gh.lazySingleton<_i459.ServiceSearchRepository>(
      () => _i459.ServiceSearchRepository(
        gh<_i139.ServiceSearchDataSource>(),
        gh<_i590.BusinessRepository>(),
      ),
    );
    gh.factory<_i154.ClientBookingsCubit>(
      () => _i154.ClientBookingsCubit(
        gh<_i1068.BookingRepository>(),
        gh<_i331.AppointmentRepository>(),
        gh<_i590.BusinessRepository>(),
        gh<_i981.UserProfileUseCase>(),
      ),
    );
    gh.factoryParam<
      _i387.CustomerBookingDetailsCubit,
      _i259.BookingModel,
      dynamic
    >(
      (booking, _) => _i387.CustomerBookingDetailsCubit(
        gh<_i1068.BookingRepository>(),
        gh<_i682.ReviewRepository>(),
        booking,
      ),
    );
    gh.factory<_i41.CustomerDashboardCubit>(
      () => _i41.CustomerDashboardCubit(
        gh<_i590.BusinessRepository>(),
        gh<_i1001.StaySearchRepository>(),
        gh<_i459.ServiceSearchRepository>(),
        gh<_i999.CustomerDraftsUseCase>(),
        gh<_i981.UserProfileUseCase>(),
        gh<_i682.UserLocationRepository>(),
        gh<_i742.GetBusinessDetailUseCase>(),
        gh<_i88.GetPopularNearbyBusinessesUseCase>(),
      ),
    );
    gh.factory<_i806.SupportTicketsCubit>(
      () => _i806.SupportTicketsCubit(gh<_i142.SupportTicketRepository>()),
    );
    gh.factory<_i974.CreateSupportTicketCubit>(
      () => _i974.CreateSupportTicketCubit(gh<_i142.SupportTicketRepository>()),
    );
    gh.factory<_i442.ExploreServiceResultsCubit>(
      () =>
          _i442.ExploreServiceResultsCubit(gh<_i459.ServiceSearchRepository>()),
    );
    return this;
  }
}

class _$FirebaseModule extends _i548.FirebaseModule {}

class _$SharedPrefsModule extends _i92.SharedPrefsModule {}
