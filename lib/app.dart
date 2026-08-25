import 'dart:async';

import 'package:aquabook/l10n/app_localizations.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_theme.dart';
import 'package:aquabook/src/data/repositories/authentication_repository.dart';
import 'package:aquabook/src/data/repositories/onboarding_repository.dart';
import 'package:aquabook/src/data/repositories/notification_repository.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/views/add_business_view.dart';
import 'package:aquabook/src/features/business-side/account_settings/presentation/views/account_settings_view.dart';
import 'package:aquabook/src/features/business-side/availability_calendar/presentation/views/availability_calendar_view.dart';
import 'package:aquabook/src/features/business-side/home/presentation/views/client_entry_view.dart';
import 'package:aquabook/src/features/business-side/home/presentation/views/home_view.dart';
import 'package:aquabook/src/features/business-side/my_businesses/presentation/views/my_businesses_view.dart';
import 'package:aquabook/src/features/business-side/manage_catalog/presentation/views/manage_catalog_view.dart';
import 'package:aquabook/src/features/customer-side/home/presentation/views/customer_home_view.dart';
import 'package:aquabook/src/features/customer-side/profile/presentation/views/customer_edit_profile_view.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:aquabook/src/features/customer-side/booking_details/domain/models/booking_details_arguments.dart';
import 'package:aquabook/src/features/customer-side/booking_details/presentation/views/booking_details_view.dart';
import 'package:aquabook/src/features/customer-side/search/presentation/views/customer_search_view.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/presentation/views/stay_detail_view.dart';
import 'package:aquabook/src/features/customer-side/service_detail/presentation/views/service_detail_view.dart';
import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_stay_results_arguments.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/views/explore_stay_results_view.dart';
import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_service_results_arguments.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/views/explore_service_results_view.dart';
import 'package:aquabook/src/features/customer-side/create_appointment/domain/models/create_appointment_arguments.dart';
import 'package:aquabook/src/features/customer-side/create_appointment/presentation/views/create_appointment_view.dart';
import 'package:aquabook/src/features/customer-side/review_appointment/domain/models/review_appointment_arguments.dart';
import 'package:aquabook/src/features/customer-side/review_appointment/presentation/views/review_appointment_view.dart';
import 'package:aquabook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_arguments.dart';
import 'package:aquabook/src/features/customer-side/appointment_payment/presentation/views/appointment_payment_view.dart';
import 'package:aquabook/src/features/customer-side/appointment_confirmed/domain/models/appointment_confirmed_arguments.dart';
import 'package:aquabook/src/features/customer-side/appointment_confirmed/presentation/views/appointment_confirmed_view.dart';
import 'package:aquabook/src/features/customer-side/appointment_details/domain/models/appointment_details_arguments.dart';
import 'package:aquabook/src/features/customer-side/appointment_details/presentation/views/appointment_details_view.dart';
import 'package:aquabook/src/features/customer-side/reschedule_appointment/domain/models/reschedule_appointment_arguments.dart';
import 'package:aquabook/src/features/customer-side/reschedule_appointment/presentation/views/reschedule_appointment_view.dart';
import 'package:aquabook/src/features/customer-side/review_stay/domain/models/review_stay_arguments.dart';
import 'package:aquabook/src/features/customer-side/review_stay/presentation/views/review_stay_view.dart';
import 'package:aquabook/src/features/customer-side/payment/domain/models/payment_arguments.dart';
import 'package:aquabook/src/features/customer-side/payment/presentation/views/payment_view.dart';
import 'package:aquabook/src/features/customer-side/booking_confirmed/domain/models/booking_confirmed_arguments.dart';
import 'package:aquabook/src/features/customer-side/booking_confirmed/presentation/views/booking_confirmed_view.dart';
import 'package:aquabook/src/features/customer-side/customer_booking_details/presentation/views/customer_booking_details_view.dart';
import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/data/models/appointment_model.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/features/shared/onboarding/presentation/views/onboarding_view.dart';
import 'package:aquabook/src/features/shared/sign_in/presentation/views/signin_view.dart';
import 'package:aquabook/src/features/shared/sign_up/presentation/views/signup_view.dart';
import 'package:aquabook/src/features/shared/user_type_checker/presentation/views/user_type_checker_view.dart';
import 'package:aquabook/src/features/shared/chat/domain/models/chat_conversation_arguments.dart';
import 'package:aquabook/src/features/shared/chat/presentation/views/chat_conversation_view.dart';
import 'package:aquabook/src/features/shared/chat/presentation/views/chat_list_view.dart';
import 'package:aquabook/src/features/shared/notifications/presentation/views/notifications_view.dart';
import 'package:aquabook/src/features/shared/localization/cubit/locale_cubit.dart';
import 'package:aquabook/src/features/shared/localization/cubit/locale_state.dart';
import 'package:aquabook/src/features/shared/localization/presentation/views/language_currency_view.dart';
import 'package:aquabook/src/features/shared/legal/domain/enums/legal_document_type.dart';
import 'package:aquabook/src/features/shared/legal/domain/enums/legal_document_audience.dart';
import 'package:aquabook/src/features/shared/legal/presentation/views/legal_document_view.dart';
import 'package:aquabook/src/features/customer-side/support_tickets/presentation/views/create_support_ticket_view.dart';
import 'package:aquabook/src/features/customer-side/support_tickets/presentation/views/support_tickets_view.dart';
import 'package:aquabook/src/features/customer-side/help_center/domain/models/help_article_model.dart';
import 'package:aquabook/src/features/customer-side/help_center/presentation/views/help_article_detail_view.dart';
import 'package:aquabook/src/features/customer-side/help_center/presentation/views/help_center_view.dart';
import 'package:aquabook/src/features/customer-side/payment_methods/presentation/views/payment_methods_view.dart';
import 'package:aquabook/src/features/customer-side/payment_methods/presentation/views/add_payment_method_view.dart';
import 'package:aquabook/src/features/business-side/promotions/presentation/views/create_promotion_view.dart';
import 'package:aquabook/src/features/business-side/promotions/presentation/views/promotions_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

part 'src/router/app_pages.dart';
part 'src/router/app_routes.dart';

class App extends HookWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      unawaited(
        getIt<NotificationRepository>().initialize(
          onNotificationOpened: (data) {
            if (data['type'] != 'chat_message') return;
            final businessId = data['businessId'];
            final businessOwnerId = data['businessOwnerId'];
            final businessName = data['businessName'];
            final customerId = data['customerId'];
            final customerName = data['customerName'];
            if ([
              businessId,
              businessOwnerId,
              businessName,
              customerId,
              customerName,
            ].any((value) => value == null || value.isEmpty)) {
              return;
            }
            router.push(
              AppRoutes.CHAT_CONVERSATION,
              extra: ChatConversationArguments(
                businessId: businessId!,
                businessOwnerId: businessOwnerId!,
                businessName: businessName!,
                businessImageUrl: data['businessImageUrl'] ?? '',
                customerId: customerId,
                customerName: customerName,
                customerImageUrl: data['customerImageUrl'],
              ),
            );
          },
        ),
      );
      return null;
    }, const []);
    return BlocProvider.value(
      value: getIt<LocaleCubit>(),
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) => MaterialApp.router(
          routerConfig: router,
          onGenerateTitle: (context) => context.l10n.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          locale: state.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
