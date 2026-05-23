import '../../domain/entities/portfolio_entity.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_datasource.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  const PortfolioRepositoryImpl(this._dataSource);

  final PortfolioLocalDataSource _dataSource;

  @override
  PortfolioEntity getPortfolioData() => _dataSource.getPortfolioData();
}
