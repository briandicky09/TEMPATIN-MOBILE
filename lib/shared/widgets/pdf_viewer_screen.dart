import 'dart:io';
import 'dart:typed_data';

import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/theme/app_colors.dart';
import '../../core/widgets/app_empty_state.dart';

/// Authenticated PDF viewer & share screen for Nota Pembayaran and Kontrak Sewa.
class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({
    super.key,
    required this.title,
    required this.fileName,
    required this.loadBytes,
  });

  final String title;
  final String fileName;
  final Future<Uint8List> Function() loadBytes;

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late Future<Uint8List> _pdfFuture;
  Uint8List? _loadedBytes;

  @override
  void initState() {
    super.initState();
    _pdfFuture = _fetch();
  }

  Future<Uint8List> _fetch() async {
    final bytes = await widget.loadBytes();
    _loadedBytes = bytes;
    return bytes;
  }

  Future<void> _sharePdf() async {
    final bytes = _loadedBytes;
    if (bytes == null || bytes.isEmpty) return;

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/${widget.fileName}');
    await file.writeAsBytes(bytes, flush: true);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'application/pdf')],
        subject: widget.title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            tooltip: 'Bagikan / Simpan PDF',
            onPressed: _loadedBytes == null ? null : _sharePdf,
            icon: const Icon(LucideIcons.share2, size: 20),
          ),
        ],
      ),
      body: FutureBuilder<Uint8List>(
        future: _pdfFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (snapshot.hasError) {
            return AppErrorState(
              message: snapshot.error.toString(),
              onRetry: () => setState(() => _pdfFuture = _fetch()),
            );
          }

          final bytes = snapshot.data;
          if (bytes == null || bytes.isEmpty) {
            return AppEmptyState(
              icon: LucideIcons.fileX,
              title: 'Dokumen Kosong',
              description: 'Dokumen PDF belum tersedia untuk ditampilkan.',
              actionLabel: 'Muat Ulang',
              onAction: () => setState(() => _pdfFuture = _fetch()),
            );
          }

          return PdfPreview(
            build: (_) async => bytes,
            pdfFileName: widget.fileName,
            canChangePageFormat: false,
            canChangeOrientation: false,
            canDebug: false,
            allowSharing: true,
            allowPrinting: true,
          );
        },
      ),
    );
  }
}
