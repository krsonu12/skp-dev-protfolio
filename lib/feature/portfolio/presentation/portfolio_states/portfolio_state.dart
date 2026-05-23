import '../../domain/entities/portfolio_entity.dart';

class PortfolioState {
  const PortfolioState({
    this.portfolio,
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage = '',
    this.activeSection = 0,
  });

  final PortfolioEntity? portfolio;
  final bool isLoading;
  final bool hasError;
  final String errorMessage;
  final int activeSection;

  PortfolioState copyWith({
    PortfolioEntity? portfolio,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    int? activeSection,
  }) {
    return PortfolioState(
      portfolio: portfolio ?? this.portfolio,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      activeSection: activeSection ?? this.activeSection,
    );
  }
}
