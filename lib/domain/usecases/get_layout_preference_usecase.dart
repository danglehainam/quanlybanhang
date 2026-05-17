import '../repositories/settings_repository.dart';

class GetLayoutPreferenceUseCase {
  final SettingsRepository _repository;

  GetLayoutPreferenceUseCase(this._repository);

  bool? execute() {
    return _repository.getIsMobileView();
  }
}
