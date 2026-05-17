import '../repositories/settings_repository.dart';

class GetLanguageUseCase {
  final SettingsRepository _repository;

  GetLanguageUseCase(this._repository);

  String? call() {
    return _repository.getLanguageCode();
  }
}
