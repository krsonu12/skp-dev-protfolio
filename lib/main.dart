import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_website/core/routes/app_router.dart';
import 'feature/app.dart';

void main() {
  runApp(
    ProviderScope(
      child: PortfolioApp(
        appRouter: AppRouter(navigatorKey: navigatorKey),
      ),
    ),
  );
}

// Global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
