import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/tempatin_button.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../../core/widgets/tempatin_text_field.dart';
import '../../../../shared/models/kos_models.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';
import '../../../property/presentation/providers/property_providers.dart';
import '../../data/booking_repository.dart';
import '../providers/booking_providers.dart';

/// Customer room selection & booking submission screen (Owner Approval First).
class BookingFormScreen extends ConsumerStatefulWidget {
  const BookingFormScreen({super.key, required this.kosSlug});

  final String kosSlug;

  @override
  ConsumerState<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends ConsumerState<BookingFormScreen> {
  static const double _adminFee = 25000.0;

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  final _notesController = TextEditingController();

  DateTime _startDate = DateTime.now().add(const Duration(days: 1));
  int _durationMonths = 1;
  int? _selectedRoomId;
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authSessionProvider).user;
    _nameController = TextEditingController(text: user?.name ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickStartDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: today.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _startDate = picked);
    }
  }

  Future<void> _submit(KosDetailModel kos) async {
    setState(() => _errorMessage = null);
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSubmitting = true);
    try {
      final booking = await ref
          .read(bookingRepositoryProvider)
          .createBooking(
            kosSlug: kos.slug,
            roomId: _selectedRoomId,
            tenantName: _nameController.text,
            tenantPhone: _phoneController.text,
            tenantEmail: _emailController.text,
            startDate: DateFormatter.apiDate(_startDate),
            durationMonths: _durationMonths,
            notes: _notesController.text,
          );
      ref.invalidate(myBookingsProvider);
      if (!mounted) return;
      context.pushReplacement(RoutePaths.bookingDetail(booking.bookingCode));
    } on AppException catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = e.message);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kosAsync = ref.watch(kosDetailProvider(widget.kosSlug));

    return Scaffold(
      appBar: AppBar(title: const Text('Ajukan Sewa Kos')),
      body: kosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => AppErrorState(
          message: err.toString(),
          onRetry: () => ref.invalidate(kosDetailProvider(widget.kosSlug)),
        ),
        data: (kos) {
          RoomModel? selectedRoom;
          if (_selectedRoomId != null) {
            for (final r in kos.availableRooms) {
              if (r.id == _selectedRoomId) {
                selectedRoom = r;
                break;
              }
            }
          }

          final unitPrice =
              selectedRoom != null && selectedRoom.effectivePrice > 0
              ? selectedRoom.effectivePrice
              : kos.price;
          final subtotal = unitPrice * _durationMonths;
          final total = subtotal + _adminFee;

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                // Property Banner
                TempatinCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StatusBadge(label: kos.type, tone: StatusTone.info),
                      const SizedBox(height: AppSpacing.sm),
                      Text(kos.title, style: AppTypography.headingSm),
                      const SizedBox(height: 2),
                      Text(kos.city, style: AppTypography.caption),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        CurrencyFormatter.formatMonthly(unitPrice),
                        style: AppTypography.label.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Owner Approval First Notice
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.infoBg,
                    borderRadius: AppRadii.buttonRadius,
                    border: Border.all(color: AppColors.borderHairline),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        LucideIcons.info,
                        size: 18,
                        color: AppColors.infoText,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          'Pengajuan Anda akan berstatus Menunggu Persetujuan. Pembayaran Midtrans dibuka setelah pemilik menyetujui booking.',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.infoText,
                          ),
                        ),
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
                  const SizedBox(height: AppSpacing.md),
                ],

                // Optional Room Selection
                if (kos.availableRooms.isNotEmpty) ...[
                  TempatinCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pilih Kamar (Opsional)',
                          style: AppTypography.headingSm,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Anda dapat memilih kamar tersedia atau menyerahkan penempatan ke pemilik.',
                          style: AppTypography.caption,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.sm,
                          children: [
                            ChoiceChip(
                              label: const Text('Dipilih Pemilik'),
                              selected: _selectedRoomId == null,
                              onSelected: (_) =>
                                  setState(() => _selectedRoomId = null),
                            ),
                            ...kos.availableRooms.map(
                              (room) => ChoiceChip(
                                label: Text(
                                  'Kamar ${room.roomNumber}${room.floor != null ? " (Lt.${room.floor})" : ""}',
                                ),
                                selected: _selectedRoomId == room.id,
                                onSelected: (sel) => setState(
                                  () => _selectedRoomId = sel ? room.id : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],

                // Lease Dates & Duration
                TempatinCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jadwal & Durasi Sewa',
                        style: AppTypography.headingSm,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      InkWell(
                        onTap: _pickStartDate,
                        borderRadius: AppRadii.inputRadius,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Tanggal Mulai Huni',
                            prefixIcon: Icon(LucideIcons.calendar, size: 18),
                          ),
                          child: Text(
                            DateFormatter.shortDate(_startDate),
                            style: AppTypography.bodySm.copyWith(
                              color: AppColors.inkPrimary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Durasi Sewa (Bulan)',
                            style: AppTypography.label,
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: _durationMonths > 1
                                    ? () => setState(() => _durationMonths--)
                                    : null,
                                icon: const Icon(LucideIcons.minusCircle),
                              ),
                              Text(
                                '$_durationMonths bln',
                                style: AppTypography.headingSm,
                              ),
                              IconButton(
                                onPressed: _durationMonths < 12
                                    ? () => setState(() => _durationMonths++)
                                    : null,
                                icon: const Icon(LucideIcons.plusCircle),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Tenant Details
                TempatinCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Data Penyewa', style: AppTypography.headingSm),
                      const SizedBox(height: AppSpacing.md),
                      TempatinTextField(
                        label: 'Nama Lengkap',
                        controller: _nameController,
                        prefixIcon: LucideIcons.user,
                        validator: (v) =>
                            AppValidators.requiredField(v, label: 'Nama'),
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
                        label: 'Email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: LucideIcons.mail,
                        validator: AppValidators.email,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TempatinTextField(
                        label: 'Catatan Tambahan (Opsional)',
                        controller: _notesController,
                        maxLines: 3,
                        hintText:
                            'Contoh: Membawa motor, perkiraan jam tiba...',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Cost Summary
                TempatinCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ringkasan Biaya', style: AppTypography.headingSm),
                      const SizedBox(height: AppSpacing.md),
                      _SummaryRow(
                        label:
                            'Sewa ($_durationMonths bln × ${CurrencyFormatter.formatIdr(unitPrice)})',
                        value: CurrencyFormatter.formatIdr(subtotal),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      _SummaryRow(
                        label: 'Biaya Layanan Admin',
                        value: CurrencyFormatter.formatIdr(_adminFee),
                      ),
                      const Divider(
                        height: 20,
                        color: AppColors.borderHairline,
                      ),
                      _SummaryRow(
                        label: 'Total Pembayaran',
                        value: CurrencyFormatter.formatIdr(total),
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                TempatinButton(
                  label: 'Kirim Pengajuan Sewa',
                  icon: LucideIcons.send,
                  isLoading: _isSubmitting,
                  onPressed: () => _submit(kos),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: isTotal ? AppTypography.headingSm : AppTypography.bodySm,
          ),
        ),
        Text(
          value,
          style: isTotal
              ? AppTypography.headingSm.copyWith(color: AppColors.primary)
              : AppTypography.label,
        ),
      ],
    );
  }
}
