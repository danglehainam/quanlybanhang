import '../repositories/settings_repository.dart';

class GetLayoutPreferenceUseCase {
  final SettingsRepository _repository;

  GetLayoutPreferenceUseCase(this._repository);

  bool? call() {
    return _repository.getIsMobileView();
  }
}
