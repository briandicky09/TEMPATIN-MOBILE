import 'package:dio/dio.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/config/app_mode_provider.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/tempatin_button.dart';

/// Embedded OpenStreetMap preview (Live Mode) or offline architectural coordinate preview (Demo Mode).
class KosOsmMapCard extends ConsumerWidget {
  const KosOsmMapCard({
    super.key,
    required this.latitude,
    required this.longitude,
    this.height = 180,
  });

  final double latitude;
  final double longitude;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOfflineDemo = ref.watch(appModeProvider).isOfflineDemo;
    final center = LatLng(latitude, longitude);

    return ClipRRect(
      borderRadius: AppRadii.buttonRadius,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderHairline),
          borderRadius: AppRadii.buttonRadius,
          color: AppColors.canvas,
        ),
        child: isOfflineDemo
            ? _OfflineMapPreview(latitude: latitude, longitude: longitude)
            : FlutterMap(
                options: MapOptions(
                  initialCenter: center,
                  initialZoom: 15,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.none,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.tempatin.mobile',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: center,
                        width: 40,
                        height: 40,
                        child: const Icon(
                          LucideIcons.mapPin,
                          size: 32,
                          color: AppColors.primary,
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

class _OfflineMapPreview extends StatelessWidget {
  const _OfflineMapPreview({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _OfflineGridPainter(),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.borderHairline),
              ),
              child: const Icon(
                LucideIcons.mapPin,
                size: 26,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.94),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.borderHairline),
              ),
              child: Text(
                '${latitude.toStringAsFixed(4)}, ${longitude.toStringAsFixed(4)} • Peta Offline',
                style: AppTypography.caption.copyWith(
                  color: AppColors.inkCharcoal,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OfflineGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.borderHairline
      ..strokeWidth = 1;
    const step = 28.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _NominatimPlace {
  const _NominatimPlace({required this.displayName, required this.point});

  final String displayName;
  final LatLng point;
}

/// Interactive OpenStreetMap pin picker (Live Mode) or offline coordinate preset picker (Demo Mode).
class MapLocationPickerScreen extends ConsumerStatefulWidget {
  const MapLocationPickerScreen({super.key, this.initialPoint});

  final LatLng? initialPoint;

  @override
  ConsumerState<MapLocationPickerScreen> createState() =>
      _MapLocationPickerScreenState();
}

class _MapLocationPickerScreenState
    extends ConsumerState<MapLocationPickerScreen> {
  static const _defaultPoint = LatLng(-7.79558, 110.36949); // Yogyakarta

  static const _offlinePresets = <({String label, LatLng point})>[
    (label: 'Yogyakarta (Pogung)', point: LatLng(-7.7638, 110.3765)),
    (label: 'Bandung (Dago)', point: LatLng(-6.8856, 107.6138)),
    (label: 'Jakarta Selatan (Kemang)', point: LatLng(-6.2654, 106.8195)),
    (label: 'Depok (Kukusan UI)', point: LatLng(-6.3642, 106.8211)),
    (label: 'Surabaya (Dharmawangsa)', point: LatLng(-7.2741, 112.7582)),
  ];

  final _mapController = MapController();
  final _searchController = TextEditingController();
  final _nominatimDio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 8),
      receiveTimeout: const Duration(seconds: 8),
      headers: const {'User-Agent': 'TempatinMobile/1.0'},
    ),
  );

  late LatLng _selectedPoint;
  bool _searching = false;
  List<_NominatimPlace> _results = const [];

  @override
  void initState() {
    super.initState();
    _selectedPoint = widget.initialPoint ?? _defaultPoint;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _nominatimDio.close();
    super.dispose();
  }

  Future<void> _searchAddress() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() => _searching = true);
    try {
      final response = await _nominatimDio.get<List<dynamic>>(
        'https://nominatim.openstreetmap.org/search',
        queryParameters: {'format': 'json', 'limit': 5, 'q': query},
      );
      final raw = response.data ?? const [];
      final list = <_NominatimPlace>[];
      for (final item in raw) {
        if (item is Map<String, dynamic>) {
          final lat = double.tryParse(item['lat']?.toString() ?? '');
          final lon = double.tryParse(item['lon']?.toString() ?? '');
          final name = item['display_name']?.toString() ?? '';
          if (lat != null && lon != null && name.isNotEmpty) {
            list.add(
              _NominatimPlace(displayName: name, point: LatLng(lat, lon)),
            );
          }
        }
      }
      if (!mounted) return;
      setState(() => _results = list);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mencari alamat di Nominatim.')),
      );
    } finally {
      if (mounted) setState(() => _searching = false);
    }
  }

  void _selectPoint(LatLng point, {bool moveCamera = false}) {
    setState(() {
      _selectedPoint = point;
      _results = const [];
    });
    if (moveCamera) {
      _mapController.move(point, 16);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOfflineDemo = ref.watch(appModeProvider).isOfflineDemo;

    if (isOfflineDemo) {
      return Scaffold(
        appBar: AppBar(title: const Text('Pilih Lokasi Kos (Offline)')),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const StatusBadge(
              label: 'Mode Demo Offline • Koordinat Preset Lokal',
              tone: StatusTone.info,
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: AppRadii.buttonRadius,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.canvas,
                    border: Border.all(color: AppColors.borderHairline),
                    borderRadius: AppRadii.buttonRadius,
                  ),
                  child: _OfflineMapPreview(
                    latitude: _selectedPoint.latitude,
                    longitude: _selectedPoint.longitude,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Pilih Area Kota', style: AppTypography.headingSm),
            const SizedBox(height: AppSpacing.sm),
            ..._offlinePresets.map(
              (preset) => Card(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: ListTile(
                  leading: const Icon(
                    LucideIcons.mapPin,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  title: Text(preset.label, style: AppTypography.label),
                  subtitle: Text(
                    '${preset.point.latitude.toStringAsFixed(4)}, ${preset.point.longitude.toStringAsFixed(4)}',
                    style: AppTypography.caption,
                  ),
                  trailing: _selectedPoint == preset.point
                      ? const Icon(
                          LucideIcons.check,
                          size: 18,
                          color: AppColors.primary,
                        )
                      : null,
                  onTap: () => _selectPoint(preset.point),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            TempatinButton(
              label: 'Gunakan Titik Lokasi Ini',
              icon: LucideIcons.check,
              onPressed: () => Navigator.pop(context, _selectedPoint),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Titik Lokasi Kos')),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _selectedPoint,
              initialZoom: 15,
              onTap: (_, point) => _selectPoint(point),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.tempatin.mobile',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _selectedPoint,
                    width: 44,
                    height: 44,
                    child: const Icon(
                      LucideIcons.mapPin,
                      size: 36,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Search Box
          Positioned(
            top: AppSpacing.md,
            left: AppSpacing.md,
            right: AppSpacing.md,
            child: Column(
              children: [
                Material(
                  elevation: 2,
                  borderRadius: AppRadii.buttonRadius,
                  color: AppColors.surface,
                  child: TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _searchAddress(),
                    decoration: InputDecoration(
                      hintText: 'Cari nama jalan / kecamatan...',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      suffixIcon: IconButton(
                        onPressed: _searching ? null : _searchAddress,
                        icon: _searching
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(LucideIcons.search, size: 18),
                      ),
                    ),
                  ),
                ),
                if (_results.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    constraints: const BoxConstraints(maxHeight: 200),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppRadii.buttonRadius,
                      border: Border.all(color: AppColors.borderHairline),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: _results.length,
                      separatorBuilder: (_, _) => const Divider(
                        height: 1,
                        color: AppColors.borderHairline,
                      ),
                      itemBuilder: (context, index) {
                        final place = _results[index];
                        return ListTile(
                          dense: true,
                          title: Text(
                            place.displayName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.bodySm,
                          ),
                          onTap: () =>
                              _selectPoint(place.point, moveCamera: true),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),

          // Confirm Bottom Panel
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(
                  top: BorderSide(color: AppColors.borderHairline),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ketuk peta untuk memindahkan pin koordinat:',
                      style: AppTypography.caption,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${_selectedPoint.latitude.toStringAsFixed(6)}, ${_selectedPoint.longitude.toStringAsFixed(6)}',
                      style: AppTypography.label,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TempatinButton(
                      label: 'Gunakan Titik Lokasi Ini',
                      icon: LucideIcons.check,
                      onPressed: () => Navigator.pop(context, _selectedPoint),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
