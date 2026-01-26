abstract class SettingsRepository {
  Future<void> setNotificationsEnabled(bool enabled);
  Future<bool> isNotificationsEnabled();

  // Future proofing for other settings
  // Future<void> setThemeMode(bool isDark);
  // Future<bool> isDarkMode();
}
