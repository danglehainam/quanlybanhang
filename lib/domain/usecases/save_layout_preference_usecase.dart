import '../repositories/settings_repository.dart';

class SaveLayoutPreferenceUseCase {
  final SettingsRepository _repository;

  SaveLayoutPreferenceUseCase(this._repository);

  Future<void> execute(bool isMobileView) async {
    await _repository.setMobileView(isMobileView);
  }
}
