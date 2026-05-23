import '../entities/portfolio_entity.dart';
import '../repositories/portfolio_repository.dart';

class GetPortfolioUseCase {
  const GetPortfolioUseCase(this._repository);

  final PortfolioRepository _repository;

  PortfolioEntity call() => _repository.getPortfolioData();
}
