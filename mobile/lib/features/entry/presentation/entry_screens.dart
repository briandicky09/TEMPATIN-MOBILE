import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/router/routes.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../shared/widgets/local_image.dart';
import '../../../shared/widgets/tempatin_widgets.dart';

/// Seamless Flutter splash continuing the native launch screen with smooth fade + scale logo transition.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.88,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final results = await Future.wait([
      ref.read(sessionProvider.notifier).initializeApp(),
      Future<void>.delayed(const Duration(milliseconds: 950)),
    ]);
    if (!mounted) return;
    final seenOnboarding = results.first as bool;
    final session = ref.read(sessionProvider);

    if (!seenOnboarding) {
      context.go(AppRoutes.onboarding);
    } else if (session != null && session.isOwner) {
      context.go(AppRoutes.ownerDashboard);
    } else {
      context.go(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/logo.png', width: 170),
                const SizedBox(height: AppSpacing.md),
                const Text(
                  'Cari & Kelola Kos • Mode Offline',
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _index = 0;

  static const _slides = [
    (
      image: 'assets/images/onboarding/onboarding_1.jpg',
      title: 'Temukan Kos Terbaik Tanpa Koneksi',
      desc: 'Seluruh katalog properti, foto kamar, dan fasilitas tersimpan lokal di perangkat Anda.',
    ),
    (
      image: 'assets/images/onboarding/onboarding_2.jpg',
      title: 'Booking & Invoice Otomatis',
      desc: 'Ajukan sewa kos, pantau status persetujuan pemilik, hingga simulasi pelunasan invoice secara lokal.',
    ),
    (
      image: 'assets/images/onboarding/onboarding_3.jpg',
      title: 'Kelola Properti Kos Lebih Mudah',
      desc: 'Mode Pemilik lengkap untuk menambah kos, mengatur foto galeri, dan memproses booking penghuni.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finish({String target = AppRoutes.home}) async {
    await ref.read(sessionProvider.notifier).markOnboardingSeen();
    if (!mounted) return;
    context.go(target);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => _finish(),
                child: const Text('Lewati'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LocalImage(
                          path: slide.image,
                          height: 250,
                          width: double.infinity,
                          borderRadius: AppRadii.card,
                          cacheWidth: 720,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        Text(
                          slide.title,
                          style: AppTypography.headingLg,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          slide.desc,
                          style: AppTypography.body,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < _slides.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _index == i ? 22 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _index == i
                          ? AppColors.primary
                          : AppColors.borderStrong,
                      borderRadius: AppRadii.pill,
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                children: [
                  TempatinButton(
                    label: _index == _slides.length - 1
                        ? 'Mulai Jelajahi Kos'
                        : 'Lanjut',
                    onPressed: () {
                      if (_index < _slides.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 280),
                          curve: Curves.easeOut,
                        );
                      } else {
                        _finish();
                      }
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TempatinButton(
                    label: 'Masuk dengan Akun Demo / Lokal',
                    variant: ButtonVariant.outlined,
                    onPressed: () => _finish(target: AppRoutes.login),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _error = null);
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _loading = true);
    try {
      final user = await ref
          .read(sessionProvider.notifier)
          .login(
            email: _emailController.text,
            password: _passwordController.text,
          );
      if (!mounted) return;
      context.go(user.isOwner ? AppRoutes.ownerDashboard : AppRoutes.home);
    } on AuthException catch (e) {
      if (!mounted) return;
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _fillDemo(String email) {
    _emailController.text = email;
    _passwordController.text = 'password123';
    setState(() => _error = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Masuk Akun Lokal')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Center(child: Image.asset('assets/images/logo.png', height: 40)),
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.infoBg,
                borderRadius: AppRadii.button,
              ),
              child: const Text(
                'Autentikasi ini berjalan 100% secara lokal menggunakan SQLite + SHA-256 salted hash sebagai simulasi pembelajaran offline.',
                style: AppTypography.caption,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (_error != null) ...[
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.dangerBg,
                  borderRadius: AppRadii.button,
                ),
                child: Text(
                  _error!,
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.dangerText,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            TempatinTextField(
              label: 'Email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: LucideIcons.mail,
              validator: AppValidators.email,
            ),
            const SizedBox(height: AppSpacing.md),
            TempatinTextField(
              label: 'Password',
              controller: _passwordController,
              obscureText: _obscure,
              prefixIcon: LucideIcons.lock,
              validator: AppValidators.password,
              suffixIcon: IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(
                  _obscure ? LucideIcons.eye : LucideIcons.eyeOff,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            TempatinButton(
              label: 'Masuk',
              isLoading: _loading,
              onPressed: _submit,
            ),
            const SizedBox(height: AppSpacing.md),
            TempatinButton(
              label: 'Belum Punya Akun? Daftar Lokal',
              variant: ButtonVariant.outlined,
              onPressed: () => context.push(AppRoutes.register),
            ),
            const SizedBox(height: AppSpacing.xl),
            const Text('Isi Cepat Akun Demo:', style: AppTypography.label),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: TempatinButton(
                    label: 'Demo Member',
                    variant: ButtonVariant.secondary,
                    onPressed: () => _fillDemo('dewi@email.com'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TempatinButton(
                    label: 'Demo Owner',
                    variant: ButtonVariant.secondary,
                    onPressed: () => _fillDemo('owner@tempatin.id'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String _role = 'member';
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _error = null);
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _loading = true);
    try {
      final user = await ref
          .read(sessionProvider.notifier)
          .register(
            name: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            phone: _phoneController.text,
            role: _role,
          );
      if (!mounted) return;
      context.go(user.isOwner ? AppRoutes.ownerDashboard : AppRoutes.home);
    } on AuthException catch (e) {
      if (!mounted) return;
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Akun Lokal')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            if (_error != null) ...[
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.dangerBg,
                  borderRadius: AppRadii.button,
                ),
                child: Text(
                  _error!,
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.dangerText,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            const Text('Pilih Peran Akun:', style: AppTypography.label),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Member (Pencari Kos)'),
                    selected: _role == 'member',
                    onSelected: (_) => setState(() => _role = 'member'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Owner (Pemilik)'),
                    selected: _role == 'owner',
                    onSelected: (_) => setState(() => _role = 'owner'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            TempatinTextField(
              label: 'Nama Lengkap',
              controller: _nameController,
              prefixIcon: LucideIcons.user,
              validator: (v) => AppValidators.requiredField(v, label: 'Nama'),
            ),
            const SizedBox(height: AppSpacing.md),
            TempatinTextField(
              label: 'Email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: LucideIcons.mail,
              validator: AppValidators.email,
            ),
            const SizedBox(height: AppSpacing.md),
            TempatinTextField(
              label: 'Nomor HP / WhatsApp',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              prefixIcon: LucideIcons.phone,
              validator: AppValidators.phone,
            ),
            const SizedBox(height: AppSpacing.md),
            TempatinTextField(
              label: 'Password',
              controller: _passwordController,
              obscureText: true,
              prefixIcon: LucideIcons.lock,
              validator: AppValidators.password,
            ),
            const SizedBox(height: AppSpacing.xl),
            TempatinButton(
              label: 'Buat Akun Lokal',
              isLoading: _loading,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
