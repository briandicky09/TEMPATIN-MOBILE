import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/tempatin_button.dart';
import '../../../../core/widgets/tempatin_text_field.dart';
import '../../../property/presentation/providers/property_providers.dart';
import '../../data/review_repository.dart';

/// Modal sheet for verified tenants to submit a 1-5 star review.
class WriteReviewBottomSheet extends ConsumerStatefulWidget {
  const WriteReviewBottomSheet({super.key, required this.kosSlug});

  final String kosSlug;

  static Future<bool?> show(BuildContext context, {required String kosSlug}) {
    return AppBottomSheet.show<bool>(
      context: context,
      title: 'Tulis Ulasan Penghuni',
      builder: (_) => WriteReviewBottomSheet(kosSlug: kosSlug),
    );
  }

  @override
  ConsumerState<WriteReviewBottomSheet> createState() =>
      _WriteReviewBottomSheetState();
}

class _WriteReviewBottomSheetState
    extends ConsumerState<WriteReviewBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  int _rating = 5;
  bool _isSubmitting = false;
  String? _error;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _error = null);
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(reviewRepositoryProvider)
          .submitReview(
            kosSlug: widget.kosSlug,
            rating: _rating,
            comment: _commentController.text,
          );
      ref.invalidate(kosDetailProvider(widget.kosSlug));
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
      child: Form(
        key: _formKey,
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
            Text('Penilaian Anda', style: AppTypography.label),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (idx) {
                final star = idx + 1;
                return IconButton(
                  onPressed: () => setState(() => _rating = star),
                  icon: Icon(
                    star <= _rating
                        ? Icons.star_rounded
                        : Icons.star_border_rounded,
                    size: 36,
                    color: AppColors.accentMarigold,
                  ),
                );
              }),
            ),
            const SizedBox(height: AppSpacing.md),
            TempatinTextField(
              label: 'Ulasan',
              controller: _commentController,
              maxLines: 4,
              hintText: 'Bagikan pengalaman tinggal Anda di kos ini...',
              validator: (v) {
                if (v == null || v.trim().length < 5) {
                  return 'Ulasan minimal 5 karakter.';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            TempatinButton(
              label: 'Kirim Ulasan',
              icon: LucideIcons.send,
              isLoading: _isSubmitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
