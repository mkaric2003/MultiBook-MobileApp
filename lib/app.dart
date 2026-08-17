import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_theme.dart';
import 'package:aquabook/src/data/repositories/authentication_repository.dart';
import 'package:aquabook/src/data/repositories/onboarding_repository.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/views/add_business_view.dart';
import 'package:aquabook/src/features/business-side/account_settings/presentation/views/account_settings_view.dart';
import 'package:aquabook/src/features/business-side/availability_calendar/presentation/views/availability_calendar_view.dart';
import 'package:aquabook/src/features/business-side/home/presentation/views/client_entry_view.dart';
import 'package:aquabook/src/features/business-side/home/presentation/views/home_view.dart';
import 'package:aquabook/src/features/business-side/my_businesses/presentation/views/my_businesses_view.dart';
import 'package:aquabook/src/features/customer-side/home/presentation/views/customer_home_view.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/booking_details/domain/models/booking_details_arguments.dart';
import 'package:aquabook/src/features/customer-side/booking_details/presentation/views/booking_details_view.dart';
import 'package:aquabook/src/features/customer-side/search/presentation/views/customer_search_view.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/presentation/views/stay_detail_view.dart';
import 'package:aquabook/src/features/customer-side/review_stay/domain/models/review_stay_arguments.dart';
import 'package:aquabook/src/features/customer-side/review_stay/presentation/views/review_stay_view.dart';
import 'package:aquabook/src/features/customer-side/payment/domain/models/payment_arguments.dart';
import 'package:aquabook/src/features/customer-side/payment/presentation/views/payment_view.dart';
import 'package:aquabook/src/features/customer-side/booking_confirmed/domain/models/booking_confirmed_arguments.dart';
import 'package:aquabook/src/features/customer-side/booking_confirmed/presentation/views/booking_confirmed_view.dart';
import 'package:aquabook/src/features/shared/onboarding/presentation/views/onboarding_view.dart';
import 'package:aquabook/src/features/shared/sign_in/presentation/views/signin_view.dart';
import 'package:aquabook/src/features/shared/sign_up/presentation/views/signup_view.dart';
import 'package:aquabook/src/features/shared/user_type_checker/presentation/views/user_type_checker_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'src/router/app_pages.dart';
part 'src/router/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'AquaBook',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
    );
  }
}
