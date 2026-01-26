import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'core/network/pocketbase_service.dart';
import 'core/providers/shared_preferences_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Environment Variables
  await dotenv.load(fileName: ".env");

  // Initialize Date Formatting
  await initializeDateFormatting('id_ID', null);

  // Initialize PocketBase Service
  await PocketBaseService().init();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const IkasmansaraApp(),
    ),
  );
}
