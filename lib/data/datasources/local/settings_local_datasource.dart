import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/pref_keys.dart';

class SettingsLocalDataSource {
  final SharedPreferences _prefs;

  SettingsLocalDataSource(this._prefs);

  bool? getIsMobileView() {
    if (_prefs.containsKey(PrefKeys.layoutViewMode)) {
      return _prefs.getBool(PrefKeys.layoutViewMode);
    }
    return null;
  }

  Future<void> setIsMobileView(bool isMobileView) async {
    await _prefs.setBool(PrefKeys.layoutViewMode, isMobileView);
  }

  String? getLanguageCode() {
    if (_prefs.containsKey(PrefKeys.languageCode)) {
      return _prefs.getString(PrefKeys.languageCode);
    }
    return null;
  }

  Future<void> setLanguageCode(String code) async {
    await _prefs.setString(PrefKeys.languageCode, code);
  }
}
