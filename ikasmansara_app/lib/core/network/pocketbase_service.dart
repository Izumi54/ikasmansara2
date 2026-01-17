import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'api_endpoints.dart';

class PocketBaseService {
  // Singleton Pattern
  static final PocketBaseService _instance = PocketBaseService._internal();
  factory PocketBaseService() => _instance;
  PocketBaseService._internal();

  // PocketBase Client Instance
  late final PocketBase pb;

  // Initialize (dipanggil di main.dart)
  Future<void> init() async {
    String baseUrl = dotenv.get(
      'POCKETBASE_URL',
      fallback: 'http://127.0.0.1:8090',
    );

    // Fix for Android Emulator (127.0.0.1 -> 10.0.2.2)
    if (Platform.isAndroid && baseUrl.contains('127.0.0.1')) {
      baseUrl = baseUrl.replaceAll('127.0.0.1', '10.0.2.2');
    }

    // Configure timeout
    pb = PocketBase(baseUrl);

    // Auto-refresh token jika sudah ada session
    if (pb.authStore.isValid) {
      await _refreshToken();
    }
  }

  // Token Refresh (Auto-called setiap request jika token hampir expired)
  Future<void> _refreshToken() async {
    try {
      // Timeout refresh after 5 seconds to prevent app freeze
      await pb
          .collection(ApiEndpoints.users)
          .authRefresh()
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      // Jika refresh gagal (atau timeout), clear auth
      pb.authStore.clear();
    }
  }

  // Helper: Get Current User
  RecordModel? get currentUser => pb.authStore.record;

  // Helper: Check if Authenticated
  bool get isAuthenticated => pb.authStore.isValid;

  // Logout
  void logout() {
    pb.authStore.clear();
  }
}

// Provider to access PocketBase instance
final pocketBaseServiceProvider = Provider<PocketBase>((ref) {
  return PocketBaseService().pb;
});
