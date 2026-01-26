import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/repositories/settings_repository_impl.dart';

part 'settings_controller.g.dart';

@riverpod
class SettingsController extends _$SettingsController {
  @override
  Future<bool> build() async {
    final repository = ref.watch(settingsRepositoryProvider);
    return repository.isNotificationsEnabled();
  }

  Future<void> toggleNotifications(bool value) async {
    final repository = ref.read(settingsRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repository.setNotificationsEnabled(value);
      return value;
    });
  }
}
