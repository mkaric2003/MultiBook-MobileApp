import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_theme.dart';
import 'package:aquabook/src/data/repositories/authentication_repository.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/views/add_business_view.dart';
import 'package:aquabook/src/features/business-side/home/presentation/views/client_entry_view.dart';
import 'package:aquabook/src/features/business-side/my_businesses/presentation/views/my_businesses_view.dart';
import 'package:aquabook/src/features/shared/sign_in/presentation/views/signin_view.dart';
import 'package:aquabook/src/features/shared/sign_up/presentation/views/signup_view.dart';
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
