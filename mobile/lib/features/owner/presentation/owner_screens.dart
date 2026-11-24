import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/router/routes.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/kos_card.dart';
import '../../../shared/widgets/local_image.dart';
import '../../../shared/widgets/tempatin_widgets.dart';

class OwnerDashboardScreen extends ConsumerWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final statsAsync = ref.watch(ownerStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 24),
            const SizedBox(width: AppSpacing.sm),
            const StatusBadge(label: 'Owner', tone: StatusTone.info),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Notifikasi',
            onPressed: () => context.push(AppRoutes.notifications),
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(LucideIcons.bell, size: 21),
                if ((statsAsync.value?.unreadNotifications ?? 0) > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        color: AppColors.dangerText,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async => ref.invalidate(ownerStatsProvider),
        child: statsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Error: $err')),
          data: (stats) {
            if (stats == null) {
              return const EmptyStateView(
                icon: LucideIcons.shieldAlert,
                title: 'Akses Khusus Owner',
                description: 'Silakan masuk menggunakan akun Pemilik Kos.',
              );
            }

            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                Text(
                  'Halo, ${session?.user.name ?? 'Pemilik Kos'}',
                  style: AppTypography.headingLg,
                ),
                const SizedBox(height: 4),
                const Text(
                  'Statistik properti dan transaksi simulasi offline.',
                  style: AppTypography.bodySm,
                ),
                const SizedBox(height: AppSpacing.lg),

                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.45,
                  children: [
                    _KpiTile(
                      label: 'Total Properti',
                      value: '${stats.totalProperties}',
                      icon: LucideIcons.building2,
                      onTap: () => context.go(AppRoutes.ownerKos),
                    ),
                    _KpiTile(
                      label: 'Total Booking',
                      value: '${stats.totalBookings}',
                      icon: LucideIcons.clipboardList,
                      onTap: () => context.go(AppRoutes.ownerBookings),
                    ),
                    _KpiTile(
                      label: 'Menunggu Approval',
                      value: '${stats.pendingBookings}',
                      icon: LucideIcons.clock,
                      highlight: stats.pendingBookings > 0,
                      onTap: () => context.go(AppRoutes.ownerBookings),
                    ),
                    _KpiTile(
                      label: 'Pendapatan Demo',
                      value: CurrencyFormatter.idr(stats.paidRevenue),
                      icon: LucideIcons.wallet,
                      smallText: true,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                TempatinButton(
                  label: 'Tambah Properti Kos Baru',
                  icon: LucideIcons.plus,
                  onPressed: () => context.push(AppRoutes.ownerKosCreate),
                ),
                const SizedBox(height: AppSpacing.xl),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Properti Anda', style: AppTypography.headingMd),
                    TextButton(
                      onPressed: () => context.go(AppRoutes.ownerKos),
                      child: const Text('Kelola Semua'),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                if (stats.properties.isEmpty)
                  const EmptyStateView(
                    icon: LucideIcons.building2,
                    title: 'Belum Ada Properti',
                    description: 'Tambahkan properti kos pertama Anda.',
                  )
                else
                  for (final item in stats.properties.take(4))
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: KosCard(
                        item: item,
                        compact: true,
                        onTap: () =>
                            context.push(AppRoutes.ownerKosEdit(item.kos.id)),
                      ),
                    ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _KpiTile extends StatelessWidget {
  const _KpiTile({
    required this.label,
    required this.value,
    required this.icon,
    this.highlight = false,
    this.smallText = false,
    this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final bool highlight;
  final bool smallText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TempatinCard(
      onTap: onTap,
      backgroundColor: highlight ? AppColors.primaryTint : AppColors.surface,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            size: 20,
            color: highlight ? AppColors.primary : AppColors.inkMuted,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: smallText
                    ? AppTypography.headingSm
                    : AppTypography.headingLg,
              ),
              Text(label, style: AppTypography.caption),
            ],
          ),
        ],
      ),
    );
  }
}

class OwnerKosListScreen extends ConsumerWidget {
  const OwnerKosListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final statsAsync = ref.watch(ownerStatsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Properti Kos')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.ownerKosCreate),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(LucideIcons.plus),
        label: const Text('Tambah Kos'),
      ),
      body: statsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (stats) {
          final items = stats?.properties ?? const [];
          if (items.isEmpty) {
            return EmptyStateView(
              icon: LucideIcons.building2,
              title: 'Belum Ada Properti',
              description: 'Klik + Tambah Kos untuk menambahkan data lokal.',
              actionLabel: 'Tambah Kos',
              onAction: () => context.push(AppRoutes.ownerKosCreate),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              96,
            ),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final item = items[index];
              final kos = item.kos;
              return TempatinCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        LocalImage(
                          path: kos.thumbnailAsset,
                          width: 68,
                          height: 68,
                          borderRadius: AppRadii.button,
                          cacheWidth: 220,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  StatusBadge(
                                    label: kos.status == 'active'
                                        ? 'Aktif'
                                        : 'Nonaktif',
                                    tone: kos.status == 'active'
                                        ? StatusTone.success
                                        : StatusTone.neutral,
                                  ),
                                  StatusBadge(
                                    label: kos.type,
                                    tone: StatusTone.info,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(kos.title, style: AppTypography.headingSm),
                              Text(
                                '${kos.city} • ${CurrencyFormatter.monthly(kos.price)}',
                                style: AppTypography.caption,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20, color: AppColors.borderHairline),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                context.push(AppRoutes.kosDetail(kos.id)),
                            icon: const Icon(LucideIcons.eye, size: 15),
                            label: const Text('Lihat'),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                context.push(AppRoutes.ownerKosEdit(kos.id)),
                            icon: const Icon(LucideIcons.pencil, size: 15),
                            label: const Text('Edit'),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        IconButton(
                          tooltip: 'Hapus Kos',
                          onPressed: () async {
                            if (session == null) return;
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Hapus Kos?'),
                                content: Text(
                                  'Properti "${kos.title}" akan dihapus dari SQLite lokal.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, false),
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, true),
                                    child: const Text(
                                      'Hapus',
                                      style: TextStyle(
                                        color: AppColors.dangerText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                            if (confirm != true) return;
                            await ref
                                .read(kosRepositoryProvider)
                                .deleteKos(kos.id, session.user.id);
                            ref.invalidate(ownerStatsProvider);
                            ref.invalidate(featuredKosProvider);
                            ref.invalidate(latestKosProvider);
                            ref.invalidate(exploreKosProvider);
                          },
                          icon: const Icon(
                            LucideIcons.trash2,
                            size: 18,
                            color: AppColors.dangerText,
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
    );
  }
}

class OwnerKosFormScreen extends ConsumerStatefulWidget {
  const OwnerKosFormScreen({super.key, this.existingKosId});

  final int? existingKosId;

  @override
  ConsumerState<OwnerKosFormScreen> createState() => _OwnerKosFormScreenState();
}

class _OwnerKosFormScreenState extends ConsumerState<OwnerKosFormScreen> {
  static const _types = ['Putri', 'Putra', 'Campur', 'Eksklusif'];
  static const _bundledPhotos = [
    'assets/images/kos/kos_001.png',
    'assets/images/kos/kos_002.png',
    'assets/images/kos/kos_003.png',
    'assets/images/kos/kos_004.png',
    'assets/images/kos/kos_005.png',
    'assets/images/kos/kos_006.png',
    'assets/images/kos/kos_007.png',
    'assets/images/kos/detail_01.jpg',
    'assets/images/kos/detail_02.jpg',
    'assets/images/kos/detail_03.jpg',
    'assets/images/kos/detail_04.jpg',
    'assets/images/kos/detail_05.jpg',
  ];

  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  final _titleCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _areaCtrl = TextEditingController(text: '16 m²');
  final _bathCtrl = TextEditingController(text: 'Dalam');
  final _garageCtrl = TextEditingController(text: 'Motor');
  final _descCtrl = TextEditingController();

  String _type = 'Putri';
  String _status = 'active';
  bool _featured = false;
  final List<String> _imagePaths = ['assets/images/kos/kos_001.png'];
  final Set<int> _facilityIds = {};
  bool _hydrated = false;
  bool _saving = false;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _cityCtrl.dispose();
    _priceCtrl.dispose();
    _addressCtrl.dispose();
    _areaCtrl.dispose();
    _bathCtrl.dispose();
    _garageCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickFromGallery() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      imageQuality: 85,
    );
    if (picked == null) return;
    final storedPath = await ref
        .read(kosRepositoryProvider)
        .persistLocalImage(picked.path);
    if (!mounted) return;
    setState(() => _imagePaths.add(storedPath));
  }

  Future<void> _save() async {
    final session = ref.read(sessionProvider);
    if (session == null) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final price = double.tryParse(_priceCtrl.text.trim());
    if (price == null || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan harga sewa yang valid.')),
      );
      return;
    }

    setState(() => _saving = true);
    await ref
        .read(kosRepositoryProvider)
        .saveKos(
          existingId: widget.existingKosId,
          ownerId: session.user.id,
          title: _titleCtrl.text,
          description: _descCtrl.text,
          price: price,
          type: _type,
          city: _cityCtrl.text,
          address: _addressCtrl.text,
          imagePaths: _imagePaths,
          facilityIds: _facilityIds,
          status: _status,
          area: _areaCtrl.text,
          bathrooms: _bathCtrl.text,
          garages: _garageCtrl.text,
          isFeatured: _featured,
        );

    ref.invalidate(ownerStatsProvider);
    ref.invalidate(featuredKosProvider);
    ref.invalidate(latestKosProvider);
    ref.invalidate(exploreKosProvider);
    if (widget.existingKosId != null) {
      ref.invalidate(kosDetailProvider(widget.existingKosId!));
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final facilitiesAsync = ref.watch(allFacilitiesProvider);
    final isEdit = widget.existingKosId != null;

    if (isEdit && !_hydrated) {
      final detailAsync = ref.watch(kosDetailProvider(widget.existingKosId!));
      return detailAsync.when(
        loading: () => Scaffold(
          appBar: AppBar(title: const Text('Edit Kos')),
          body: const Center(child: CircularProgressIndicator()),
        ),
        error: (err, _) => Scaffold(body: Center(child: Text('Error: $err'))),
        data: (detail) {
          if (detail != null && !_hydrated) {
            _hydrated = true;
            _titleCtrl.text = detail.kos.title;
            _cityCtrl.text = detail.kos.city;
            _priceCtrl.text = detail.kos.price.toStringAsFixed(0);
            _addressCtrl.text = detail.kos.address;
            _areaCtrl.text = detail.kos.area ?? '16 m²';
            _bathCtrl.text = detail.kos.bathrooms ?? 'Dalam';
            _garageCtrl.text = detail.kos.garages ?? 'Motor';
            _descCtrl.text = detail.kos.description;
            _type = detail.kos.type;
            _status = detail.kos.status;
            _featured = detail.kos.isFeatured;
            _imagePaths
              ..clear()
              ..addAll(
                detail.images.isNotEmpty
                    ? detail.images.map((e) => e.imagePath)
                    : [detail.kos.thumbnailAsset],
              );
            _facilityIds
              ..clear()
              ..addAll(detail.facilities.map((e) => e.id));
          }
          return _buildForm(isEdit: true, facilitiesAsync: facilitiesAsync);
        },
      );
    }

    return _buildForm(isEdit: isEdit, facilitiesAsync: facilitiesAsync);
  }

  Widget _buildForm({
    required bool isEdit,
    required AsyncValue<List<dynamic>> facilitiesAsync,
  }) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Properti Kos' : 'Tambah Kos Baru'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            TempatinCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Informasi Utama', style: AppTypography.headingSm),
                  const SizedBox(height: AppSpacing.md),
                  TempatinTextField(
                    label: 'Nama Kos',
                    controller: _titleCtrl,
                    validator: (v) =>
                        AppValidators.requiredField(v, label: 'Nama kos'),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Text('Tipe Kos', style: AppTypography.label),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.sm,
                    children: [
                      for (final t in _types)
                        ChoiceChip(
                          label: Text(t),
                          selected: _type == t,
                          onSelected: (_) => setState(() => _type = t),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TempatinTextField(
                    label: 'Kota',
                    controller: _cityCtrl,
                    validator: (v) =>
                        AppValidators.requiredField(v, label: 'Kota'),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TempatinTextField(
                    label: 'Harga per Bulan (Rp)',
                    controller: _priceCtrl,
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        AppValidators.requiredField(v, label: 'Harga'),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TempatinTextField(
                    label: 'Alamat Lengkap',
                    controller: _addressCtrl,
                    maxLines: 2,
                    validator: (v) =>
                        AppValidators.requiredField(v, label: 'Alamat'),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TempatinTextField(
                    label: 'Deskripsi',
                    controller: _descCtrl,
                    maxLines: 3,
                    validator: (v) =>
                        AppValidators.requiredField(v, label: 'Deskripsi'),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Status Aktif'),
                    value: _status == 'active',
                    onChanged: (v) =>
                        setState(() => _status = v ? 'active' : 'inactive'),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Tampilkan di Rekomendasi Utama'),
                    value: _featured,
                    onChanged: (v) => setState(() => _featured = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            TempatinCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Spesifikasi', style: AppTypography.headingSm),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: TempatinTextField(
                          label: 'Luas',
                          controller: _areaCtrl,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: TempatinTextField(
                          label: 'Kamar Mandi',
                          controller: _bathCtrl,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: TempatinTextField(
                          label: 'Parkir',
                          controller: _garageCtrl,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Facilities
            TempatinCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Fasilitas Kos', style: AppTypography.headingSm),
                  const SizedBox(height: AppSpacing.sm),
                  facilitiesAsync.when(
                    loading: () => const LinearProgressIndicator(),
                    error: (_, _) => const Text('Gagal memuat fasilitas'),
                    data: (facs) => Wrap(
                      spacing: AppSpacing.sm,
                      children: [
                        for (final f in facs)
                          FilterChip(
                            label: Text(f.name as String),
                            selected: _facilityIds.contains(f.id as int),
                            onSelected: (sel) {
                              setState(() {
                                if (sel) {
                                  _facilityIds.add(f.id as int);
                                } else {
                                  _facilityIds.remove(f.id as int);
                                }
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Local Images Manager
            TempatinCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gambar Kos Lokal (Bundel / Galeri HP)',
                    style: AppTypography.headingSm,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SizedBox(
                    height: 82,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _imagePaths.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(width: AppSpacing.sm),
                      itemBuilder: (context, idx) {
                        final path = _imagePaths[idx];
                        return Stack(
                          children: [
                            LocalImage(
                              path: path,
                              width: 82,
                              height: 82,
                              borderRadius: AppRadii.button,
                              cacheWidth: 220,
                            ),
                            if (_imagePaths.length > 1)
                              Positioned(
                                top: 2,
                                right: 2,
                                child: InkWell(
                                  onTap: () =>
                                      setState(() => _imagePaths.removeAt(idx)),
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      LucideIcons.x,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Text(
                    'Pilih cepat dari aset lokal bawaan:',
                    style: AppTypography.caption,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  SizedBox(
                    height: 56,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _bundledPhotos.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (_, idx) {
                        final asset = _bundledPhotos[idx];
                        final selected = _imagePaths.contains(asset);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selected && _imagePaths.length > 1) {
                                _imagePaths.remove(asset);
                              } else if (!selected) {
                                _imagePaths.add(asset);
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: AppRadii.button,
                              border: Border.all(
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.borderHairline,
                                width: selected ? 2 : 1,
                              ),
                            ),
                            child: LocalImage(
                              path: asset,
                              width: 56,
                              height: 56,
                              borderRadius: AppRadii.button,
                              cacheWidth: 160,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TempatinButton(
                    label: 'Tambah Foto dari Galeri HP',
                    variant: ButtonVariant.secondary,
                    icon: LucideIcons.imagePlus,
                    onPressed: _pickFromGallery,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            TempatinButton(
              label: isEdit ? 'Simpan Perubahan' : 'Simpan Kos Baru',
              isLoading: _saving,
              onPressed: _save,
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class OwnerBookingsScreen extends ConsumerStatefulWidget {
  const OwnerBookingsScreen({super.key});

  @override
  ConsumerState<OwnerBookingsScreen> createState() =>
      _OwnerBookingsScreenState();
}

class _OwnerBookingsScreenState extends ConsumerState<OwnerBookingsScreen> {
  String _status = 'all';

  Future<void> _reject(int bookingId) async {
    final ctrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tolak Pengajuan Booking'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(
            hintText: 'Alasan penolakan (contoh: Kamar penuh)',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Tolak',
              style: TextStyle(color: AppColors.dangerText),
            ),
          ),
        ],
      ),
    );
    final reason = ctrl.text.trim();
    ctrl.dispose();
    if (ok == true) {
      await ref
          .read(bookingRepositoryProvider)
          .rejectBooking(
            bookingId,
            reason.isEmpty ? 'Kamar sedang tidak tersedia.' : reason,
          );
      ref.invalidate(ownerBookingsProvider(_status));
      ref.invalidate(ownerStatsProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingsAsync = ref.watch(ownerBookingsProvider(_status));

    return Scaffold(
      appBar: AppBar(title: const Text('Booking Masuk (Owner)')),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: 4,
              ),
              children: [
                for (final f in const [
                  ('all', 'Semua'),
                  ('pending', 'Menunggu'),
                  ('approved', 'Disetujui'),
                  ('confirmed', 'Lunas'),
                  ('active', 'Aktif'),
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: ChoiceChip(
                      label: Text(f.$2),
                      selected: _status == f.$1,
                      onSelected: (_) => setState(() => _status = f.$1),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: bookingsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
              data: (items) {
                if (items.isEmpty) {
                  return const EmptyStateView(
                    icon: LucideIcons.clipboardList,
                    title: 'Tidak Ada Booking',
                    description: 'Belum ada pengajuan sewa di kategori ini.',
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: items.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final row = items[index];
                    final b = row.booking;
                    final (label, tone) = StatusHelper.booking(b.status);

                    return TempatinCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(b.bookingCode, style: AppTypography.caption),
                              StatusBadge(label: label, tone: tone),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(b.tenantName, style: AppTypography.headingSm),
                          Text(
                            '${row.kosTitle} • ${b.durationMonths} bln',
                            style: AppTypography.bodySm,
                          ),
                          Text(
                            '${b.tenantPhone} • ${CurrencyFormatter.idr(b.totalAmount)}',
                            style: AppTypography.caption,
                          ),
                          if (b.status == 'pending') ...[
                            const SizedBox(height: AppSpacing.md),
                            Row(
                              children: [
                                Expanded(
                                  child: TempatinButton(
                                    label: 'Setujui',
                                    onPressed: () async {
                                      await ref
                                          .read(bookingRepositoryProvider)
                                          .approveBooking(b.id);
                                      ref.invalidate(
                                        ownerBookingsProvider(_status),
                                      );
                                      ref.invalidate(ownerStatsProvider);
                                    },
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Expanded(
                                  child: TempatinButton(
                                    label: 'Tolak',
                                    variant: ButtonVariant.danger,
                                    onPressed: () => _reject(b.id),
                                  ),
                                ),
                              ],
                            ),
                          ] else if (b.status == 'confirmed') ...[
                            const SizedBox(height: AppSpacing.md),
                            TempatinButton(
                              label: 'Proses Check-In',
                              variant: ButtonVariant.secondary,
                              onPressed: () async {
                                await ref
                                    .read(bookingRepositoryProvider)
                                    .updateBookingLifecycle(b.id, 'active');
                                ref.invalidate(ownerBookingsProvider(_status));
                                ref.invalidate(ownerStatsProvider);
                              },
                            ),
                          ] else if (b.status == 'active') ...[
                            const SizedBox(height: AppSpacing.md),
                            TempatinButton(
                              label: 'Proses Check-Out',
                              variant: ButtonVariant.outlined,
                              onPressed: () async {
                                await ref
                                    .read(bookingRepositoryProvider)
                                    .updateBookingLifecycle(b.id, 'completed');
                                ref.invalidate(ownerBookingsProvider(_status));
                                ref.invalidate(ownerStatsProvider);
                              },
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
