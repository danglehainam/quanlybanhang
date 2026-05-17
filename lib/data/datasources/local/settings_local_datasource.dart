import 'package:shared_preferences/shared_preferences.dart';

class SettingsLocalDataSource {
  final SharedPreferences _prefs;
  
  static const String _layoutPrefKey = 'is_mobile_view_pref';

  SettingsLocalDataSource(this._prefs);

  bool? getIsMobileView() {
    if (_prefs.containsKey(_layoutPrefKey)) {
      return _prefs.getBool(_layoutPrefKey);
    }
    return null;
  }

  Future<void> setIsMobileView(bool isMobileView) async {
    await _prefs.setBool(_layoutPrefKey, isMobileView);
  }
}
