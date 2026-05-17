import 'package:fpdart/fpdart.dart';

import '../../core/error/failures.dart';
import '../repositories/settings_repository.dart';

class SaveLayoutPreferenceUseCase {
  final SettingsRepository _repository;

  SaveLayoutPreferenceUseCase(this._repository);

  Future<Either<Failure, void>> call(bool isMobileView) async {
    return await _repository.setMobileView(isMobileView);
  }
}
