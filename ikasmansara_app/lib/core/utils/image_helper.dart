import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImageHelper {
  /// Generates a full URL for a PocketBase file.
  /// Automatically handles Android Emulator localhost (127.0.0.1 -> 10.0.2.2).
  static String? getPocketBaseImageUrl({
    required String collectionId,
    required String recordId,
    required String filename,
    String? baseUrl,
  }) {
    if (filename.isEmpty) return null;

    final String base =
        baseUrl ?? dotenv.env['POCKETBASE_URL'] ?? 'http://127.0.0.1:8090';

    String effectiveBaseUrl = base;

    // Basic fix for android emulator
    try {
      if (Platform.isAndroid) {
        if (effectiveBaseUrl.contains('127.0.0.1')) {
          effectiveBaseUrl = effectiveBaseUrl.replaceFirst(
            '127.0.0.1',
            '10.0.2.2',
          );
        } else if (effectiveBaseUrl.contains('localhost')) {
          effectiveBaseUrl = effectiveBaseUrl.replaceFirst(
            'localhost',
            '10.0.2.2',
          );
        }
      }
    } catch (_) {
      // Ignore platform errors (e.g. in tests or non-mobile)
    }

    return '$effectiveBaseUrl/api/files/$collectionId/$recordId/$filename';
  }
}
