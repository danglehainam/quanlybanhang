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
  Future<void> setMobileView(bool isMobileView) async {
    await _localDataSource.setIsMobileView(isMobileView);
  }
}
