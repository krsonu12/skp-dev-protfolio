import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/error/failures.dart';
import '../portfolio_states/portfolio_state.dart';

class PortfolioNotifier extends Notifier<PortfolioState> {
  @override
  PortfolioState build() {
    // Schedule load after build() returns so state is initialized first.
    Future.microtask(_load);
    return const PortfolioState(isLoading: true);
  }

  void _load() {
    try {
      final useCase = ref.read(getPortfolioUseCaseProvider);
      final portfolio = useCase();
      state = state.copyWith(portfolio: portfolio, isLoading: false);
    } on AppFailure catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.message,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: 'Something went wrong.',
      );
    }
  }

  void setActiveSection(int index) {
    state = state.copyWith(activeSection: index);
  }
}
