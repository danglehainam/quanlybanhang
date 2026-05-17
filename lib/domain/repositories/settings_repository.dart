import 'package:fpdart/fpdart.dart';

import '../../core/error/failures.dart';

abstract class SettingsRepository {
  bool? getIsMobileView();
  Future<Either<Failure, void>> setMobileView(bool isMobileView);
  
  String? getLanguageCode();
  Future<Either<Failure, void>> saveLanguageCode(String code);
}
