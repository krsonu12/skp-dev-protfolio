import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/routes/app_router.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/theme_notifier.dart';

class PortfolioApp extends ConsumerStatefulWidget {
  const PortfolioApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  ConsumerState<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends ConsumerState<PortfolioApp> {
  @override
  Widget build(BuildContext context) {
    // While loading from prefs, default to dark so there's no flash.
    final themeMode =
        ref.watch(themeNotifierProvider).whenData((m) => m).valueOrNull ??
            ThemeMode.dark;

    return MaterialApp.router(
      title: 'Sonu Kumar Paswan — Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routeInformationParser: widget.appRouter.defaultRouteParser(),
      routerDelegate: widget.appRouter.delegate(),
    );
  }
}
