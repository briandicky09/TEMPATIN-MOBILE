import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
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
import '../../../../shared/widgets/app_smart_image.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';
import '../../data/profile_repository.dart';

/// Edit profile screen supporting multipart avatar upload & password update.
class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  File? _pickedAvatar;
  bool _isSubmitting = false;
  String? _errorMessage;
  Map<String, List<String>> _fieldErrors = const {};

  @override
  void initState() {
    super.initState();
    final user = ref.read(authSessionProvider).user;
    _nameController = TextEditingController(text: user?.name ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final xFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      imageQuality: 85,
    );
    if (xFile == null) return;
    setState(() => _pickedAvatar = File(xFile.path));
  }

  Future<void> _submit() async {
    setState(() {
      _errorMessage = null;
      _fieldErrors = const {};
    });

    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSubmitting = true);
    try {
      final updatedUser = await ref
          .read(profileRepositoryProvider)
          .updateProfile(
            name: _nameController.text,
            phone: _phoneController.text,
            avatarFile: _pickedAvatar,
            currentPassword: _currentPasswordController.text,
            password: _newPasswordController.text,
            passwordConfirmation: _confirmPasswordController.text,
          );
      ref.read(authSessionProvider.notifier).updateUser(updatedUser);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil berhasil diperbarui.')),
      );
      context.pop();
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
    final user = ref.watch(authSessionProvider).user;

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Column(
                  children: [
                    _buildAvatarPreview(user?.avatarUrl),
                    const SizedBox(height: AppSpacing.sm),
                    TextButton.icon(
                      onPressed: _pickAvatar,
                      icon: const Icon(LucideIcons.camera, size: 16),
                      label: const Text('Ganti Foto Profil'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
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
                    Text('Informasi Pribadi', style: AppTypography.headingSm),
                    const SizedBox(height: AppSpacing.md),
                    TempatinTextField(
                      label: 'Nama Lengkap',
                      controller: _nameController,
                      prefixIcon: LucideIcons.user,
                      validator: (v) =>
                          _fieldErrors['name']?.firstOrNull ??
                          AppValidators.requiredField(v, label: 'Nama'),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    TempatinTextField(
                      label: 'Nomor Handphone',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      prefixIcon: LucideIcons.phone,
                      validator: (v) {
                        if (_fieldErrors['phone'] != null) {
                          return _fieldErrors['phone']!.first;
                        }
                        if (v == null || v.trim().isEmpty) return null;
                        return AppValidators.phone(v);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              TempatinCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Ubah Kata Sandi (Opsional)',
                      style: AppTypography.headingSm,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Kosongkan bagian ini jika tidak ingin mengubah kata sandi.',
                      style: AppTypography.caption,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TempatinTextField(
                      label: 'Kata Sandi Saat Ini',
                      controller: _currentPasswordController,
                      obscureText: true,
                      prefixIcon: LucideIcons.lock,
                      validator: (v) {
                        if (_newPasswordController.text.isNotEmpty &&
                            (v == null || v.isEmpty)) {
                          return 'Masukkan kata sandi saat ini.';
                        }
                        return _fieldErrors['current_password']?.firstOrNull;
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    TempatinTextField(
                      label: 'Kata Sandi Baru',
                      controller: _newPasswordController,
                      obscureText: true,
                      prefixIcon: LucideIcons.lockKeyhole,
                      validator: (v) {
                        if (_fieldErrors['password'] != null) {
                          return _fieldErrors['password']!.first;
                        }
                        if (v == null || v.isEmpty) return null;
                        return AppValidators.password(v);
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    TempatinTextField(
                      label: 'Konfirmasi Kata Sandi Baru',
                      controller: _confirmPasswordController,
                      obscureText: true,
                      prefixIcon: LucideIcons.lockKeyhole,
                      validator: (v) {
                        if (_newPasswordController.text.isNotEmpty &&
                            v != _newPasswordController.text) {
                          return 'Konfirmasi kata sandi tidak cocok.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              TempatinButton(
                label: 'Simpan Perubahan',
                icon: LucideIcons.check,
                isLoading: _isSubmitting,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarPreview(String? avatarUrl) {
    if (_pickedAvatar != null) {
      return ClipOval(
        child: Image.file(
          _pickedAvatar!,
          width: 88,
          height: 88,
          fit: BoxFit.cover,
        ),
      );
    }
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      return ClipOval(
        child: AppSmartImage(
          source: avatarUrl,
          width: 88,
          height: 88,
          fit: BoxFit.cover,
          errorWidget: _placeholderCircle(),
        ),
      );
    }
    return _placeholderCircle();
  }

  Widget _placeholderCircle() {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: AppColors.primaryTint,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.borderHairline),
      ),
      child: const Icon(LucideIcons.user, size: 32, color: AppColors.primary),
    );
  }
}
