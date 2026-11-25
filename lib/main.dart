import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/config/env.dart';
import 'core/network/dio_client.dart';
import 'core/storage/prefs_storage.dart';
import 'features/authentication/presentation/providers/auth_session_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID');
  final prefs = await SharedPreferences.getInstance();
  final isOfflineDemo =
      prefs.getBool('tempatin_offline_demo_mode') ?? AppEnv.defaultOfflineDemo;
  GoogleFonts.config.allowRuntimeFetching = !isOfflineDemo;

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        unauthorizedCallbackProvider.overrideWith(
          (ref) =>
              () => ref.read(authSessionProvider.notifier).signOut(),
        ),
      ],
      child: const TempatinApp(),
    ),
  );
}
