import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../feature/portfolio/data/datasources/portfolio_local_datasource.dart';
import '../../feature/portfolio/data/repositories_impl/portfolio_repository_impl.dart';
import '../../feature/portfolio/domain/repositories/portfolio_repository.dart';
import '../../feature/portfolio/domain/usecases/get_portfolio_usecase.dart';

// 1. Data Sources
final portfolioLocalDataSourceProvider =
    Provider<PortfolioLocalDataSource>((ref) {
  return const PortfolioLocalDataSource();
});

// 2. Repository
final portfolioRepositoryProvider = Provider<PortfolioRepository>((ref) {
  return PortfolioRepositoryImpl(
    ref.watch(portfolioLocalDataSourceProvider),
  );
});

// 3. Use Cases
final getPortfolioUseCaseProvider = Provider<GetPortfolioUseCase>((ref) {
  return GetPortfolioUseCase(ref.watch(portfolioRepositoryProvider));
});
