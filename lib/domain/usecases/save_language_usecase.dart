import 'package:fpdart/fpdart.dart';

import '../../core/error/failures.dart';
import '../repositories/settings_repository.dart';

class SaveLanguageUseCase {
  final SettingsRepository _repository;

  SaveLanguageUseCase(this._repository);

  Future<Either<Failure, void>> call(String code) async {
    return await _repository.saveLanguageCode(code);
  }
}
