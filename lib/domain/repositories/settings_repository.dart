abstract class SettingsRepository {
  bool? getIsMobileView();
  Future<void> setMobileView(bool isMobileView);
}
