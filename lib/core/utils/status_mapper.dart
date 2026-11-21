import '../widgets/status_badge.dart';

/// Centralized semantic label & color tone mapping for TEMPATIN domain statuses.
abstract final class StatusMapper {
  static (String label, StatusTone tone) booking(String status) {
    return switch (status.toLowerCase()) {
      'pending' => ('Menunggu Persetujuan', StatusTone.warning),
      'approved' => ('Disetujui • Siap Bayar', StatusTone.info),
      'confirmed' => ('Dikonfirmasi (Lunas)', StatusTone.success),
      'active' => ('Aktif Dihuni', StatusTone.success),
      'completed' => ('Selesai', StatusTone.neutral),
      'rejected' => ('Ditolak', StatusTone.danger),
      'cancelled' => ('Dibatalkan', StatusTone.danger),
      _ => (status, StatusTone.neutral),
    };
  }

  static (String label, StatusTone tone) invoice(String status) {
    return switch (status.toLowerCase()) {
      'paid' => ('Lunas', StatusTone.success),
      'unpaid' => ('Belum Dibayar', StatusTone.warning),
      'expired' => ('Kedaluwarsa', StatusTone.danger),
      'cancelled' => ('Dibatalkan', StatusTone.danger),
      _ => (status, StatusTone.neutral),
    };
  }

  static (String label, StatusTone tone) survey(String status) {
    return switch (status.toLowerCase()) {
      'pending' => ('Menunggu Konfirmasi', StatusTone.warning),
      'approved' => ('Disetujui', StatusTone.info),
      'completed' => ('Selesai', StatusTone.success),
      'rejected' => ('Ditolak', StatusTone.danger),
      'cancelled' => ('Dibatalkan', StatusTone.danger),
      _ => (status, StatusTone.neutral),
    };
  }

  static (String label, StatusTone tone) maintenance(String status) {
    return switch (status.toLowerCase()) {
      'open' => ('Menunggu Penanganan', StatusTone.warning),
      'in_progress' => ('Sedang Diproses', StatusTone.info),
      'resolved' => ('Selesai Diperbaiki', StatusTone.success),
      'rejected' => ('Ditolak', StatusTone.danger),
      _ => (status, StatusTone.neutral),
    };
  }

  static (String label, StatusTone tone) room(String status) {
    return switch (status.toLowerCase()) {
      'available' => ('Tersedia', StatusTone.success),
      'occupied' => ('Terisi', StatusTone.danger),
      'maintenance' => ('Perbaikan', StatusTone.warning),
      _ => (status, StatusTone.neutral),
    };
  }
}
