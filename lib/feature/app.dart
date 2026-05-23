import 'package:flutter/material.dart';
import '../core/routes/app_router.dart';
import '../core/theme/app_theme.dart';

class PortfolioApp extends StatelessWidget {
  final AppRouter appRouter;
  const PortfolioApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sonu Kumar Paswan — Senior Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      routeInformationParser: appRouter.defaultRouteParser(),
      routerDelegate: appRouter.delegate(),
    );
  }
}
