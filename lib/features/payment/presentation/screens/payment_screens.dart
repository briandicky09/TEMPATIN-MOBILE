import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/config/app_mode_provider.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/tempatin_button.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../../shared/models/transaction_models.dart';
import '../../../booking/presentation/providers/booking_providers.dart';
import '../../../invoice/presentation/providers/invoice_providers.dart';
import '../../data/payment_repository.dart';

/// Step 1: Review booking summary and initiate server-side Midtrans Snap session.
class PaymentSummaryScreen extends ConsumerStatefulWidget {
  const PaymentSummaryScreen({
    super.key,
    required this.bookingCode,
    this.booking,
  });

  final String bookingCode;
  final BookingModel? booking;

  @override
  ConsumerState<PaymentSummaryScreen> createState() =>
      _PaymentSummaryScreenState();
}

class _PaymentSummaryScreenState extends ConsumerState<PaymentSummaryScreen> {
  bool _isLoading = false;
  String? _error;

  Future<void> _startMidtrans() async {
    final isOfflineDemo = ref.read(appModeProvider).isOfflineDemo;
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final initRes = await ref
          .read(paymentRepositoryProvider)
          .initPayment(widget.bookingCode);
      if (!mounted) return;
      if (isOfflineDemo) {
        await Navigator.of(context).pushReplacement<void, void>(
          MaterialPageRoute(
            builder: (_) => PaymentResultScreen(
              bookingCode: widget.bookingCode,
              paymentCode: initRes.paymentCode,
            ),
          ),
        );
      } else {
        await Navigator.of(context).push<void>(
          MaterialPageRoute(
            builder: (_) => MidtransWebViewScreen(
              bookingCode: widget.bookingCode,
              initResult: initRes,
            ),
          ),
        );
      }
      ref.invalidate(bookingDetailProvider(widget.bookingCode));
      ref.invalidate(myBookingsProvider);
      ref.invalidate(myInvoicesProvider);
    } on AppException catch (e) {
      if (!mounted) return;
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOfflineDemo = ref.watch(appModeProvider).isOfflineDemo;
    final bookingAsync = widget.booking != null
        ? AsyncData(widget.booking!)
        : ref.watch(bookingDetailProvider(widget.bookingCode));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isOfflineDemo ? 'Simulasi Pembayaran Demo' : 'Pembayaran Midtrans',
        ),
      ),
      body: bookingAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text(err.toString())),
        data: (booking) => ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            TempatinCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StatusBadge(
                    label: 'Disetujui Pemilik • Siap Bayar',
                    tone: StatusTone.info,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    booking.kos?.title ?? booking.bookingCode,
                    style: AppTypography.headingMd,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Kode Booking: ${booking.bookingCode}',
                    style: AppTypography.caption,
                  ),
                  const Divider(height: 24, color: AppColors.borderHairline),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Tagihan', style: AppTypography.body),
                      Text(
                        CurrencyFormatter.formatIdr(booking.totalAmount),
                        style: AppTypography.headingMd.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TempatinCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isOfflineDemo
                        ? 'Simulasi Pembayaran Offline'
                        : 'Metode Pembayaran Tersedia',
                    style: AppTypography.headingSm,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    isOfflineDemo
                        ? 'Mode Demo Offline aktif: transaksi disimulasikan langsung di database SQLite lokal tanpa membuka gerbang Midtrans atau transaksi uang asli.'
                        : 'Virtual Account (BCA, BNI, BRI, Mandiri), QRIS, GoPay, ShopeePay, dan Kartu Kredit/Debit melalui gerbang resmi Midtrans.',
                    style: AppTypography.bodySm,
                  ),
                ],
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.dangerBg,
                  borderRadius: AppRadii.buttonRadius,
                  border: Border.all(color: AppColors.borderHairline),
                ),
                child: Text(
                  _error!,
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.dangerText,
                  ),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.xl),
            TempatinButton(
              label: isOfflineDemo
                  ? 'Konfirmasi Pembayaran Demo Offline'
                  : 'Lanjut ke Midtrans Snap',
              icon: LucideIcons.shieldCheck,
              isLoading: _isLoading,
              onPressed: _startMidtrans,
            ),
          ],
        ),
      ),
    );
  }
}

/// Step 2: Controlled Midtrans Snap WebView that verifies payment server-side on completion.
class MidtransWebViewScreen extends StatefulWidget {
  const MidtransWebViewScreen({
    super.key,
    required this.bookingCode,
    required this.initResult,
  });

  final String bookingCode;
  final PayInitResult initResult;

  @override
  State<MidtransWebViewScreen> createState() => _MidtransWebViewScreenState();
}

class _MidtransWebViewScreenState extends State<MidtransWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoadingPage = true;
  bool _navigatedToResult = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) setState(() => _isLoadingPage = true);
          },
          onPageFinished: (url) {
            if (mounted) setState(() => _isLoadingPage = false);
            _checkCallbackUrl(url);
          },
          onNavigationRequest: (request) {
            if (_isMidtransReturnUrl(request.url)) {
              _goToResult();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.initResult.snapRedirectUrl));
  }

  bool _isMidtransReturnUrl(String url) {
    final lower = url.toLowerCase();
    return lower.contains('/member/booking/detail/') ||
        lower.contains('transaction_status=') ||
        lower.contains('status_code=');
  }

  void _checkCallbackUrl(String url) {
    if (_isMidtransReturnUrl(url)) {
      _goToResult();
    }
  }

  void _goToResult() {
    if (_navigatedToResult || !mounted) return;
    _navigatedToResult = true;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => PaymentResultScreen(
          bookingCode: widget.bookingCode,
          paymentCode: widget.initResult.paymentCode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Midtrans'),
        actions: [
          TextButton(onPressed: _goToResult, child: const Text('Cek Status')),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoadingPage)
            const LinearProgressIndicator(color: AppColors.primary),
        ],
      ),
    );
  }
}

/// Step 3: Server-side verified payment status screen (`GET /api/v1/payments/{code}/sync`).
class PaymentResultScreen extends ConsumerStatefulWidget {
  const PaymentResultScreen({
    super.key,
    required this.bookingCode,
    required this.paymentCode,
  });

  final String bookingCode;
  final String paymentCode;

  @override
  ConsumerState<PaymentResultScreen> createState() =>
      _PaymentResultScreenState();
}

class _PaymentResultScreenState extends ConsumerState<PaymentResultScreen> {
  bool _isSyncing = true;
  PaymentSyncResult? _result;
  String? _error;

  @override
  void initState() {
    super.initState();
    _syncStatus();
  }

  Future<void> _syncStatus() async {
    setState(() {
      _isSyncing = true;
      _error = null;
    });
    try {
      final res = await ref
          .read(paymentRepositoryProvider)
          .syncPayment(widget.paymentCode);
      ref.invalidate(bookingDetailProvider(widget.bookingCode));
      ref.invalidate(myBookingsProvider);
      ref.invalidate(myInvoicesProvider);
      if (!mounted) return;
      setState(() => _result = res);
    } on AppException catch (e) {
      if (!mounted) return;
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _isSyncing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPaid = _result?.isPaid ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text('Status Pembayaran')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Center(
          child: TempatinCard(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: _isSyncing
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(color: AppColors.primary),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        'Memverifikasi pembayaran ke server...',
                        style: AppTypography.headingSm,
                      ),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPaid
                            ? LucideIcons.circleCheck
                            : _error != null
                            ? LucideIcons.circleAlert
                            : LucideIcons.clock,
                        size: 48,
                        color: isPaid
                            ? AppColors.successText
                            : _error != null
                            ? AppColors.dangerText
                            : AppColors.warningText,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        isPaid
                            ? 'Pembayaran Terkonfirmasi'
                            : _error != null
                            ? 'Gagal Sinkronisasi'
                            : 'Menunggu Konfirmasi Pembayaran',
                        textAlign: TextAlign.center,
                        style: AppTypography.headingMd,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        _error ??
                            (_result?.message.isNotEmpty == true
                                ? _result!.message
                                : 'Status transaksi: ${_result?.paymentStatus ?? "pending"}'),
                        textAlign: TextAlign.center,
                        style: AppTypography.bodySm,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      TempatinButton(
                        label: 'Perbarui Status',
                        variant: TempatinButtonVariant.secondary,
                        icon: LucideIcons.refreshCw,
                        onPressed: _syncStatus,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TempatinButton(
                        label: 'Kembali ke Detail Booking',
                        onPressed: () => context.pop(),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
