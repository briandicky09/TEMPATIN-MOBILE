import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/config/app_mode_provider.dart';
import '../../../../shared/models/user_model.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';

/// Premium animated TEMPATIN launch screen bridging native splash to main app.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoScale;
  late final Animation<double> _lineProgress;
  late final Animation<double> _wordmarkOpacity;
  late final Animation<Offset> _wordmarkSlide;

  bool _navigated = false;
  bool _animDone = false;
  bool _sessionDone = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1350),
    );

    _logoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.42, curve: Curves.easeOut),
    );
    _logoScale = Tween<double>(begin: 0.90, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
      ),
    );
    _lineProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.32, 0.68, curve: Curves.easeInOutCubic),
    );
    _wordmarkOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.45, 0.85, curve: Curves.easeOut),
    );
    _wordmarkSlide =
        Tween<Offset>(begin: const Offset(0, 0.14), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.45, 0.85, curve: Curves.easeOutCubic),
          ),
        );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animDone = true;
        _tryNavigate();
      }
    });

    _startLaunchSequence();
  }

  Future<void> _startLaunchSequence() async {
    _controller.forward();
    try {
      await ref
          .read(authSessionProvider.notifier)
          .restoreSession()
          .timeout(const Duration(milliseconds: 800), onTimeout: () {});
    } catch (_) {
      // Proceed to default destination cleanly if session restore fails offline.
    }
    _sessionDone = true;
    _tryNavigate();
  }

  void _tryNavigate() {
    if (!mounted || _navigated || !_animDone || !_sessionDone) return;
    _navigated = true;

    final authState = ref.read(authSessionProvider);
    final isOwner = authState.role == UserRole.owner;
    context.go(isOwner ? RoutePaths.ownerDashboard : RoutePaths.home);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appMode = ref.watch(appModeProvider);

    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeTransition(
                    opacity: _logoOpacity,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: Image.asset(
                        'assets/branding/splash_symbol_512.png',
                        width: 92,
                        height: 92,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Container(
                    width: 56 * _lineProgress.value,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  FadeTransition(
                    opacity: _wordmarkOpacity,
                    child: SlideTransition(
                      position: _wordmarkSlide,
                      child: Column(
                        children: [
                          Text(
                            'TEMPATIN',
                            style: AppTypography.displaySm.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: 3.2,
                              color: AppColors.inkPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Temukan & Kelola Kos Secara Profesional',
                            style: AppTypography.bodySm.copyWith(
                              color: AppColors.inkSecondary,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          if (appMode.isOfflineDemo)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: AppColors.borderHairline,
                                ),
                              ),
                              child: Text(
                                'Offline-First Demo Ready',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
