import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/shared_preferences_provider.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<bool> isNotificationsEnabled() {
    return localDataSource.getNotificationSetting();
  }

  @override
  Future<void> setNotificationsEnabled(bool enabled) {
    return localDataSource.cacheNotificationSetting(enabled);
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  final localDataSource = SettingsLocalDataSourceImpl(
    sharedPreferences: sharedPreferences,
  );
  return SettingsRepositoryImpl(localDataSource: localDataSource);
});
