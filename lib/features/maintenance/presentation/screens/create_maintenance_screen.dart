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
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/tempatin_button.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../../core/widgets/tempatin_text_field.dart';
import '../../../../shared/models/transaction_models.dart';
import '../../../booking/presentation/providers/booking_providers.dart';
import '../../data/maintenance_repository.dart';
import '../providers/maintenance_providers.dart';

/// Screen for active/confirmed tenants to submit room maintenance reports with photo proof.
class CreateMaintenanceScreen extends ConsumerStatefulWidget {
  const CreateMaintenanceScreen({super.key, this.initialBooking});

  final BookingModel? initialBooking;

  @override
  ConsumerState<CreateMaintenanceScreen> createState() =>
      _CreateMaintenanceScreenState();
}

class _CreateMaintenanceScreenState
    extends ConsumerState<CreateMaintenanceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _picker = ImagePicker();

  int? _selectedBookingId;
  File? _photoFile;
  bool _isSubmitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _selectedBookingId = widget.initialBooking?.id;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final xFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1280,
      imageQuality: 82,
    );
    if (xFile == null) return;
    setState(() => _photoFile = File(xFile.path));
  }

  Future<void> _submit() async {
    setState(() => _error = null);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_selectedBookingId == null) {
      setState(() => _error = 'Pilih hunian aktif terlebih dahulu.');
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(maintenanceRepositoryProvider)
          .submitReport(
            bookingId: _selectedBookingId!,
            title: _titleController.text,
            description: _descController.text,
            photoFile: _photoFile,
          );
      ref.invalidate(myMaintenanceProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Laporan kerusakan berhasil dikirim.')),
      );
      context.pop();
    } on AppException catch (e) {
      if (!mounted) return;
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingsAsync = ref.watch(myBookingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Buat Laporan Kerusakan')),
      body: bookingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => AppErrorState(
          message: err.toString(),
          onRetry: () => ref.read(myBookingsProvider.notifier).refresh(),
        ),
        data: (paginated) {
          final eligible = paginated.items
              .where((b) => b.status == 'confirmed' || b.status == 'active')
              .toList();

          if (eligible.isEmpty && widget.initialBooking == null) {
            return const AppEmptyState(
              icon: LucideIcons.wrench,
              title: 'Belum Ada Hunian Aktif',
              description: 'Laporan kerusakan hanya tersedia untuk booking berstatus Terkonfirmasi atau Aktif Dihuni.',
            );
          }

          if (_selectedBookingId == null && eligible.isNotEmpty) {
            _selectedBookingId = eligible.first.id;
          }

          final options = eligible.isNotEmpty
              ? eligible
              : [if (widget.initialBooking != null) widget.initialBooking!];

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                if (_error != null) ...[
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.dangerBg,
                      borderRadius: AppRadii.buttonRadius,
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
                TempatinCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropdownButtonFormField<int>(
                        initialValue: _selectedBookingId,
                        decoration: const InputDecoration(
                          labelText: 'Pilih Hunian / Booking',
                        ),
                        items: options
                            .map(
                              (b) => DropdownMenuItem<int>(
                                value: b.id,
                                child: Text(
                                  '${b.kos?.title ?? b.bookingCode} (${b.bookingCode})',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _selectedBookingId = v),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      TempatinTextField(
                        label: 'Judul Kendala',
                        controller: _titleController,
                        hintText: 'Contoh: Keran kamar mandi bocor',
                        validator: (v) =>
                            AppValidators.requiredField(v, label: 'Judul'),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      TempatinTextField(
                        label: 'Deskripsi Kerusakan',
                        controller: _descController,
                        maxLines: 4,
                        hintText:
                            'Jelaskan detail lokasi dan kondisi kerusakan...',
                        validator: (v) =>
                            AppValidators.requiredField(v, label: 'Deskripsi'),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text('Foto Bukti (Opsional)', style: AppTypography.label),
                      const SizedBox(height: AppSpacing.sm),
                      if (_photoFile != null)
                        ClipRRect(
                          borderRadius: AppRadii.buttonRadius,
                          child: Image.file(
                            _photoFile!,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(height: AppSpacing.sm),
                      TempatinButton(
                        label: _photoFile == null
                            ? 'Pilih Foto dari Galeri'
                            : 'Ganti Foto',
                        variant: TempatinButtonVariant.outlined,
                        icon: LucideIcons.imagePlus,
                        onPressed: _pickPhoto,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                TempatinButton(
                  label: 'Kirim Laporan',
                  icon: LucideIcons.send,
                  isLoading: _isSubmitting,
                  onPressed: _submit,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
