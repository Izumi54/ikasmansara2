import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  Future<void> cacheNotificationSetting(bool isEnabled);
  Future<bool> getNotificationSetting();
}

const String kNotificationKey = 'KEY_NOTIFICATIONS_ENABLED';

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheNotificationSetting(bool isEnabled) async {
    await sharedPreferences.setBool(kNotificationKey, isEnabled);
  }

  @override
  Future<bool> getNotificationSetting() async {
    return sharedPreferences.getBool(kNotificationKey) ?? true; // Default true
  }
}
