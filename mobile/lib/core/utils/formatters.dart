import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';

abstract final class CurrencyFormatter {
  static final _idr = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  static String idr(num amount) => _idr.format(amount);

  static String monthly(num amount) => '${_idr.format(amount)} / bln';
}

abstract final class DateFormatter {
  static String shortDate(DateTime dt) =>
      DateFormat('dd MMM yyyy', 'id_ID').format(dt);

  static String dateTime(DateTime dt) =>
      DateFormat('dd MMM yyyy, HH:mm', 'id_ID').format(dt);

  static String apiDate(DateTime dt) => DateFormat('yyyy-MM-dd').format(dt);

  static String formatStringDate(String raw) {
    final parsed = DateTime.tryParse(raw);
    return parsed != null ? shortDate(parsed) : raw;
  }
}

abstract final class AppValidators {
  static String? requiredField(String? value, {String label = 'Kolom ini'}) {
    if (value == null || value.trim().isEmpty) {
      return '$label wajib diisi.';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email wajib diisi.';
    }
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(value.trim())) {
      return 'Format email tidak valid.';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.length < 6) {
      return 'Password minimal 6 karakter.';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().length < 9) {
      return 'Nomor telepon minimal 9 digit.';
    }
    return null;
  }
}

enum StatusTone { success, warning, danger, info, neutral }

abstract final class StatusHelper {
  static (String label, StatusTone tone) booking(String status) {
    return switch (status) {
      'pending' => ('Menunggu Persetujuan', StatusTone.warning),
      'approved' => ('Disetujui • Siap Bayar', StatusTone.info),
      'confirmed' => ('Lunas • Terkonfirmasi', StatusTone.success),
      'active' => ('Aktif Dihuni', StatusTone.success),
      'completed' => ('Selesai', StatusTone.neutral),
      'rejected' => ('Ditolak', StatusTone.danger),
      'cancelled' => ('Dibatalkan', StatusTone.neutral),
      _ => (status, StatusTone.neutral),
    };
  }

  static (String label, StatusTone tone) invoice(String status) {
    return switch (status) {
      'paid' => ('Lunas', StatusTone.success),
      'unpaid' => ('Belum Dibayar', StatusTone.warning),
      'cancelled' => ('Dibatalkan', StatusTone.danger),
      _ => (status, StatusTone.neutral),
    };
  }

  static (Color bg, Color fg) colorsFor(StatusTone tone) {
    return switch (tone) {
      StatusTone.success => (AppColors.successBg, AppColors.successText),
      StatusTone.warning => (AppColors.warningBg, AppColors.warningText),
      StatusTone.danger => (AppColors.dangerBg, AppColors.dangerText),
      StatusTone.info => (AppColors.infoBg, AppColors.infoText),
      StatusTone.neutral => (AppColors.neutralBg, AppColors.neutralText),
    };
  }
}
