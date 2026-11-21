import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/tempatin_button.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../../core/widgets/tempatin_text_field.dart';
import '../../data/auth_repository.dart';

/// Reset password screen calling `POST /api/v1/auth/reset-password`.
class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key, this.initialEmail, this.initialToken});

  final String? initialEmail;
  final String? initialToken;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _tokenController;
  late final TextEditingController _emailController;
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _tokenController = TextEditingController(text: widget.initialToken ?? '');
    _emailController = TextEditingController(text: widget.initialEmail ?? '');
  }

  @override
  void dispose() {
    _tokenController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _errorMessage = null);
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSubmitting = true);
    try {
      final msg = await ref
          .read(authRepositoryProvider)
          .resetPassword(
            token: _tokenController.text,
            email: _emailController.text,
            password: _passwordController.text,
            passwordConfirmation: _confirmController.text,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      context.pop();
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
      appBar: AppBar(title: const Text('Buat Kata Sandi Baru')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      label: 'Token Reset',
                      controller: _tokenController,
                      hintText: 'Masukkan token dari email',
                      prefixIcon: LucideIcons.keyRound,
                      validator: (v) =>
                          AppValidators.requiredField(v, label: 'Token'),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    TempatinTextField(
                      label: 'Email',
                      controller: _emailController,
                      hintText: 'nama@email.com',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: LucideIcons.mail,
                      validator: AppValidators.email,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    TempatinTextField(
                      label: 'Kata Sandi Baru',
                      controller: _passwordController,
                      hintText: 'Minimal 8 karakter',
                      obscureText: _obscurePassword,
                      prefixIcon: LucideIcons.lock,
                      validator: AppValidators.password,
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
                      hintText: 'Ulangi kata sandi baru',
                      obscureText: _obscurePassword,
                      prefixIcon: LucideIcons.lockKeyhole,
                      validator: (v) {
                        if (v != _passwordController.text) {
                          return 'Konfirmasi kata sandi tidak cocok.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    TempatinButton(
                      label: 'Simpan Kata Sandi',
                      icon: LucideIcons.check,
                      isLoading: _isSubmitting,
                      onPressed: _submit,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
