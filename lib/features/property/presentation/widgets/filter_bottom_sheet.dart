import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/tempatin_button.dart';
import '../../../../core/widgets/tempatin_text_field.dart';
import '../../domain/kos_filter.dart';
import '../providers/property_providers.dart';

/// Multi-parameter filter sheet mirroring Laravel `KosController@index` filters.
class FilterBottomSheet extends ConsumerStatefulWidget {
  const FilterBottomSheet({super.key, required this.initialFilter});

  final KosFilter initialFilter;

  static Future<KosFilter?> show(
    BuildContext context, {
    required KosFilter current,
  }) {
    return AppBottomSheet.show<KosFilter>(
      context: context,
      title: 'Filter Pencarian Kos',
      builder: (_) => FilterBottomSheet(initialFilter: current),
    );
  }

  @override
  ConsumerState<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends ConsumerState<FilterBottomSheet> {
  static const _types = ['Putri', 'Putra', 'Campur', 'Eksklusif'];
  static const _quickCities = [
    'Surabaya',
    'Malang',
    'Yogyakarta',
    'Bandung',
    'Jakarta Selatan',
    'Semarang',
  ];

  late String? _type;
  late TextEditingController _cityController;
  late TextEditingController _minPriceController;
  late TextEditingController _maxPriceController;
  late Set<int> _facilityIds;
  late KosSortOption _sort;

  @override
  void initState() {
    super.initState();
    _type = widget.initialFilter.type;
    _cityController = TextEditingController(
      text: widget.initialFilter.city ?? '',
    );
    _minPriceController = TextEditingController(
      text: widget.initialFilter.minPrice?.toInt().toString() ?? '',
    );
    _maxPriceController = TextEditingController(
      text: widget.initialFilter.maxPrice?.toInt().toString() ?? '',
    );
    _facilityIds = widget.initialFilter.facilityIds.toSet();
    _sort = widget.initialFilter.sort;
  }

  @override
  void dispose() {
    _cityController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _type = null;
      _cityController.clear();
      _minPriceController.clear();
      _maxPriceController.clear();
      _facilityIds.clear();
      _sort = KosSortOption.newest;
    });
  }

  void _apply() {
    final minPrice = double.tryParse(_minPriceController.text.trim());
    final maxPrice = double.tryParse(_maxPriceController.text.trim());
    final cityText = _cityController.text.trim();

    Navigator.of(context).pop(
      widget.initialFilter.copyWith(
        type: () => _type,
        city: () => cityText.isEmpty ? null : cityText,
        minPrice: () => minPrice,
        maxPrice: () => maxPrice,
        facilityIds: _facilityIds.toList(),
        sort: _sort,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final facilitiesAsync = ref.watch(facilitiesProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Urutkan', style: AppTypography.headingSm),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: KosSortOption.values
                      .map(
                        (option) => ChoiceChip(
                          label: Text(option.label),
                          selected: _sort == option,
                          onSelected: (_) => setState(() => _sort = option),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: AppSpacing.xl),

                Text('Tipe Kos', style: AppTypography.headingSm),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: _types
                      .map(
                        (type) => ChoiceChip(
                          label: Text(type),
                          selected: _type == type,
                          onSelected: (selected) =>
                              setState(() => _type = selected ? type : null),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: AppSpacing.xl),

                TempatinTextField(
                  label: 'Kota / Area',
                  controller: _cityController,
                  hintText: 'Contoh: Surabaya, Bandung, Malang',
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.xs + 2,
                  runSpacing: AppSpacing.xs,
                  children: _quickCities
                      .map(
                        (city) => ActionChip(
                          label: Text(city, style: AppTypography.caption),
                          onPressed: () =>
                              setState(() => _cityController.text = city),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: AppSpacing.xl),

                Text(
                  'Rentang Harga per Bulan (Rp)',
                  style: AppTypography.headingSm,
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: TempatinTextField(
                        label: 'Minimum',
                        controller: _minPriceController,
                        hintText: '500000',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: TempatinTextField(
                        label: 'Maksimum',
                        controller: _maxPriceController,
                        hintText: '2000000',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),

                Text('Fasilitas', style: AppTypography.headingSm),
                const SizedBox(height: AppSpacing.sm),
                facilitiesAsync.when(
                  loading: () =>
                      Text('Memuat fasilitas...', style: AppTypography.bodySm),
                  error: (_, _) => Text(
                    'Daftar fasilitas tidak dapat dimuat.',
                    style: AppTypography.bodySm,
                  ),
                  data: (facilities) {
                    if (facilities.isEmpty) {
                      return Text(
                        'Belum ada data fasilitas.',
                        style: AppTypography.bodySm,
                      );
                    }
                    return Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: facilities
                          .map(
                            (f) => FilterChip(
                              label: Text(f.name),
                              selected: _facilityIds.contains(f.id),
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    _facilityIds.add(f.id);
                                  } else {
                                    _facilityIds.remove(f.id);
                                  }
                                });
                              },
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(
              top: BorderSide(color: AppColors.borderHairline, width: 1),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TempatinButton(
                  label: 'Reset',
                  variant: TempatinButtonVariant.outlined,
                  onPressed: _reset,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                flex: 2,
                child: TempatinButton(
                  label: 'Terapkan Filter',
                  onPressed: _apply,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
