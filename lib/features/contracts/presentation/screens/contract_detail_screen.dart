import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/tempatin_button.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../../shared/models/transaction_models.dart';
import '../../../../shared/widgets/pdf_viewer_screen.dart';
import '../../data/contract_repository.dart';

final bookingContractProvider = FutureProvider.family
    .autoDispose<RentalContractModel, String>((ref, bookingCode) {
      return ref.read(contractRepositoryProvider).fetchForBooking(bookingCode);
    });

/// Digital rental contract viewing, electronic signing, and PDF export screen.
class ContractDetailScreen extends ConsumerStatefulWidget {
  const ContractDetailScreen({super.key, required this.bookingCode});

  final String bookingCode;

  @override
  ConsumerState<ContractDetailScreen> createState() =>
      _ContractDetailScreenState();
}

class _ContractDetailScreenState extends ConsumerState<ContractDetailScreen> {
  bool _agreed = false;
  bool _isSigning = false;

  Future<void> _sign(RentalContractModel contract) async {
    setState(() => _isSigning = true);
    try {
      await ref
          .read(contractRepositoryProvider)
          .signContract(contract.contractNumber);
      ref.invalidate(bookingContractProvider(widget.bookingCode));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kontrak sewa digital berhasil ditandatangani.'),
        ),
      );
    } on AppException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isSigning = false);
    }
  }

  void _openPdf(RentalContractModel contract) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PdfViewerScreen(
          title: 'Kontrak Sewa PDF',
          fileName: 'Kontrak-${contract.contractNumber}.pdf',
          loadBytes: () => ref
              .read(contractRepositoryProvider)
              .downloadContractPdfBytes(contract.contractNumber),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contractAsync = ref.watch(
      bookingContractProvider(widget.bookingCode),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Kontrak Sewa Digital')),
      body: contractAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => AppErrorState(
          message: err.toString(),
          onRetry: () =>
              ref.invalidate(bookingContractProvider(widget.bookingCode)),
        ),
        data: (contract) => ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            TempatinCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        contract.contractNumber,
                        style: AppTypography.caption,
                      ),
                      StatusBadge(
                        label: contract.isSigned
                            ? 'Aktif • Ditandatangani'
                            : 'Menunggu Tanda Tangan',
                        tone: contract.isSigned
                            ? StatusTone.success
                            : StatusTone.warning,
                      ),
                    ],
                  ),
                  if (contract.isSigned && contract.signedAt != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Ditandatangani pada ${DateFormatter.dateTime(contract.signedAt!)}'
                      '${contract.signerIp != null ? " (IP: ${contract.signerIp})" : ""}',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.successText,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TempatinCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Klausul Perjanjian Sewa',
                    style: AppTypography.headingSm,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SelectableText(contract.terms, style: AppTypography.bodySm),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (!contract.isSigned) ...[
              TempatinCard(
                child: Column(
                  children: [
                    CheckboxListTile(
                      value: _agreed,
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.primary,
                      onChanged: (v) => setState(() => _agreed = v ?? false),
                      title: Text(
                        'Saya telah membaca dan menyetujui seluruh syarat serta ketentuan kontrak sewa di atas secara elektronik.',
                        style: AppTypography.bodySm,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TempatinButton(
                      label: 'Tanda Tangani Kontrak',
                      icon: LucideIcons.fileSignature,
                      isLoading: _isSigning,
                      onPressed: _agreed ? () => _sign(contract) : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            TempatinButton(
              label: 'Unduh / Bagikan Kontrak PDF',
              variant: TempatinButtonVariant.secondary,
              icon: LucideIcons.download,
              onPressed: () => _openPdf(contract),
            ),
          ],
        ),
      ),
    );
  }
}
