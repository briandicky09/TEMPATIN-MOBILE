import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/tempatin_button.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../../core/widgets/tempatin_text_field.dart';
import '../../../../shared/models/user_model.dart';
import '../providers/auth_session_provider.dart';

/// Registration screen with explicit Customer vs Owner role selector.
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  UserRole _selectedRole = UserRole.customer;
  bool _agreed = false;
  bool _obscurePassword = true;
  bool _isSubmitting = false;
  String? _errorMessage;
  Map<String, List<String>> _fieldErrors = const {};

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _errorMessage = null;
      _fieldErrors = const {};
    });

    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!_agreed) {
      setState(
        () => _errorMessage =
            'Anda harus menyetujui syarat dan ketentuan TEMPATIN.',
      );
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final user = await ref
          .read(authSessionProvider.notifier)
          .register(
            name: _nameController.text,
            phone: _phoneController.text,
            email: _emailController.text,
            role: _selectedRole,
            password: _passwordController.text,
            passwordConfirmation: _confirmController.text,
          );
      if (!mounted) return;
      context.go(
        user.role == UserRole.owner
            ? RoutePaths.ownerDashboard
            : RoutePaths.home,
      );
    } on ValidationException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.message;
        _fieldErrors = e.fieldErrors;
      });
    } on AppException catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = e.message);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Akun')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Buat akun TEMPATIN', style: AppTypography.headingLg),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Pilih peran Anda untuk pengalaman yang sesuai.',
                style: AppTypography.bodySm,
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: _RoleSelectorCard(
                      title: 'Pencari Kos',
                      subtitle: 'Cari, survei & sewa',
                      icon: LucideIcons.search,
                      selected: _selectedRole == UserRole.customer,
                      onTap: () =>
                          setState(() => _selectedRole = UserRole.customer),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _RoleSelectorCard(
                      title: 'Pemilik Kos',
                      subtitle: 'Kelola properti & sewa',
                      icon: LucideIcons.building2,
                      selected: _selectedRole == UserRole.owner,
                      onTap: () =>
                          setState(() => _selectedRole = UserRole.owner),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.dangerBg,
                    borderRadius: AppRadii.buttonRadius,
                    border: Border.all(color: AppColors.borderHairline),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.dangerText,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
              TempatinCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TempatinTextField(
                      label: 'Nama Lengkap',
                      controller: _nameController,
                      hintText: 'Contoh: Dewi Sartika',
                      prefixIcon: LucideIcons.user,
                      validator: (v) =>
                          _fieldErrors['name']?.firstOrNull ??
                          AppValidators.requiredField(v, label: 'Nama'),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    TempatinTextField(
                      label: 'Nomor Handphone / WhatsApp',
                      controller: _phoneController,
                      hintText: '0812xxxxxxxx',
                      keyboardType: TextInputType.phone,
                      prefixIcon: LucideIcons.phone,
                      validator: (v) =>
                          _fieldErrors['phone']?.firstOrNull ??
                          AppValidators.phone(v),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    TempatinTextField(
                      label: 'Email',
                      controller: _emailController,
                      hintText: 'nama@email.com',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: LucideIcons.mail,
                      validator: (v) =>
                          _fieldErrors['email']?.firstOrNull ??
                          AppValidators.email(v),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    TempatinTextField(
                      label: 'Kata Sandi',
                      controller: _passwordController,
                      hintText: 'Minimal 8 karakter',
                      obscureText: _obscurePassword,
                      prefixIcon: LucideIcons.lock,
                      validator: (v) =>
                          _fieldErrors['password']?.firstOrNull ??
                          AppValidators.password(v),
                      suffixIcon: IconButton(
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                        icon: Icon(
                          _obscurePassword
                              ? LucideIcons.eye
                              : LucideIcons.eyeOff,
                          size: 18,
                          color: AppColors.inkSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    TempatinTextField(
                      label: 'Konfirmasi Kata Sandi',
                      controller: _confirmController,
                      hintText: 'Ulangi kata sandi',
                      obscureText: _obscurePassword,
                      prefixIcon: LucideIcons.lockKeyhole,
                      validator: (v) {
                        if (v != _passwordController.text) {
                          return 'Konfirmasi kata sandi tidak cocok.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    CheckboxListTile(
                      value: _agreed,
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.primary,
                      onChanged: (v) => setState(() => _agreed = v ?? false),
                      title: Text(
                        'Saya menyetujui Syarat & Ketentuan serta Kebijakan Privasi TEMPATIN.',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.inkBody,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TempatinButton(
                      label: 'Daftar Sekarang',
                      icon: LucideIcons.userPlus,
                      isLoading: _isSubmitting,
                      onPressed: _submit,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sudah punya akun? ', style: AppTypography.bodySm),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Text(
                      'Masuk',
                      style: AppTypography.label.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleSelectorCard extends StatelessWidget {
  const _RoleSelectorCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.primaryTint : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.cardRadius,
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.borderHairline,
          width: selected ? 1.5 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 20,
                color: selected ? AppColors.primary : AppColors.inkSecondary,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                title,
                style: AppTypography.label.copyWith(
                  color: selected ? AppColors.primary : AppColors.inkPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(subtitle, style: AppTypography.caption),
            ],
          ),
        ),
      ),
    );
  }
}
