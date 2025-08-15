import 'package:aquabook/src/features/introduction/presentation/views/introduction_view.dart';
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
    );
  }
}
