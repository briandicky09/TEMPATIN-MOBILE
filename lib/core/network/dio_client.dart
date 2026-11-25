import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_mode_provider.dart';
import '../config/env.dart';
import '../offline/offline_demo_database.dart';
import '../offline/offline_demo_interceptor.dart';
import '../storage/secure_storage.dart';
import 'auth_interceptor.dart';

/// Optional callback hook invoked when any API request returns 401 Unauthorized.
final unauthorizedCallbackProvider = Provider<void Function()>((ref) => () {});

/// Configured Dio HTTP client for Laravel `/api/v1` REST communication
/// and in-process Offline Demo Mode interception.
final dioProvider = Provider<Dio>((ref) {
  final storage = ref.watch(secureStorageProvider);
  final onUnauthorized = ref.watch(unauthorizedCallbackProvider);
  final offlineDb = ref.watch(offlineDemoDatabaseProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: AppEnv.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    AuthInterceptor(storage: storage, onUnauthorized: onUnauthorized),
  );
  dio.interceptors.add(
    OfflineDemoInterceptor(
      db: offlineDb,
      isOfflineDemo: () => ref.read(appModeProvider).isOfflineDemo,
    ),
  );

  if (kDebugMode && AppEnv.isDev) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: false,
        responseBody: false,
        requestHeader: false,
        logPrint: (obj) => debugPrint(obj.toString()),
      ),
    );
  }

  return dio;
});
