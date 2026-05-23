import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../portfolio_notifier/portfolio_notifier.dart';
import '../portfolio_states/portfolio_state.dart';

// Re-export the notifier provider — the notifier itself reads
// getPortfolioUseCaseProvider from core/di/providers.dart directly,
// so there is no circular import here.
final portfolioNotifierProvider =
    NotifierProvider<PortfolioNotifier, PortfolioState>(
  PortfolioNotifier.new,
);
