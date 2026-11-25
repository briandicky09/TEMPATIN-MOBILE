import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Generates clean offline-ready PDF bytes for booking receipts and rental contracts.
abstract final class OfflineDemoPdfBuilder {
  static final NumberFormat _currency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  static Future<Uint8List> buildBookingNotaPdf(
    Map<String, dynamic> booking,
  ) async {
    final doc = pw.Document();
    final kos = booking['kos'] as Map<String, dynamic>? ?? const {};
    final room = booking['room'] as Map<String, dynamic>?;
    final invoice = booking['invoice'] as Map<String, dynamic>?;

    final code = booking['booking_code'] as String? ?? '-';
    final kosTitle = kos['title'] as String? ?? 'Properti Kos TEMPATIN';
    final city = kos['city'] as String? ?? '-';
    final tenantName = booking['tenant_name'] as String? ?? '-';
    final tenantPhone = booking['tenant_phone'] as String? ?? '-';
    final tenantEmail = booking['tenant_email'] as String? ?? '-';
    final startDate = booking['start_date'] as String? ?? '-';
    final endDate = booking['end_date'] as String? ?? '-';
    final duration = (booking['duration_months'] as num?)?.toInt() ?? 1;
    final subtotal = (booking['subtotal'] as num?)?.toDouble() ?? 0;
    final adminFee = (booking['admin_fee'] as num?)?.toDouble() ?? 25000;
    final total = (booking['total_amount'] as num?)?.toDouble() ?? 0;
    final statusLabel =
        booking['status_label'] as String? ??
        (booking['status'] as String? ?? '-').toUpperCase();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _header('NOTA PEMESANAN KAMAR', 'Kode Booking: $code'),
            pw.SizedBox(height: 18),
            _infoBox([
              ['Status Booking', statusLabel],
              ['Properti Kos', '$kosTitle ($city)'],
              ['Nomor Kamar', room?['room_number'] as String? ?? 'Belum ditentukan'],
              ['Nama Penyewa', tenantName],
              ['Kontak / Email', '$tenantPhone | $tenantEmail'],
              ['Periode Sewa', '$startDate s/d $endDate ($duration bulan)'],
              if (invoice != null)
                [
                  'Invoice',
                  '${invoice['invoice_number']} (${(invoice['status'] as String? ?? '-').toUpperCase()})',
                ],
            ]),
            pw.SizedBox(height: 20),
            pw.Text(
              'Rincian Biaya',
              style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),
            _amountRow('Subtotal Sewa ($duration bulan)', _currency.format(subtotal)),
            _amountRow('Biaya Layanan TEMPATIN', _currency.format(adminFee)),
            pw.Divider(color: PdfColors.grey400),
            _amountRow(
              'Total Tagihan',
              _currency.format(total),
              isBold: true,
            ),
            pw.Spacer(),
            _footerNote(),
          ],
        ),
      ),
    );

    return doc.save();
  }

  static Future<Uint8List> buildContractPdf(
    Map<String, dynamic> contract,
    Map<String, dynamic> booking,
  ) async {
    final doc = pw.Document();
    final kos = booking['kos'] as Map<String, dynamic>? ?? const {};
    final room = booking['room'] as Map<String, dynamic>?;

    final contractNumber = contract['contract_number'] as String? ?? '-';
    final bookingCode = booking['booking_code'] as String? ?? '-';
    final kosTitle = kos['title'] as String? ?? 'Properti TEMPATIN';
    final address = kos['address'] as String? ?? (kos['city'] as String? ?? '-');
    final tenantName = booking['tenant_name'] as String? ?? '-';
    final startDate = booking['start_date'] as String? ?? '-';
    final endDate = booking['end_date'] as String? ?? '-';
    final terms = contract['terms'] as String? ?? '';
    final isSigned = contract['is_signed'] as bool? ?? false;
    final signedAt = contract['signed_at'] as String?;

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          _header('PERJANJIAN SEWA KAMAR KOS', 'Nomor: $contractNumber'),
          pw.SizedBox(height: 16),
          _infoBox([
            ['Kode Booking', bookingCode],
            ['Properti', kosTitle],
            ['Alamat', address],
            ['Kamar', room?['room_number'] as String? ?? 'Sesuai penetapan pemilik'],
            ['Pihak Penyewa', tenantName],
            ['Masa Berlaku', '$startDate s/d $endDate'],
            [
              'Status Tanda Tangan',
              isSigned
                  ? 'Sudah ditandatangani secara digital (${signedAt ?? '-'})'
                  : 'Menunggu tanda tangan penyewa',
            ],
          ]),
          pw.SizedBox(height: 18),
          pw.Text(
            'Ketentuan & Tata Tertib Sewa',
            style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(14),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300),
              borderRadius: pw.BorderRadius.circular(6),
            ),
            child: pw.Text(
              terms,
              style: const pw.TextStyle(fontSize: 11, lineSpacing: 4),
            ),
          ),
          pw.SizedBox(height: 24),
          _footerNote(),
        ],
      ),
    );

    return doc.save();
  }

  static pw.Widget _header(String title, String subtitle) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 12),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColor.fromInt(0xFF0075DE), width: 2),
        ),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'TEMPATIN',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: const PdfColor.fromInt(0xFF0075DE),
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.Text(
            subtitle,
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
          ),
        ],
      ),
    );
  }

  static pw.Widget _infoBox(List<List<String>> rows) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: const PdfColor.fromInt(0xFFF6F5F4),
        borderRadius: pw.BorderRadius.circular(6),
        border: pw.Border.all(color: PdfColors.grey300),
      ),
      child: pw.Column(
        children: rows
            .map(
              (r) => pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(
                      width: 145,
                      child: pw.Text(
                        r[0],
                        style: const pw.TextStyle(
                          fontSize: 10,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        r[1],
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  static pw.Widget _amountRow(
    String label,
    String value, {
    bool isBold = false,
  }) {
    final style = pw.TextStyle(
      fontSize: isBold ? 12 : 11,
      fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
    );
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [pw.Text(label, style: style), pw.Text(value, style: style)],
      ),
    );
  }

  static pw.Widget _footerNote() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: const PdfColor.fromInt(0xFFEFF6FF),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Text(
        'Dihasilkan oleh TEMPATIN Mobile (Mode Demo Offline - Dokumen Simulasi Lokal). '
        'Tidak terhubung ke gateway pembayaran atau server produksi.',
        style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
      ),
    );
  }
}
