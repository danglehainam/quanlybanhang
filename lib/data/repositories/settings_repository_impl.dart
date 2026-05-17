import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/local/settings_local_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _localDataSource;

  SettingsRepositoryImpl(this._localDataSource);

  @override
  bool? getIsMobileView() {
    return _localDataSource.getIsMobileView();
  }

  @override
  Future<Either<Failure, void>> setMobileView(bool isMobileView) async {
    try {
      await _localDataSource.setIsMobileView(isMobileView);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to save layout preference: $e'));
    }
  }

  @override
  String? getLanguageCode() {
    return _localDataSource.getLanguageCode();
  }

  @override
  Future<Either<Failure, void>> saveLanguageCode(String code) async {
    try {
      await _localDataSource.setLanguageCode(code);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to save language preference: $e'));
    }
  }
}
