import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
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
import '../../../../shared/models/facility_model.dart';
import '../../../../shared/models/kos_models.dart';
import '../../../maps/presentation/widgets/kos_osm_map_card.dart';
import '../../../property/presentation/providers/property_providers.dart';
import '../../data/owner_repository.dart';
import '../providers/owner_providers.dart';

/// Create or edit an Owner kos property with photos, facilities, and OSM map picker.
class OwnerKosFormScreen extends ConsumerStatefulWidget {
  const OwnerKosFormScreen({super.key, this.existingSlug});

  final String? existingSlug;

  @override
  ConsumerState<OwnerKosFormScreen> createState() => _OwnerKosFormScreenState();
}

class _OwnerKosFormScreenState extends ConsumerState<OwnerKosFormScreen> {
  static const _types = ['Putra', 'Putri', 'Campur', 'Eksklusif'];

  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  final _titleController = TextEditingController();
  final _cityController = TextEditingController();
  final _priceController = TextEditingController();
  final _addressController = TextEditingController();
  final _areaController = TextEditingController();
  final _roomsController = TextEditingController();
  final _bathroomsController = TextEditingController();
  final _bedroomsController = TextEditingController();
  final _garagesController = TextEditingController();
  final _descController = TextEditingController();

  String _type = 'Putra';
  String _status = 'active';
  double? _latitude;
  double? _longitude;
  final Set<int> _selectedFacilities = {};
  final Set<int> _deletePhotoIds = {};
  File? _thumbnailFile;
  final List<File> _galleryFiles = [];

  bool _hydrated = false;
  bool _isSaving = false;
  String? _error;

  @override
  void dispose() {
    _titleController.dispose();
    _cityController.dispose();
    _priceController.dispose();
    _addressController.dispose();
    _areaController.dispose();
    _roomsController.dispose();
    _bathroomsController.dispose();
    _bedroomsController.dispose();
    _garagesController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _hydrateFrom(KosDetailModel kos) {
    if (_hydrated) return;
    _hydrated = true;
    _titleController.text = kos.title;
    _cityController.text = kos.city;
    _priceController.text = kos.price.toStringAsFixed(0);
    _addressController.text = kos.address ?? '';
    _areaController.text = kos.area ?? '';
    _roomsController.text = kos.roomsSummary ?? '';
    _bathroomsController.text = kos.bathrooms ?? '';
    _bedroomsController.text = kos.bedrooms ?? '';
    _garagesController.text = kos.garages ?? '';
    _descController.text = kos.description ?? '';
    _type = _types.firstWhere(
      (t) => t.toLowerCase() == kos.type.toLowerCase(),
      orElse: () => 'Putra',
    );
    _status = kos.status;
    _latitude = kos.latitude;
    _longitude = kos.longitude;
    _selectedFacilities.addAll(kos.facilities.map((f) => f.id));
  }

  Future<void> _pickThumbnail() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 85,
    );
    if (picked != null && mounted) {
      setState(() => _thumbnailFile = File(picked.path));
    }
  }

  Future<void> _pickGalleryPhotos() async {
    final picked = await _picker.pickMultiImage(
      maxWidth: 1600,
      imageQuality: 85,
    );
    if (picked.isNotEmpty && mounted) {
      setState(() {
        _galleryFiles.addAll(picked.map((x) => File(x.path)));
      });
    }
  }

  Future<void> _openMapPicker() async {
    final initial = (_latitude != null && _longitude != null)
        ? LatLng(_latitude!, _longitude!)
        : null;
    final picked = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (_) => MapLocationPickerScreen(initialPoint: initial),
      ),
    );
    if (picked != null && mounted) {
      setState(() {
        _latitude = picked.latitude;
        _longitude = picked.longitude;
      });
    }
  }

  Future<void> _save() async {
    setState(() => _error = null);
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final price = double.tryParse(_priceController.text.trim());
    if (price == null || price < 0) {
      setState(() => _error = 'Harga sewa per bulan harus berupa angka valid.');
      return;
    }

    setState(() => _isSaving = true);
    try {
      await ref
          .read(ownerRepositoryProvider)
          .saveKos(
            existingSlug: widget.existingSlug,
            title: _titleController.text,
            type: _type,
            city: _cityController.text,
            price: price,
            address: _addressController.text,
            area: _areaController.text,
            roomsSummary: _roomsController.text,
            bathrooms: _bathroomsController.text,
            bedrooms: _bedroomsController.text,
            garages: _garagesController.text,
            latitude: _latitude,
            longitude: _longitude,
            description: _descController.text,
            status: widget.existingSlug != null ? _status : null,
            facilityIds: _selectedFacilities.toList(),
            thumbnailFile: _thumbnailFile,
            photoFiles: _galleryFiles,
            deletePhotoIds: _deletePhotoIds.toList(),
          );
      ref.invalidate(ownerKosListProvider);
      ref.invalidate(ownerDashboardProvider);
      if (widget.existingSlug != null) {
        ref.invalidate(ownerKosDetailProvider(widget.existingSlug!));
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Properti kos berhasil disimpan.')),
      );
      Navigator.pop(context, true);
    } on AppException catch (e) {
      if (!mounted) return;
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final facilitiesAsync = ref.watch(facilitiesProvider);
    final isEdit = widget.existingSlug != null;

    if (!isEdit) {
      return _buildScaffold(
        title: 'Tambah Properti Kos',
        existingKos: null,
        facilitiesAsync: facilitiesAsync,
      );
    }

    final kosAsync = ref.watch(ownerKosDetailProvider(widget.existingSlug!));
    return kosAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Edit Properti Kos')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        appBar: AppBar(title: const Text('Edit Properti Kos')),
        body: AppErrorState(
          message: err.toString(),
          onRetry: () =>
              ref.invalidate(ownerKosDetailProvider(widget.existingSlug!)),
        ),
      ),
      data: (kos) {
        _hydrateFrom(kos);
        return _buildScaffold(
          title: 'Edit Properti Kos',
          existingKos: kos,
          facilitiesAsync: facilitiesAsync,
        );
      },
    );
  }

  Widget _buildScaffold({
    required String title,
    required KosDetailModel? existingKos,
    required AsyncValue<List<FacilityModel>> facilitiesAsync,
  }) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Informasi Utama', style: AppTypography.headingSm),
                  const SizedBox(height: AppSpacing.md),
                  TempatinTextField(
                    label: 'Nama Kos',
                    controller: _titleController,
                    validator: (v) =>
                        AppValidators.requiredField(v, label: 'Nama kos'),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text('Tipe Kos', style: AppTypography.label),
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
                    label: 'Kota / Kabupaten',
                    controller: _cityController,
                    validator: (v) =>
                        AppValidators.requiredField(v, label: 'Kota'),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TempatinTextField(
                    label: 'Harga Dasar / Bulan (Rp)',
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        AppValidators.requiredField(v, label: 'Harga'),
                  ),
                  if (existingKos != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Status Properti Aktif',
                        style: AppTypography.label,
                      ),
                      value: _status == 'active',
                      onChanged: (v) =>
                          setState(() => _status = v ? 'active' : 'inactive'),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Location & OSM Map Picker
            TempatinCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Alamat & Lokasi Peta', style: AppTypography.headingSm),
                  const SizedBox(height: AppSpacing.md),
                  TempatinTextField(
                    label: 'Alamat Lengkap',
                    controller: _addressController,
                    maxLines: 2,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (_latitude != null && _longitude != null) ...[
                    KosOsmMapCard(
                      latitude: _latitude!,
                      longitude: _longitude!,
                      height: 150,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                  TempatinButton(
                    label: _latitude != null
                        ? 'Ubah Titik Lokasi di Peta'
                        : 'Pilih Lokasi di Peta (OSM)',
                    variant: TempatinButtonVariant.secondary,
                    icon: LucideIcons.mapPin,
                    onPressed: _openMapPicker,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Specs
            TempatinCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Spesifikasi & Deskripsi',
                    style: AppTypography.headingSm,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: TempatinTextField(
                          label: 'Luas (m²)',
                          controller: _areaController,
                          hintText: '3x4 m',
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: TempatinTextField(
                          label: 'Kapasitas Kamar',
                          controller: _roomsController,
                          hintText: '12 Kamar',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: TempatinTextField(
                          label: 'Kamar Mandi',
                          controller: _bathroomsController,
                          hintText: 'Dalam',
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: TempatinTextField(
                          label: 'Parkir',
                          controller: _garagesController,
                          hintText: 'Motor & Mobil',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TempatinTextField(
                    label: 'Deskripsi Properti',
                    controller: _descController,
                    maxLines: 4,
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
                  Text('Fasilitas Kos', style: AppTypography.headingSm),
                  const SizedBox(height: AppSpacing.sm),
                  facilitiesAsync.when(
                    loading: () => const LinearProgressIndicator(),
                    error: (_, _) =>
                        const Text('Gagal memuat daftar fasilitas.'),
                    data: (items) => Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        for (final f in items)
                          FilterChip(
                            label: Text(f.name),
                            selected: _selectedFacilities.contains(f.id),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedFacilities.add(f.id);
                                } else {
                                  _selectedFacilities.remove(f.id);
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

            // Media Photos
            TempatinCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Foto Utama & Galeri', style: AppTypography.headingSm),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: TempatinButton(
                          label: _thumbnailFile != null
                              ? 'Thumbnail Dipilih'
                              : 'Pilih Foto Utama',
                          variant: TempatinButtonVariant.secondary,
                          icon: LucideIcons.image,
                          onPressed: _pickThumbnail,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: TempatinButton(
                          label: 'Tambah Galeri (${_galleryFiles.length})',
                          variant: TempatinButtonVariant.outlined,
                          icon: LucideIcons.images,
                          onPressed: _pickGalleryPhotos,
                        ),
                      ),
                    ],
                  ),
                  if (existingKos != null && existingKos.photos.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Foto Galeri Saat Ini (ketuk untuk tandai hapus):',
                      style: AppTypography.caption,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        for (final p in existingKos.photos)
                          FilterChip(
                            label: Text('Foto #${p.sortOrder}'),
                            selected: _deletePhotoIds.contains(p.id),
                            selectedColor: AppColors.dangerBg,
                            onSelected: (del) {
                              setState(() {
                                if (del) {
                                  _deletePhotoIds.add(p.id);
                                } else {
                                  _deletePhotoIds.remove(p.id);
                                }
                              });
                            },
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            TempatinButton(
              label: existingKos == null
                  ? 'Terbitkan Properti Kos'
                  : 'Simpan Perubahan Properti',
              icon: LucideIcons.save,
              isLoading: _isSaving,
              onPressed: _save,
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
