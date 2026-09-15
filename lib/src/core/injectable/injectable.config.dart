// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
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
import 'package:multibook/src/core/networking/api_client.dart' as _i234;
import 'package:multibook/src/core/networking/sse_client.dart' as _i486;
import 'package:multibook/src/core/services/notification_device_service.dart'
    as _i730;
import 'package:multibook/src/core/services/recently_viewed_updates_service.dart'
    as _i950;
import 'package:multibook/src/core/services/saved_business_updates_service.dart'
    as _i167;
import 'package:multibook/src/core/session/session_stream_registry.dart'
    as _i1025;
import 'package:multibook/src/data/data_sources/authentication_data_source.dart'
    as _i715;
import 'package:multibook/src/data/data_sources/businesses_api_data_source.dart'
    as _i768;
import 'package:multibook/src/data/data_sources/chat_api_data_source.dart'
    as _i69;
import 'package:multibook/src/data/data_sources/customer_appointments_api_data_source.dart'
    as _i264;
import 'package:multibook/src/data/data_sources/customer_bookings_api_data_source.dart'
    as _i488;
import 'package:multibook/src/data/data_sources/customer_checkout_api_data_source.dart'
    as _i563;
import 'package:multibook/src/data/data_sources/customer_discovery_api_data_source.dart'
    as _i677;
import 'package:multibook/src/data/data_sources/customer_drafts_api_data_source.dart'
    as _i127;
import 'package:multibook/src/data/data_sources/dashboard_metrics_api_data_source.dart'
    as _i965;
import 'package:multibook/src/data/data_sources/development_seed_api_data_source.dart'
    as _i82;
import 'package:multibook/src/data/data_sources/device_location_data_source.dart'
    as _i397;
import 'package:multibook/src/data/data_sources/earnings_metrics_api_data_source.dart'
    as _i449;
import 'package:multibook/src/data/data_sources/firebase_storage_data_source.dart'
    as _i594;
import 'package:multibook/src/data/data_sources/image_picker_data_source.dart'
    as _i157;
import 'package:multibook/src/data/data_sources/in_app_notifications_api_data_source.dart'
    as _i217;
import 'package:multibook/src/data/data_sources/nominatim_data_source.dart'
    as _i117;
import 'package:multibook/src/data/data_sources/notification_data_source.dart'
    as _i190;
import 'package:multibook/src/data/data_sources/payment_methods_api_data_source.dart'
    as _i176;
import 'package:multibook/src/data/data_sources/promotions_api_data_source.dart'
    as _i218;
import 'package:multibook/src/data/data_sources/provider_bookings_api_data_source.dart'
    as _i651;
import 'package:multibook/src/data/data_sources/recently_viewed_api_data_source.dart'
    as _i236;
import 'package:multibook/src/data/data_sources/reviews_api_data_source.dart'
    as _i411;
import 'package:multibook/src/data/data_sources/saved_business_api_data_source.dart'
    as _i920;
import 'package:multibook/src/data/data_sources/service_availability_api_data_source.dart'
    as _i433;
import 'package:multibook/src/data/data_sources/service_search_data_source.dart'
    as _i139;
import 'package:multibook/src/data/data_sources/stay_search_data_source.dart'
    as _i665;
import 'package:multibook/src/data/data_sources/support_ticket_api_data_source.dart'
    as _i145;
import 'package:multibook/src/data/data_sources/users_api_data_source.dart'
    as _i364;
import 'package:multibook/src/data/models/booking_model.dart' as _i259;
import 'package:multibook/src/data/repositories/authentication_repository.dart'
    as _i869;
import 'package:multibook/src/data/repositories/business_deletion_repository_impl.dart'
    as _i366;
import 'package:multibook/src/data/repositories/business_location_repository_impl.dart'
    as _i909;
import 'package:multibook/src/data/repositories/businesses_repository_impl.dart'
    as _i48;
import 'package:multibook/src/data/repositories/chat_repository_impl.dart'
    as _i574;
import 'package:multibook/src/data/repositories/customer_appointments_repository_impl.dart'
    as _i122;
import 'package:multibook/src/data/repositories/customer_bookings_repository_impl.dart'
    as _i609;
import 'package:multibook/src/data/repositories/customer_checkout_repository_impl.dart'
    as _i865;
import 'package:multibook/src/data/repositories/customer_discovery_repository_impl.dart'
    as _i614;
import 'package:multibook/src/data/repositories/customer_drafts_repository_impl.dart'
    as _i675;
import 'package:multibook/src/data/repositories/dashboard_metrics_repository_impl.dart'
    as _i489;
import 'package:multibook/src/data/repositories/development_seed_repository_impl.dart'
    as _i795;
import 'package:multibook/src/data/repositories/earnings_metrics_repository_impl.dart'
    as _i318;
import 'package:multibook/src/data/repositories/in_app_notifications_repository_impl.dart'
    as _i367;
import 'package:multibook/src/data/repositories/locale_repository.dart'
    as _i724;
import 'package:multibook/src/data/repositories/onboarding_repository.dart'
    as _i38;
import 'package:multibook/src/data/repositories/payment_methods_repository_impl.dart'
    as _i875;
import 'package:multibook/src/data/repositories/promotions_repository_impl.dart'
    as _i122;
import 'package:multibook/src/data/repositories/provider_bookings_repository_impl.dart'
    as _i656;
import 'package:multibook/src/data/repositories/recently_viewed_repository_impl.dart'
    as _i186;
import 'package:multibook/src/data/repositories/reviews_repository_impl.dart'
    as _i824;
import 'package:multibook/src/data/repositories/saved_business_repository_impl.dart'
    as _i475;
import 'package:multibook/src/data/repositories/service_availability_repository_impl.dart'
    as _i155;
import 'package:multibook/src/data/repositories/service_search_repository.dart'
    as _i459;
import 'package:multibook/src/data/repositories/stay_search_repository.dart'
    as _i1001;
import 'package:multibook/src/data/repositories/support_ticket_repository_impl.dart'
    as _i295;
import 'package:multibook/src/data/repositories/theme_repository_impl.dart'
    as _i1006;
import 'package:multibook/src/data/repositories/user_location_repository.dart'
    as _i682;
import 'package:multibook/src/data/repositories/users_repository_impl.dart'
    as _i595;
import 'package:multibook/src/domain/repositories/business_deletion_repository.dart'
    as _i686;
import 'package:multibook/src/domain/repositories/business_location_repository.dart'
    as _i941;
import 'package:multibook/src/domain/repositories/businesses_repository.dart'
    as _i197;
import 'package:multibook/src/domain/repositories/chat_repository.dart'
    as _i692;
import 'package:multibook/src/domain/repositories/customer_appointments_repository.dart'
    as _i884;
import 'package:multibook/src/domain/repositories/customer_bookings_repository.dart'
    as _i580;
import 'package:multibook/src/domain/repositories/customer_checkout_repository.dart'
    as _i465;
import 'package:multibook/src/domain/repositories/customer_discovery_repository.dart'
    as _i206;
import 'package:multibook/src/domain/repositories/customer_drafts_repository.dart'
    as _i238;
import 'package:multibook/src/domain/repositories/dashboard_metrics_repository.dart'
    as _i420;
import 'package:multibook/src/domain/repositories/development_seed_repository.dart'
    as _i333;
import 'package:multibook/src/domain/repositories/earnings_metrics_repository.dart'
    as _i553;
import 'package:multibook/src/domain/repositories/in_app_notifications_repository.dart'
    as _i587;
import 'package:multibook/src/domain/repositories/payment_methods_repository.dart'
    as _i784;
import 'package:multibook/src/domain/repositories/promotions_repository.dart'
    as _i622;
import 'package:multibook/src/domain/repositories/provider_bookings_repository.dart'
    as _i696;
import 'package:multibook/src/domain/repositories/recently_viewed_repository.dart'
    as _i840;
import 'package:multibook/src/domain/repositories/reviews_repository.dart'
    as _i155;
import 'package:multibook/src/domain/repositories/saved_business_repository.dart'
    as _i146;
import 'package:multibook/src/domain/repositories/service_availability_repository.dart'
    as _i277;
import 'package:multibook/src/domain/repositories/support_ticket_repository.dart'
    as _i444;
import 'package:multibook/src/domain/repositories/theme_repository.dart'
    as _i119;
import 'package:multibook/src/domain/repositories/users_repository.dart'
    as _i946;
import 'package:multibook/src/domain/use_cases/appointments/cancel_customer_appointment_use_case.dart'
    as _i682;
import 'package:multibook/src/domain/use_cases/appointments/get_available_appointment_slots_use_case.dart'
    as _i123;
import 'package:multibook/src/domain/use_cases/appointments/get_customer_appointments_use_case.dart'
    as _i213;
import 'package:multibook/src/domain/use_cases/appointments/reschedule_customer_appointment_use_case.dart'
    as _i945;
import 'package:multibook/src/domain/use_cases/bookings/cancel_customer_booking_use_case.dart'
    as _i528;
import 'package:multibook/src/domain/use_cases/bookings/get_customer_bookings_use_case.dart'
    as _i498;
import 'package:multibook/src/domain/use_cases/bookings/get_stay_availability_use_case.dart'
    as _i1014;
import 'package:multibook/src/domain/use_cases/businesses/create_business_use_case.dart'
    as _i673;
import 'package:multibook/src/domain/use_cases/businesses/delete_business_use_case.dart'
    as _i517;
import 'package:multibook/src/domain/use_cases/businesses/get_owned_business_use_case.dart'
    as _i829;
import 'package:multibook/src/domain/use_cases/businesses/get_owned_businesses_use_case.dart'
    as _i41;
import 'package:multibook/src/domain/use_cases/businesses/get_selected_business_use_case.dart'
    as _i1063;
import 'package:multibook/src/domain/use_cases/businesses/resolve_business_location_use_case.dart'
    as _i500;
import 'package:multibook/src/domain/use_cases/businesses/update_business_use_case.dart'
    as _i835;
import 'package:multibook/src/domain/use_cases/chat/get_or_create_chat_conversation_use_case.dart'
    as _i469;
import 'package:multibook/src/domain/use_cases/chat/get_unread_messages_count_use_case.dart'
    as _i316;
import 'package:multibook/src/domain/use_cases/chat/mark_chat_as_read_use_case.dart'
    as _i481;
import 'package:multibook/src/domain/use_cases/chat/send_chat_message_use_case.dart'
    as _i575;
import 'package:multibook/src/domain/use_cases/chat/set_chat_presence_use_case.dart'
    as _i919;
import 'package:multibook/src/domain/use_cases/chat/set_chat_typing_use_case.dart'
    as _i203;
import 'package:multibook/src/domain/use_cases/chat/watch_chat_conversation_use_case.dart'
    as _i244;
import 'package:multibook/src/domain/use_cases/chat/watch_chat_conversations_use_case.dart'
    as _i16;
import 'package:multibook/src/domain/use_cases/chat/watch_unread_messages_count_use_case.dart'
    as _i747;
import 'package:multibook/src/domain/use_cases/checkout/create_customer_appointment_use_case.dart'
    as _i776;
import 'package:multibook/src/domain/use_cases/checkout/create_customer_booking_use_case.dart'
    as _i652;
import 'package:multibook/src/domain/use_cases/customer_discovery/get_business_detail_use_case.dart'
    as _i742;
import 'package:multibook/src/domain/use_cases/customer_discovery/get_discovery_cities_use_case.dart'
    as _i343;
import 'package:multibook/src/domain/use_cases/customer_discovery/get_featured_collections_use_case.dart'
    as _i120;
import 'package:multibook/src/domain/use_cases/customer_discovery/get_popular_nearby_businesses_use_case.dart'
    as _i88;
import 'package:multibook/src/domain/use_cases/customer_discovery/get_recommended_stays_use_case.dart'
    as _i554;
import 'package:multibook/src/domain/use_cases/customer_discovery/list_discovery_businesses_use_case.dart'
    as _i436;
import 'package:multibook/src/domain/use_cases/customer_discovery/search_discovery_businesses_use_case.dart'
    as _i540;
import 'package:multibook/src/domain/use_cases/dashboard_metrics/watch_dashboard_metrics_use_case.dart'
    as _i1066;
import 'package:multibook/src/domain/use_cases/development_seed/development_seed_use_case.dart'
    as _i168;
import 'package:multibook/src/domain/use_cases/drafts/delete_appointment_draft_use_case.dart'
    as _i374;
import 'package:multibook/src/domain/use_cases/drafts/delete_booking_draft_use_case.dart'
    as _i300;
import 'package:multibook/src/domain/use_cases/drafts/get_appointment_draft_use_case.dart'
    as _i997;
import 'package:multibook/src/domain/use_cases/drafts/get_booking_draft_use_case.dart'
    as _i104;
import 'package:multibook/src/domain/use_cases/drafts/save_appointment_draft_use_case.dart'
    as _i811;
import 'package:multibook/src/domain/use_cases/drafts/save_booking_draft_use_case.dart'
    as _i305;
import 'package:multibook/src/domain/use_cases/earnings/watch_earnings_metrics_use_case.dart'
    as _i427;
import 'package:multibook/src/domain/use_cases/notifications/get_in_app_notifications_use_case.dart'
    as _i569;
import 'package:multibook/src/domain/use_cases/notifications/get_unread_notifications_count_use_case.dart'
    as _i884;
import 'package:multibook/src/domain/use_cases/notifications/mark_in_app_notification_as_read_use_case.dart'
    as _i859;
import 'package:multibook/src/domain/use_cases/notifications/register_notification_device_use_case.dart'
    as _i801;
import 'package:multibook/src/domain/use_cases/notifications/unregister_notification_device_use_case.dart'
    as _i154;
import 'package:multibook/src/domain/use_cases/payment_methods/delete_payment_method_use_case.dart'
    as _i721;
import 'package:multibook/src/domain/use_cases/payment_methods/get_payment_methods_use_case.dart'
    as _i64;
import 'package:multibook/src/domain/use_cases/payment_methods/save_payment_method_use_case.dart'
    as _i457;
import 'package:multibook/src/domain/use_cases/payment_methods/set_default_payment_method_use_case.dart'
    as _i478;
import 'package:multibook/src/domain/use_cases/promotions/create_promotion_use_case.dart'
    as _i840;
import 'package:multibook/src/domain/use_cases/promotions/delete_promotion_use_case.dart'
    as _i843;
import 'package:multibook/src/domain/use_cases/promotions/get_active_promotion_use_case.dart'
    as _i356;
import 'package:multibook/src/domain/use_cases/promotions/get_business_promotions_use_case.dart'
    as _i759;
import 'package:multibook/src/domain/use_cases/promotions/set_promotion_active_use_case.dart'
    as _i716;
import 'package:multibook/src/domain/use_cases/provider_bookings/get_provider_appointments_use_case.dart'
    as _i308;
import 'package:multibook/src/domain/use_cases/provider_bookings/get_provider_bookings_use_case.dart'
    as _i253;
import 'package:multibook/src/domain/use_cases/provider_bookings/update_provider_appointment_status_use_case.dart'
    as _i193;
import 'package:multibook/src/domain/use_cases/provider_bookings/update_provider_booking_status_use_case.dart'
    as _i84;
import 'package:multibook/src/domain/use_cases/recently_viewed/get_recently_viewed_businesses_use_case.dart'
    as _i119;
import 'package:multibook/src/domain/use_cases/recently_viewed/record_recently_viewed_use_case.dart'
    as _i725;
import 'package:multibook/src/domain/use_cases/reviews/create_review_use_case.dart'
    as _i68;
import 'package:multibook/src/domain/use_cases/reviews/get_business_reviews_use_case.dart'
    as _i250;
import 'package:multibook/src/domain/use_cases/reviews/has_business_review_use_case.dart'
    as _i857;
import 'package:multibook/src/domain/use_cases/saved/get_saved_businesses_use_case.dart'
    as _i883;
import 'package:multibook/src/domain/use_cases/saved/is_business_saved_use_case.dart'
    as _i691;
import 'package:multibook/src/domain/use_cases/saved/remove_saved_business_use_case.dart'
    as _i626;
import 'package:multibook/src/domain/use_cases/saved/save_business_use_case.dart'
    as _i876;
import 'package:multibook/src/domain/use_cases/service_availability/create_service_availability_block_use_case.dart'
    as _i368;
import 'package:multibook/src/domain/use_cases/service_availability/delete_service_availability_block_use_case.dart'
    as _i934;
import 'package:multibook/src/domain/use_cases/service_availability/get_service_availability_blocks_use_case.dart'
    as _i202;
import 'package:multibook/src/domain/use_cases/support_tickets/create_support_ticket_use_case.dart'
    as _i958;
import 'package:multibook/src/domain/use_cases/support_tickets/get_support_tickets_use_case.dart'
    as _i206;
import 'package:multibook/src/domain/use_cases/theme/get_theme_mode_use_case.dart'
    as _i43;
import 'package:multibook/src/domain/use_cases/theme/set_theme_mode_use_case.dart'
    as _i11;
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
import 'package:multibook/src/features/shared/notifications/cubit/notification_bell_cubit.dart'
    as _i617;
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
import 'package:multibook/src/features/shared/theme/cubit/theme_cubit.dart'
    as _i844;
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
    gh.lazySingleton<_i411.RestRepositoryExecutor>(
      () => _i411.RestRepositoryExecutor(),
    );
    gh.lazySingleton<_i950.RecentlyViewedUpdatesService>(
      () => _i950.RecentlyViewedUpdatesService(),
    );
    gh.lazySingleton<_i167.SavedBusinessUpdatesService>(
      () => _i167.SavedBusinessUpdatesService(),
    );
    gh.lazySingleton<_i1025.SessionStreamRegistry>(
      () => _i1025.SessionStreamRegistry(),
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
    gh.singleton<_i892.FirebaseMessaging>(
      () => firebaseModule.firebaseMessaging(gh<_i982.FirebaseApp>()),
    );
    gh.lazySingleton<_i234.ApiClient>(
      () => _i234.ApiClient(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i715.AuthenticationDataSource>(
      () => _i715.AuthenticationDataSourceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i665.StaySearchDataSource>(
      () => _i665.StaySearchDataSourceImpl(gh<_i234.ApiClient>()),
    );
    gh.factory<_i400.OnboardingCubit>(
      () => _i400.OnboardingCubit(gh<_i38.OnboardingRepository>()),
    );
    gh.lazySingleton<_i889.LocaleCubit>(
      () => _i889.LocaleCubit(gh<_i724.LocaleRepository>()),
    );
    gh.lazySingleton<_i486.SseClient>(
      () => _i486.SseClient(gh<_i234.ApiClient>()),
    );
    gh.lazySingleton<_i145.SupportTicketApiDataSource>(
      () => _i145.SupportTicketApiDataSource(gh<_i234.ApiClient>()),
    );
    gh.lazySingleton<_i176.PaymentMethodsApiDataSource>(
      () => _i176.PaymentMethodsApiDataSource(gh<_i234.ApiClient>()),
    );
    gh.lazySingleton<_i433.ServiceAvailabilityApiDataSource>(
      () => _i433.ServiceAvailabilityApiDataSource(gh<_i234.ApiClient>()),
    );
    gh.lazySingleton<_i563.CustomerCheckoutApiDataSource>(
      () => _i563.CustomerCheckoutApiDataSource(gh<_i234.ApiClient>()),
    );
    gh.lazySingleton<_i217.InAppNotificationsApiDataSource>(
      () => _i217.InAppNotificationsApiDataSource(gh<_i234.ApiClient>()),
    );
    gh.lazySingleton<_i218.PromotionsApiDataSource>(
      () => _i218.PromotionsApiDataSource(gh<_i234.ApiClient>()),
    );
    gh.lazySingleton<_i651.ProviderBookingsApiDataSource>(
      () => _i651.ProviderBookingsApiDataSource(gh<_i234.ApiClient>()),
    );
    gh.lazySingleton<_i264.CustomerAppointmentsApiDataSource>(
      () => _i264.CustomerAppointmentsApiDataSource(gh<_i234.ApiClient>()),
    );
    gh.lazySingleton<_i488.CustomerBookingsApiDataSource>(
      () => _i488.CustomerBookingsApiDataSource(gh<_i234.ApiClient>()),
    );
    gh.lazySingleton<_i82.DevelopmentSeedApiDataSource>(
      () => _i82.DevelopmentSeedApiDataSource(gh<_i234.ApiClient>()),
    );
    gh.lazySingleton<_i119.ThemeRepository>(
      () => _i1006.ThemeRepositoryImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i941.BusinessLocationRepository>(
      () =>
          _i909.BusinessLocationRepositoryImpl(gh<_i117.NominatimDataSource>()),
    );
    gh.lazySingleton<_i1001.StaySearchRepository>(
      () => _i1001.StaySearchRepository(gh<_i665.StaySearchDataSource>()),
    );
    gh.lazySingleton<_i622.PromotionsRepository>(
      () => _i122.PromotionsRepositoryImpl(
        gh<_i218.PromotionsApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.lazySingleton<_i190.NotificationDataSource>(
      () => _i190.NotificationDataSourceImpl(gh<_i892.FirebaseMessaging>()),
    );
    gh.lazySingleton<_i784.PaymentMethodsRepository>(
      () => _i875.PaymentMethodsRepositoryImpl(
        gh<_i176.PaymentMethodsApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.lazySingleton<_i594.FirebaseStorageDataSource>(
      () => _i594.FirebaseStorageDataSourceImpl(gh<_i457.FirebaseStorage>()),
    );
    gh.lazySingleton<_i965.DashboardMetricsApiDataSource>(
      () => _i965.DashboardMetricsApiDataSource(gh<_i486.SseClient>()),
    );
    gh.lazySingleton<_i449.EarningsMetricsApiDataSource>(
      () => _i449.EarningsMetricsApiDataSource(gh<_i486.SseClient>()),
    );
    gh.lazySingleton<_i696.ProviderBookingsRepository>(
      () => _i656.ProviderBookingsRepositoryImpl(
        gh<_i651.ProviderBookingsApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.factory<_i84.UpdateProviderBookingStatusUseCase>(
      () => _i84.UpdateProviderBookingStatusUseCase(
        gh<_i696.ProviderBookingsRepository>(),
      ),
    );
    gh.factory<_i308.GetProviderAppointmentsUseCase>(
      () => _i308.GetProviderAppointmentsUseCase(
        gh<_i696.ProviderBookingsRepository>(),
      ),
    );
    gh.factory<_i253.GetProviderBookingsUseCase>(
      () => _i253.GetProviderBookingsUseCase(
        gh<_i696.ProviderBookingsRepository>(),
      ),
    );
    gh.factory<_i193.UpdateProviderAppointmentStatusUseCase>(
      () => _i193.UpdateProviderAppointmentStatusUseCase(
        gh<_i696.ProviderBookingsRepository>(),
      ),
    );
    gh.factory<_i64.GetPaymentMethodsUseCase>(
      () => _i64.GetPaymentMethodsUseCase(gh<_i784.PaymentMethodsRepository>()),
    );
    gh.factory<_i721.DeletePaymentMethodUseCase>(
      () => _i721.DeletePaymentMethodUseCase(
        gh<_i784.PaymentMethodsRepository>(),
      ),
    );
    gh.factory<_i457.SavePaymentMethodUseCase>(
      () =>
          _i457.SavePaymentMethodUseCase(gh<_i784.PaymentMethodsRepository>()),
    );
    gh.factory<_i478.SetDefaultPaymentMethodUseCase>(
      () => _i478.SetDefaultPaymentMethodUseCase(
        gh<_i784.PaymentMethodsRepository>(),
      ),
    );
    gh.factory<_i113.ExploreStayResultsCubit>(
      () => _i113.ExploreStayResultsCubit(gh<_i1001.StaySearchRepository>()),
    );
    gh.lazySingleton<_i465.CustomerCheckoutRepository>(
      () => _i865.CustomerCheckoutRepositoryImpl(
        gh<_i563.CustomerCheckoutApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.factory<_i500.ResolveBusinessLocationUseCase>(
      () => _i500.ResolveBusinessLocationUseCase(
        gh<_i941.BusinessLocationRepository>(),
      ),
    );
    gh.lazySingleton<_i333.DevelopmentSeedRepository>(
      () => _i795.DevelopmentSeedRepositoryImpl(
        gh<_i82.DevelopmentSeedApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.lazySingleton<_i127.CustomerDraftsApiDataSource>(
      () => _i127.CustomerDraftsApiDataSource(
        gh<_i234.ApiClient>(),
        gh<_i594.FirebaseStorageDataSource>(),
      ),
    );
    gh.lazySingleton<_i920.SavedBusinessApiDataSource>(
      () => _i920.SavedBusinessApiDataSource(
        gh<_i234.ApiClient>(),
        gh<_i594.FirebaseStorageDataSource>(),
      ),
    );
    gh.lazySingleton<_i677.CustomerDiscoveryApiDataSource>(
      () => _i677.CustomerDiscoveryApiDataSource(
        gh<_i234.ApiClient>(),
        gh<_i594.FirebaseStorageDataSource>(),
      ),
    );
    gh.lazySingleton<_i411.ReviewsApiDataSource>(
      () => _i411.ReviewsApiDataSource(
        gh<_i234.ApiClient>(),
        gh<_i594.FirebaseStorageDataSource>(),
      ),
    );
    gh.lazySingleton<_i236.RecentlyViewedApiDataSource>(
      () => _i236.RecentlyViewedApiDataSource(
        gh<_i234.ApiClient>(),
        gh<_i594.FirebaseStorageDataSource>(),
      ),
    );
    gh.lazySingleton<_i206.CustomerDiscoveryRepository>(
      () => _i614.CustomerDiscoveryRepositoryImpl(
        gh<_i677.CustomerDiscoveryApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.lazySingleton<_i840.RecentlyViewedRepository>(
      () => _i186.RecentlyViewedRepositoryImpl(
        gh<_i236.RecentlyViewedApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.lazySingleton<_i768.BusinessesApiDataSource>(
      () => _i768.BusinessesApiDataSource(
        gh<_i234.ApiClient>(),
        gh<_i594.FirebaseStorageDataSource>(),
      ),
    );
    gh.lazySingleton<_i364.UsersApiDataSource>(
      () => _i364.UsersApiDataSource(
        gh<_i234.ApiClient>(),
        gh<_i594.FirebaseStorageDataSource>(),
      ),
    );
    gh.factory<_i108.PaymentMethodsCubit>(
      () => _i108.PaymentMethodsCubit(
        gh<_i64.GetPaymentMethodsUseCase>(),
        gh<_i457.SavePaymentMethodUseCase>(),
        gh<_i721.DeletePaymentMethodUseCase>(),
        gh<_i478.SetDefaultPaymentMethodUseCase>(),
      ),
    );
    gh.factory<_i725.RecordRecentlyViewedUseCase>(
      () => _i725.RecordRecentlyViewedUseCase(
        gh<_i840.RecentlyViewedRepository>(),
      ),
    );
    gh.factory<_i119.GetRecentlyViewedBusinessesUseCase>(
      () => _i119.GetRecentlyViewedBusinessesUseCase(
        gh<_i840.RecentlyViewedRepository>(),
      ),
    );
    gh.lazySingleton<_i139.ServiceSearchDataSource>(
      () => _i139.ServiceSearchDataSourceImpl(gh<_i234.ApiClient>()),
    );
    gh.lazySingleton<_i444.SupportTicketRepository>(
      () => _i295.SupportTicketRepositoryImpl(
        gh<_i145.SupportTicketApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.lazySingleton<_i553.EarningsMetricsRepository>(
      () => _i318.EarningsMetricsRepositoryImpl(
        gh<_i449.EarningsMetricsApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.factory<_i716.SetPromotionActiveUseCase>(
      () => _i716.SetPromotionActiveUseCase(gh<_i622.PromotionsRepository>()),
    );
    gh.factory<_i840.CreatePromotionUseCase>(
      () => _i840.CreatePromotionUseCase(gh<_i622.PromotionsRepository>()),
    );
    gh.factory<_i843.DeletePromotionUseCase>(
      () => _i843.DeletePromotionUseCase(gh<_i622.PromotionsRepository>()),
    );
    gh.factory<_i759.GetBusinessPromotionsUseCase>(
      () =>
          _i759.GetBusinessPromotionsUseCase(gh<_i622.PromotionsRepository>()),
    );
    gh.factory<_i356.GetActivePromotionUseCase>(
      () => _i356.GetActivePromotionUseCase(gh<_i622.PromotionsRepository>()),
    );
    gh.factory<_i427.WatchEarningsMetricsUseCase>(
      () => _i427.WatchEarningsMetricsUseCase(
        gh<_i553.EarningsMetricsRepository>(),
      ),
    );
    gh.lazySingleton<_i580.CustomerBookingsRepository>(
      () => _i609.CustomerBookingsRepositoryImpl(
        gh<_i488.CustomerBookingsApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.lazySingleton<_i277.ServiceAvailabilityRepository>(
      () => _i155.ServiceAvailabilityRepositoryImpl(
        gh<_i433.ServiceAvailabilityApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.lazySingleton<_i884.CustomerAppointmentsRepository>(
      () => _i122.CustomerAppointmentsRepositoryImpl(
        gh<_i264.CustomerAppointmentsApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.lazySingleton<_i587.InAppNotificationsRepository>(
      () => _i367.InAppNotificationsRepositoryImpl(
        gh<_i217.InAppNotificationsApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.lazySingleton<_i459.ServiceSearchRepository>(
      () => _i459.ServiceSearchRepository(gh<_i139.ServiceSearchDataSource>()),
    );
    gh.lazySingleton<_i69.ChatApiDataSource>(
      () =>
          _i69.ChatApiDataSource(gh<_i234.ApiClient>(), gh<_i486.SseClient>()),
    );
    gh.lazySingleton<_i686.BusinessDeletionRepository>(
      () => _i366.BusinessDeletionRepositoryImpl(
        gh<_i768.BusinessesApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.lazySingleton<_i146.SavedBusinessRepository>(
      () => _i475.SavedBusinessRepositoryImpl(
        gh<_i920.SavedBusinessApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.factory<_i1014.GetStayAvailabilityUseCase>(
      () => _i1014.GetStayAvailabilityUseCase(
        gh<_i580.CustomerBookingsRepository>(),
      ),
    );
    gh.factory<_i498.GetCustomerBookingsUseCase>(
      () => _i498.GetCustomerBookingsUseCase(
        gh<_i580.CustomerBookingsRepository>(),
      ),
    );
    gh.factory<_i528.CancelCustomerBookingUseCase>(
      () => _i528.CancelCustomerBookingUseCase(
        gh<_i580.CustomerBookingsRepository>(),
      ),
    );
    gh.factory<_i168.DevelopmentSeedUseCase>(
      () => _i168.DevelopmentSeedUseCase(gh<_i333.DevelopmentSeedRepository>()),
    );
    gh.lazySingleton<_i197.BusinessesRepository>(
      () => _i48.BusinessesRepositoryImpl(
        gh<_i768.BusinessesApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.factory<_i554.GetRecommendedStaysUseCase>(
      () => _i554.GetRecommendedStaysUseCase(
        gh<_i206.CustomerDiscoveryRepository>(),
      ),
    );
    gh.factory<_i120.GetFeaturedCollectionsUseCase>(
      () => _i120.GetFeaturedCollectionsUseCase(
        gh<_i206.CustomerDiscoveryRepository>(),
      ),
    );
    gh.factory<_i540.SearchDiscoveryBusinessesUseCase>(
      () => _i540.SearchDiscoveryBusinessesUseCase(
        gh<_i206.CustomerDiscoveryRepository>(),
      ),
    );
    gh.factory<_i343.GetDiscoveryCitiesUseCase>(
      () => _i343.GetDiscoveryCitiesUseCase(
        gh<_i206.CustomerDiscoveryRepository>(),
      ),
    );
    gh.factory<_i88.GetPopularNearbyBusinessesUseCase>(
      () => _i88.GetPopularNearbyBusinessesUseCase(
        gh<_i206.CustomerDiscoveryRepository>(),
      ),
    );
    gh.factory<_i436.ListDiscoveryBusinessesUseCase>(
      () => _i436.ListDiscoveryBusinessesUseCase(
        gh<_i206.CustomerDiscoveryRepository>(),
      ),
    );
    gh.lazySingleton<_i742.GetBusinessDetailUseCase>(
      () => _i742.GetBusinessDetailUseCase(
        gh<_i206.CustomerDiscoveryRepository>(),
      ),
    );
    gh.factory<_i11.SetThemeModeUseCase>(
      () => _i11.SetThemeModeUseCase(gh<_i119.ThemeRepository>()),
    );
    gh.factory<_i43.GetThemeModeUseCase>(
      () => _i43.GetThemeModeUseCase(gh<_i119.ThemeRepository>()),
    );
    gh.factory<_i829.GetOwnedBusinessUseCase>(
      () => _i829.GetOwnedBusinessUseCase(gh<_i197.BusinessesRepository>()),
    );
    gh.factory<_i673.CreateBusinessUseCase>(
      () => _i673.CreateBusinessUseCase(gh<_i197.BusinessesRepository>()),
    );
    gh.factory<_i835.UpdateBusinessUseCase>(
      () => _i835.UpdateBusinessUseCase(gh<_i197.BusinessesRepository>()),
    );
    gh.lazySingleton<_i41.GetOwnedBusinessesUseCase>(
      () => _i41.GetOwnedBusinessesUseCase(gh<_i197.BusinessesRepository>()),
    );
    gh.lazySingleton<_i420.DashboardMetricsRepository>(
      () => _i489.DashboardMetricsRepositoryImpl(
        gh<_i965.DashboardMetricsApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.factory<_i206.GetSupportTicketsUseCase>(
      () => _i206.GetSupportTicketsUseCase(gh<_i444.SupportTicketRepository>()),
    );
    gh.factory<_i958.CreateSupportTicketUseCase>(
      () =>
          _i958.CreateSupportTicketUseCase(gh<_i444.SupportTicketRepository>()),
    );
    gh.factory<_i776.CreateCustomerAppointmentUseCase>(
      () => _i776.CreateCustomerAppointmentUseCase(
        gh<_i465.CustomerCheckoutRepository>(),
      ),
    );
    gh.factory<_i652.CreateCustomerBookingUseCase>(
      () => _i652.CreateCustomerBookingUseCase(
        gh<_i465.CustomerCheckoutRepository>(),
      ),
    );
    gh.lazySingleton<_i946.UsersRepository>(
      () => _i595.UsersRepositoryImpl(
        gh<_i364.UsersApiDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.factory<_i517.DeleteBusinessUseCase>(
      () => _i517.DeleteBusinessUseCase(gh<_i686.BusinessDeletionRepository>()),
    );
    gh.lazySingleton<_i692.ChatRepository>(
      () => _i574.ChatRepositoryImpl(
        gh<_i69.ChatApiDataSource>(),
        gh<_i594.FirebaseStorageDataSource>(),
        gh<_i411.RestRepositoryExecutor>(),
      ),
    );
    gh.factory<_i455.BookingPromotionCubit>(
      () => _i455.BookingPromotionCubit(gh<_i356.GetActivePromotionUseCase>()),
    );
    gh.factory<_i305.AppointmentPromotionCubit>(
      () => _i305.AppointmentPromotionCubit(
        gh<_i356.GetActivePromotionUseCase>(),
      ),
    );
    gh.lazySingleton<_i155.ReviewsRepository>(
      () => _i824.ReviewsRepositoryImpl(
        gh<_i411.ReviewsApiDataSource>(),
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
    gh.factory<_i682.CancelCustomerAppointmentUseCase>(
      () => _i682.CancelCustomerAppointmentUseCase(
        gh<_i884.CustomerAppointmentsRepository>(),
      ),
    );
    gh.factory<_i213.GetCustomerAppointmentsUseCase>(
      () => _i213.GetCustomerAppointmentsUseCase(
        gh<_i884.CustomerAppointmentsRepository>(),
      ),
    );
    gh.factory<_i123.GetAvailableAppointmentSlotsUseCase>(
      () => _i123.GetAvailableAppointmentSlotsUseCase(
        gh<_i884.CustomerAppointmentsRepository>(),
      ),
    );
    gh.factory<_i945.RescheduleCustomerAppointmentUseCase>(
      () => _i945.RescheduleCustomerAppointmentUseCase(
        gh<_i884.CustomerAppointmentsRepository>(),
      ),
    );
    gh.factory<_i691.IsBusinessSavedUseCase>(
      () => _i691.IsBusinessSavedUseCase(gh<_i146.SavedBusinessRepository>()),
    );
    gh.factory<_i626.RemoveSavedBusinessUseCase>(
      () =>
          _i626.RemoveSavedBusinessUseCase(gh<_i146.SavedBusinessRepository>()),
    );
    gh.factory<_i876.SaveBusinessUseCase>(
      () => _i876.SaveBusinessUseCase(gh<_i146.SavedBusinessRepository>()),
    );
    gh.factory<_i883.GetSavedBusinessesUseCase>(
      () =>
          _i883.GetSavedBusinessesUseCase(gh<_i146.SavedBusinessRepository>()),
    );
    gh.factory<_i806.SupportTicketsCubit>(
      () => _i806.SupportTicketsCubit(gh<_i206.GetSupportTicketsUseCase>()),
    );
    gh.factory<_i1053.CreatePromotionCubit>(
      () => _i1053.CreatePromotionCubit(gh<_i840.CreatePromotionUseCase>()),
    );
    gh.factory<_i948.SavedCubit>(
      () => _i948.SavedCubit(
        gh<_i883.GetSavedBusinessesUseCase>(),
        gh<_i626.RemoveSavedBusinessUseCase>(),
        gh<_i167.SavedBusinessUpdatesService>(),
      ),
    );
    gh.factory<_i1066.WatchDashboardMetricsUseCase>(
      () => _i1066.WatchDashboardMetricsUseCase(
        gh<_i420.DashboardMetricsRepository>(),
      ),
    );
    gh.factory<_i378.CustomerSearchCubit>(
      () => _i378.CustomerSearchCubit(
        gh<_i540.SearchDiscoveryBusinessesUseCase>(),
      ),
    );
    gh.lazySingleton<_i844.ThemeCubit>(
      () => _i844.ThemeCubit(
        gh<_i43.GetThemeModeUseCase>(),
        gh<_i11.SetThemeModeUseCase>(),
      ),
    );
    gh.factory<_i857.HasBusinessReviewUseCase>(
      () => _i857.HasBusinessReviewUseCase(gh<_i155.ReviewsRepository>()),
    );
    gh.factory<_i250.GetBusinessReviewsUseCase>(
      () => _i250.GetBusinessReviewsUseCase(gh<_i155.ReviewsRepository>()),
    );
    gh.factory<_i68.CreateReviewUseCase>(
      () => _i68.CreateReviewUseCase(gh<_i155.ReviewsRepository>()),
    );
    gh.factory<_i751.RecentlyViewedCubit>(
      () => _i751.RecentlyViewedCubit(
        gh<_i119.GetRecentlyViewedBusinessesUseCase>(),
        gh<_i950.RecentlyViewedUpdatesService>(),
      ),
    );
    gh.factory<_i428.RecentlyViewedServicesCubit>(
      () => _i428.RecentlyViewedServicesCubit(
        gh<_i119.GetRecentlyViewedBusinessesUseCase>(),
        gh<_i950.RecentlyViewedUpdatesService>(),
      ),
    );
    gh.factory<_i203.SetChatTypingUseCase>(
      () => _i203.SetChatTypingUseCase(gh<_i692.ChatRepository>()),
    );
    gh.factory<_i16.WatchChatConversationsUseCase>(
      () => _i16.WatchChatConversationsUseCase(gh<_i692.ChatRepository>()),
    );
    gh.factory<_i469.GetOrCreateChatConversationUseCase>(
      () =>
          _i469.GetOrCreateChatConversationUseCase(gh<_i692.ChatRepository>()),
    );
    gh.factory<_i244.WatchChatConversationUseCase>(
      () => _i244.WatchChatConversationUseCase(gh<_i692.ChatRepository>()),
    );
    gh.factory<_i747.WatchUnreadMessagesCountUseCase>(
      () => _i747.WatchUnreadMessagesCountUseCase(gh<_i692.ChatRepository>()),
    );
    gh.factory<_i919.SetChatPresenceUseCase>(
      () => _i919.SetChatPresenceUseCase(gh<_i692.ChatRepository>()),
    );
    gh.factory<_i481.MarkChatAsReadUseCase>(
      () => _i481.MarkChatAsReadUseCase(gh<_i692.ChatRepository>()),
    );
    gh.factory<_i316.GetUnreadMessagesCountUseCase>(
      () => _i316.GetUnreadMessagesCountUseCase(gh<_i692.ChatRepository>()),
    );
    gh.factory<_i575.SendChatMessageUseCase>(
      () => _i575.SendChatMessageUseCase(gh<_i692.ChatRepository>()),
    );
    gh.lazySingleton<_i981.UserProfileUseCase>(
      () => _i981.UserProfileUseCase(
        gh<_i715.AuthenticationDataSource>(),
        gh<_i594.FirebaseStorageDataSource>(),
        gh<_i946.UsersRepository>(),
      ),
    );
    gh.factory<_i702.ServiceDetailCubit>(
      () => _i702.ServiceDetailCubit(
        gh<_i742.GetBusinessDetailUseCase>(),
        gh<_i691.IsBusinessSavedUseCase>(),
        gh<_i876.SaveBusinessUseCase>(),
        gh<_i626.RemoveSavedBusinessUseCase>(),
        gh<_i167.SavedBusinessUpdatesService>(),
        gh<_i725.RecordRecentlyViewedUseCase>(),
        gh<_i950.RecentlyViewedUpdatesService>(),
        gh<_i250.GetBusinessReviewsUseCase>(),
      ),
    );
    gh.factory<_i648.StayDetailCubit>(
      () => _i648.StayDetailCubit(
        gh<_i742.GetBusinessDetailUseCase>(),
        gh<_i691.IsBusinessSavedUseCase>(),
        gh<_i876.SaveBusinessUseCase>(),
        gh<_i626.RemoveSavedBusinessUseCase>(),
        gh<_i167.SavedBusinessUpdatesService>(),
        gh<_i725.RecordRecentlyViewedUseCase>(),
        gh<_i950.RecentlyViewedUpdatesService>(),
        gh<_i250.GetBusinessReviewsUseCase>(),
      ),
    );
    gh.factory<_i859.MarkInAppNotificationAsReadUseCase>(
      () => _i859.MarkInAppNotificationAsReadUseCase(
        gh<_i587.InAppNotificationsRepository>(),
      ),
    );
    gh.factory<_i569.GetInAppNotificationsUseCase>(
      () => _i569.GetInAppNotificationsUseCase(
        gh<_i587.InAppNotificationsRepository>(),
      ),
    );
    gh.factory<_i801.RegisterNotificationDeviceUseCase>(
      () => _i801.RegisterNotificationDeviceUseCase(
        gh<_i587.InAppNotificationsRepository>(),
      ),
    );
    gh.factory<_i154.UnregisterNotificationDeviceUseCase>(
      () => _i154.UnregisterNotificationDeviceUseCase(
        gh<_i587.InAppNotificationsRepository>(),
      ),
    );
    gh.factory<_i884.GetUnreadNotificationsCountUseCase>(
      () => _i884.GetUnreadNotificationsCountUseCase(
        gh<_i587.InAppNotificationsRepository>(),
      ),
    );
    gh.factory<_i368.CreateServiceAvailabilityBlockUseCase>(
      () => _i368.CreateServiceAvailabilityBlockUseCase(
        gh<_i277.ServiceAvailabilityRepository>(),
      ),
    );
    gh.factory<_i202.GetServiceAvailabilityBlocksUseCase>(
      () => _i202.GetServiceAvailabilityBlocksUseCase(
        gh<_i277.ServiceAvailabilityRepository>(),
      ),
    );
    gh.factory<_i934.DeleteServiceAvailabilityBlockUseCase>(
      () => _i934.DeleteServiceAvailabilityBlockUseCase(
        gh<_i277.ServiceAvailabilityRepository>(),
      ),
    );
    gh.factory<_i428.EarningsCubit>(
      () => _i428.EarningsCubit(
        gh<_i981.UserProfileUseCase>(),
        gh<_i41.GetOwnedBusinessesUseCase>(),
        gh<_i829.GetOwnedBusinessUseCase>(),
        gh<_i427.WatchEarningsMetricsUseCase>(),
        gh<_i1025.SessionStreamRegistry>(),
      ),
    );
    gh.factory<_i1005.ChatListCubit>(
      () => _i1005.ChatListCubit(gh<_i16.WatchChatConversationsUseCase>()),
    );
    gh.factory<_i1063.GetSelectedBusinessUseCase>(
      () => _i1063.GetSelectedBusinessUseCase(
        gh<_i829.GetOwnedBusinessUseCase>(),
      ),
    );
    gh.factory<_i442.ExploreServiceResultsCubit>(
      () =>
          _i442.ExploreServiceResultsCubit(gh<_i459.ServiceSearchRepository>()),
    );
    gh.lazySingleton<_i682.UserLocationRepository>(
      () => _i682.UserLocationRepository(
        gh<_i397.DeviceLocationDataSource>(),
        gh<_i117.NominatimDataSource>(),
        gh<_i981.UserProfileUseCase>(),
      ),
    );
    gh.factory<_i496.AppointmentAvailabilityCubit>(
      () => _i496.AppointmentAvailabilityCubit(
        gh<_i123.GetAvailableAppointmentSlotsUseCase>(),
      ),
    );
    gh.factory<_i272.NotificationsCubit>(
      () => _i272.NotificationsCubit(
        gh<_i569.GetInAppNotificationsUseCase>(),
        gh<_i859.MarkInAppNotificationAsReadUseCase>(),
      ),
    );
    gh.factory<_i212.CustomerBookingsCubit>(
      () => _i212.CustomerBookingsCubit(
        gh<_i498.GetCustomerBookingsUseCase>(),
        gh<_i213.GetCustomerAppointmentsUseCase>(),
      ),
    );
    gh.factory<_i974.CreateSupportTicketCubit>(
      () => _i974.CreateSupportTicketCubit(
        gh<_i958.CreateSupportTicketUseCase>(),
      ),
    );
    gh.factory<_i269.RescheduleAppointmentCubit>(
      () => _i269.RescheduleAppointmentCubit(
        gh<_i945.RescheduleCustomerAppointmentUseCase>(),
      ),
    );
    gh.factory<_i874.AppointmentDetailsCubit>(
      () => _i874.AppointmentDetailsCubit(
        gh<_i742.GetBusinessDetailUseCase>(),
        gh<_i682.CancelCustomerAppointmentUseCase>(),
        gh<_i857.HasBusinessReviewUseCase>(),
      ),
    );
    gh.factory<_i190.UserTypeCheckerCubit>(
      () => _i190.UserTypeCheckerCubit(gh<_i919.UpdateUserRoleUseCase>()),
    );
    gh.factory<_i134.UserLocationCubit>(
      () => _i134.UserLocationCubit(gh<_i682.UserLocationRepository>()),
    );
    gh.factory<_i152.ChatConversationCubit>(
      () => _i152.ChatConversationCubit(
        gh<_i469.GetOrCreateChatConversationUseCase>(),
        gh<_i244.WatchChatConversationUseCase>(),
        gh<_i575.SendChatMessageUseCase>(),
        gh<_i481.MarkChatAsReadUseCase>(),
        gh<_i203.SetChatTypingUseCase>(),
        gh<_i919.SetChatPresenceUseCase>(),
        gh<_i981.UserProfileUseCase>(),
      ),
    );
    gh.factory<_i300.DeleteBookingDraftUseCase>(
      () =>
          _i300.DeleteBookingDraftUseCase(gh<_i238.CustomerDraftsRepository>()),
    );
    gh.factory<_i305.SaveBookingDraftUseCase>(
      () => _i305.SaveBookingDraftUseCase(gh<_i238.CustomerDraftsRepository>()),
    );
    gh.factory<_i104.GetBookingDraftUseCase>(
      () => _i104.GetBookingDraftUseCase(gh<_i238.CustomerDraftsRepository>()),
    );
    gh.factory<_i374.DeleteAppointmentDraftUseCase>(
      () => _i374.DeleteAppointmentDraftUseCase(
        gh<_i238.CustomerDraftsRepository>(),
      ),
    );
    gh.factory<_i997.GetAppointmentDraftUseCase>(
      () => _i997.GetAppointmentDraftUseCase(
        gh<_i238.CustomerDraftsRepository>(),
      ),
    );
    gh.factory<_i811.SaveAppointmentDraftUseCase>(
      () => _i811.SaveAppointmentDraftUseCase(
        gh<_i238.CustomerDraftsRepository>(),
      ),
    );
    gh.factory<_i925.ManageCatalogCubit>(
      () => _i925.ManageCatalogCubit(
        gh<_i981.UserProfileUseCase>(),
        gh<_i1063.GetSelectedBusinessUseCase>(),
        gh<_i835.UpdateBusinessUseCase>(),
      ),
    );
    gh.factory<_i51.PromotionsCubit>(
      () => _i51.PromotionsCubit(
        gh<_i41.GetOwnedBusinessesUseCase>(),
        gh<_i981.UserProfileUseCase>(),
        gh<_i759.GetBusinessPromotionsUseCase>(),
        gh<_i716.SetPromotionActiveUseCase>(),
        gh<_i843.DeletePromotionUseCase>(),
      ),
    );
    gh.factory<_i328.AccountSettingsCubit>(
      () => _i328.AccountSettingsCubit(
        gh<_i981.UserProfileUseCase>(),
        gh<_i157.ImagePickerDataSource>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i730.NotificationDeviceService>(
      () => _i730.NotificationDeviceService(
        gh<_i715.AuthenticationDataSource>(),
        gh<_i190.NotificationDataSource>(),
        gh<_i801.RegisterNotificationDeviceUseCase>(),
        gh<_i154.UnregisterNotificationDeviceUseCase>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i972.DashboardCubit>(
      () => _i972.DashboardCubit(
        gh<_i981.UserProfileUseCase>(),
        gh<_i1063.GetSelectedBusinessUseCase>(),
        gh<_i1066.WatchDashboardMetricsUseCase>(),
        gh<_i1025.SessionStreamRegistry>(),
      ),
    );
    gh.factory<_i115.RateBusinessCubit>(
      () => _i115.RateBusinessCubit(gh<_i68.CreateReviewUseCase>()),
    );
    gh.factory<_i617.NotificationBellCubit>(
      () => _i617.NotificationBellCubit(
        gh<_i884.GetUnreadNotificationsCountUseCase>(),
        gh<_i730.NotificationDeviceService>(),
      ),
    );
    gh.factory<_i247.ClientEntryCubit>(
      () => _i247.ClientEntryCubit(
        gh<_i1063.GetSelectedBusinessUseCase>(),
        gh<_i981.UserProfileUseCase>(),
      ),
    );
    gh.factory<_i227.ExploreCubit>(
      () => _i227.ExploreCubit(
        gh<_i981.UserProfileUseCase>(),
        gh<_i343.GetDiscoveryCitiesUseCase>(),
        gh<_i120.GetFeaturedCollectionsUseCase>(),
        gh<_i88.GetPopularNearbyBusinessesUseCase>(),
      ),
    );
    gh.factory<_i823.BookingDetailsCubit>(
      () => _i823.BookingDetailsCubit(
        gh<_i1014.GetStayAvailabilityUseCase>(),
        gh<_i305.SaveBookingDraftUseCase>(),
      ),
    );
    gh.factoryParam<
      _i387.CustomerBookingDetailsCubit,
      _i259.BookingModel,
      dynamic
    >(
      (booking, _) => _i387.CustomerBookingDetailsCubit(
        gh<_i528.CancelCustomerBookingUseCase>(),
        gh<_i857.HasBusinessReviewUseCase>(),
        booking,
      ),
    );
    gh.factory<_i535.AppointmentPaymentCubit>(
      () => _i535.AppointmentPaymentCubit(
        gh<_i776.CreateCustomerAppointmentUseCase>(),
        gh<_i374.DeleteAppointmentDraftUseCase>(),
      ),
    );
    gh.factory<_i52.AppointmentDraftCubit>(
      () => _i52.AppointmentDraftCubit(gh<_i811.SaveAppointmentDraftUseCase>()),
    );
    gh.factory<_i582.AvailabilityCalendarCubit>(
      () => _i582.AvailabilityCalendarCubit(
        gh<_i253.GetProviderBookingsUseCase>(),
        gh<_i41.GetOwnedBusinessesUseCase>(),
        gh<_i829.GetOwnedBusinessUseCase>(),
        gh<_i981.UserProfileUseCase>(),
      ),
    );
    gh.factory<_i739.MyBusinessesCubit>(
      () => _i739.MyBusinessesCubit(
        gh<_i517.DeleteBusinessUseCase>(),
        gh<_i981.UserProfileUseCase>(),
        gh<_i41.GetOwnedBusinessesUseCase>(),
      ),
    );
    gh.factory<_i633.AddBusinessBloc>(
      () => _i633.AddBusinessBloc(
        gh<_i157.ImagePickerDataSource>(),
        gh<_i460.SharedPreferences>(),
        gh<_i500.ResolveBusinessLocationUseCase>(),
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
    gh.factory<_i154.ClientBookingsCubit>(
      () => _i154.ClientBookingsCubit(
        gh<_i253.GetProviderBookingsUseCase>(),
        gh<_i308.GetProviderAppointmentsUseCase>(),
        gh<_i84.UpdateProviderBookingStatusUseCase>(),
        gh<_i193.UpdateProviderAppointmentStatusUseCase>(),
        gh<_i41.GetOwnedBusinessesUseCase>(),
        gh<_i981.UserProfileUseCase>(),
      ),
    );
    gh.factory<_i223.MoreCubit>(
      () => _i223.MoreCubit(
        gh<_i41.GetOwnedBusinessesUseCase>(),
        gh<_i981.UserProfileUseCase>(),
        gh<_i747.WatchUnreadMessagesCountUseCase>(),
        gh<_i316.GetUnreadMessagesCountUseCase>(),
        gh<_i730.NotificationDeviceService>(),
        gh<_i1025.SessionStreamRegistry>(),
      ),
    );
    gh.factory<_i41.CustomerDashboardCubit>(
      () => _i41.CustomerDashboardCubit(
        gh<_i343.GetDiscoveryCitiesUseCase>(),
        gh<_i1001.StaySearchRepository>(),
        gh<_i459.ServiceSearchRepository>(),
        gh<_i104.GetBookingDraftUseCase>(),
        gh<_i997.GetAppointmentDraftUseCase>(),
        gh<_i981.UserProfileUseCase>(),
        gh<_i682.UserLocationRepository>(),
        gh<_i742.GetBusinessDetailUseCase>(),
        gh<_i88.GetPopularNearbyBusinessesUseCase>(),
        gh<_i554.GetRecommendedStaysUseCase>(),
        gh<_i436.ListDiscoveryBusinessesUseCase>(),
      ),
    );
    gh.lazySingleton<_i869.AuthenticationRepository>(
      () => _i869.AuthenticationRepository(
        gh<_i715.AuthenticationDataSource>(),
        gh<_i928.UpdateUserProfileUseCase>(),
        gh<_i730.NotificationDeviceService>(),
        gh<_i1025.SessionStreamRegistry>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i243.ReviewStayCubit>(
      () => _i243.ReviewStayCubit(
        gh<_i742.GetBusinessDetailUseCase>(),
        gh<_i305.SaveBookingDraftUseCase>(),
      ),
    );
    gh.factory<_i297.PaymentCubit>(
      () => _i297.PaymentCubit(
        gh<_i652.CreateCustomerBookingUseCase>(),
        gh<_i300.DeleteBookingDraftUseCase>(),
      ),
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
        gh<_i747.WatchUnreadMessagesCountUseCase>(),
        gh<_i316.GetUnreadMessagesCountUseCase>(),
        gh<_i730.NotificationDeviceService>(),
        gh<_i1025.SessionStreamRegistry>(),
      ),
    );
    return this;
  }
}

class _$FirebaseModule extends _i548.FirebaseModule {}

class _$SharedPrefsModule extends _i92.SharedPrefsModule {}
