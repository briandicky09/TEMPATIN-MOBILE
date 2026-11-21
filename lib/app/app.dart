import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../features/authentication/presentation/providers/auth_session_provider.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

/// Root widget for TEMPATIN MOBILE that restores persisted Sanctum session at startup.
class TempatinApp extends ConsumerStatefulWidget {
  const TempatinApp({super.key});

  @override
  ConsumerState<TempatinApp> createState() => _TempatinAppState();
}

class _TempatinAppState extends ConsumerState<TempatinApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(authSessionProvider.notifier).restoreSession(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'TEMPATIN',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}
