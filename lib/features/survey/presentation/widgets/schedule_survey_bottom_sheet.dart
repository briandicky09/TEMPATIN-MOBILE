import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/tempatin_button.dart';
import '../../../../core/widgets/tempatin_text_field.dart';
import '../../data/survey_repository.dart';
import '../providers/survey_providers.dart';

/// Bottom sheet allowing customers to schedule an on-site kos survey.
class ScheduleSurveyBottomSheet extends ConsumerStatefulWidget {
  const ScheduleSurveyBottomSheet({super.key, required this.kosSlug});

  final String kosSlug;

  static Future<bool?> show(BuildContext context, {required String kosSlug}) {
    return AppBottomSheet.show<bool>(
      context: context,
      title: 'Ajukan Jadwal Survei',
      builder: (_) => ScheduleSurveyBottomSheet(kosSlug: kosSlug),
    );
  }

  @override
  ConsumerState<ScheduleSurveyBottomSheet> createState() =>
      _ScheduleSurveyBottomSheetState();
}

class _ScheduleSurveyBottomSheetState
    extends ConsumerState<ScheduleSurveyBottomSheet> {
  static const _timeSlots = ['09:00', '11:00', '14:00', '16:00'];

  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String _selectedTime = '10:00';
  final _notesController = TextEditingController();
  bool _isSubmitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _selectedTime = _timeSlots.first;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: today.add(const Duration(days: 90)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _submit() async {
    setState(() {
      _isSubmitting = true;
      _error = null;
    });
    try {
      await ref
          .read(surveyRepositoryProvider)
          .scheduleSurvey(
            kosSlug: widget.kosSlug,
            surveyDate: DateFormatter.apiDate(_selectedDate),
            surveyTime: _selectedTime,
            notes: _notesController.text,
          );
      ref.invalidate(mySurveysProvider);
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } on AppException catch (e) {
      if (!mounted) return;
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          InkWell(
            onTap: _pickDate,
            borderRadius: AppRadii.inputRadius,
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Tanggal Kunjungan',
                prefixIcon: Icon(LucideIcons.calendar, size: 18),
              ),
              child: Text(
                DateFormatter.shortDate(_selectedDate),
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.inkPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Pilih Jam Kunjungan', style: AppTypography.label),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            children: _timeSlots
                .map(
                  (slot) => ChoiceChip(
                    label: Text(slot),
                    selected: _selectedTime == slot,
                    onSelected: (_) => setState(() => _selectedTime = slot),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: AppSpacing.lg),
          TempatinTextField(
            label: 'Catatan (Opsional)',
            controller: _notesController,
            maxLines: 3,
            hintText: 'Contoh: Ingin melihat kamar lantai 1.',
          ),
          const SizedBox(height: AppSpacing.xl),
          TempatinButton(
            label: 'Kirim Jadwal Survei',
            icon: LucideIcons.calendarCheck,
            isLoading: _isSubmitting,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
