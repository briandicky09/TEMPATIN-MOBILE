import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/status_mapper.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/tempatin_button.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../../core/widgets/tempatin_text_field.dart';
import '../../../../shared/models/kos_models.dart';
import '../../data/owner_repository.dart';
import '../providers/owner_providers.dart';

/// Individual room CRUD screen for an owner property (`/api/v1/owner/kos/{slug}/rooms`).
class OwnerRoomsScreen extends ConsumerWidget {
  const OwnerRoomsScreen({super.key, required this.kosSlug});

  final String kosSlug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomsAsync = ref.watch(ownerKosRoomsProvider(kosSlug));

    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Kamar')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openRoomEditor(context, ref),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(LucideIcons.plus),
        label: const Text('Tambah Kamar'),
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async => ref.invalidate(ownerKosRoomsProvider(kosSlug)),
        child: roomsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => AppErrorState(
            message: err.toString(),
            onRetry: () => ref.invalidate(ownerKosRoomsProvider(kosSlug)),
          ),
          data: (rooms) {
            if (rooms.isEmpty) {
              return ListView(
                children: [
                  const SizedBox(height: 48),
                  AppEmptyState(
                    icon: LucideIcons.bedDouble,
                    title: 'Belum Ada Kamar Terdaftar',
                    description: 'Tambahkan nomor kamar individual untuk memudahkan alokasi saat persetujuan booking.',
                    actionLabel: 'Tambah Kamar Pertama',
                    onAction: () => _openRoomEditor(context, ref),
                  ),
                ],
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                96,
              ),
              itemCount: rooms.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final room = rooms[index];
                final (statusLabel, tone) = StatusMapper.room(room.status);

                return TempatinCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Kamar ${room.roomNumber}',
                            style: AppTypography.headingSm,
                          ),
                          StatusBadge(label: statusLabel, tone: tone),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        [
                          if (room.floor != null) room.floor!,
                          if (room.roomType != null) room.roomType!,
                        ].join(' • '),
                        style: AppTypography.bodySm,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        CurrencyFormatter.formatMonthly(room.effectivePrice),
                        style: AppTypography.label.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      if (room.notes != null && room.notes!.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(room.notes!, style: AppTypography.caption),
                      ],
                      const Divider(
                        height: 18,
                        color: AppColors.borderHairline,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () =>
                                _openRoomEditor(context, ref, existing: room),
                            icon: const Icon(LucideIcons.pencil, size: 16),
                            label: const Text('Edit'),
                          ),
                          TextButton.icon(
                            onPressed: () => _deleteRoom(context, ref, room),
                            icon: const Icon(
                              LucideIcons.trash2,
                              size: 16,
                              color: AppColors.dangerText,
                            ),
                            label: Text(
                              'Hapus',
                              style: TextStyle(color: AppColors.dangerText),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _openRoomEditor(
    BuildContext context,
    WidgetRef ref, {
    RoomModel? existing,
  }) async {
    final saved = await AppBottomSheet.show<bool>(
      context: context,
      title: existing == null
          ? 'Tambah Kamar'
          : 'Edit Kamar ${existing.roomNumber}',
      builder: (_) => _RoomEditorSheet(kosSlug: kosSlug, existing: existing),
    );
    if (saved == true) {
      ref.invalidate(ownerKosRoomsProvider(kosSlug));
      ref.invalidate(ownerKosDetailProvider(kosSlug));
    }
  }

  Future<void> _deleteRoom(
    BuildContext context,
    WidgetRef ref,
    RoomModel room,
  ) async {
    try {
      await ref.read(ownerRepositoryProvider).deleteRoom(kosSlug, room.id);
      ref.invalidate(ownerKosRoomsProvider(kosSlug));
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Kamar berhasil dihapus.')));
    } on AppException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}

class _RoomEditorSheet extends ConsumerStatefulWidget {
  const _RoomEditorSheet({required this.kosSlug, this.existing});

  final String kosSlug;
  final RoomModel? existing;

  @override
  ConsumerState<_RoomEditorSheet> createState() => _RoomEditorSheetState();
}

class _RoomEditorSheetState extends ConsumerState<_RoomEditorSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _numberController;
  late final TextEditingController _floorController;
  late final TextEditingController _typeController;
  late final TextEditingController _priceController;
  late final TextEditingController _notesController;
  late String _status;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _numberController = TextEditingController(text: e?.roomNumber ?? '');
    _floorController = TextEditingController(text: e?.floor ?? '');
    _typeController = TextEditingController(text: e?.roomType ?? '');
    _priceController = TextEditingController(
      text: e?.priceOverride != null
          ? e!.priceOverride!.toStringAsFixed(0)
          : '',
    );
    _notesController = TextEditingController(text: e?.notes ?? '');
    _status = e?.status ?? 'available';
  }

  @override
  void dispose() {
    _numberController.dispose();
    _floorController.dispose();
    _typeController.dispose();
    _priceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final rawPrice = _priceController.text.trim();
      final priceOverride = rawPrice.isEmpty ? null : double.tryParse(rawPrice);
      await ref
          .read(ownerRepositoryProvider)
          .saveRoom(
            kosSlug: widget.kosSlug,
            roomId: widget.existing?.id,
            roomNumber: _numberController.text,
            floor: _floorController.text,
            roomType: _typeController.text,
            priceOverride: priceOverride,
            status: _status,
            notes: _notesController.text,
          );
      if (!mounted) return;
      Navigator.pop(context, true);
    } on AppException catch (e) {
      if (!mounted) return;
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_error != null) ...[
            Text(
              _error!,
              style: AppTypography.bodySm.copyWith(color: AppColors.dangerText),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          TempatinTextField(
            label: 'Nomor Kamar',
            controller: _numberController,
            hintText: 'Contoh: 101 / A1',
            validator: (v) =>
                AppValidators.requiredField(v, label: 'Nomor kamar'),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: TempatinTextField(
                  label: 'Lantai',
                  controller: _floorController,
                  hintText: 'Lantai 1',
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: TempatinTextField(
                  label: 'Tipe Kamar',
                  controller: _typeController,
                  hintText: 'AC + KM Dalam',
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          TempatinTextField(
            label: 'Harga Khusus / Bulan (Opsional)',
            controller: _priceController,
            keyboardType: TextInputType.number,
            hintText: 'Kosongkan untuk pakai harga default kos',
          ),
          const SizedBox(height: AppSpacing.md),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Status Kamar', style: AppTypography.label),
          ),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              for (final s in const [
                ('available', 'Tersedia'),
                ('occupied', 'Terisi'),
                ('maintenance', 'Perbaikan'),
              ])
                ChoiceChip(
                  label: Text(s.$2),
                  selected: _status == s.$1,
                  onSelected: (_) => setState(() => _status = s.$1),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          TempatinTextField(
            label: 'Catatan (Opsional)',
            controller: _notesController,
            maxLines: 2,
          ),
          const SizedBox(height: AppSpacing.lg),
          TempatinButton(
            label: 'Simpan Kamar',
            isLoading: _saving,
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}
