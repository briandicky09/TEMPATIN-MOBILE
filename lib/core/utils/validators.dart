/// Client-side form validators mirroring Laravel FormRequest rules.
abstract final class AppValidators {
  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static final RegExp _phoneRegex = RegExp(r'^([0-9\s\-\+\(\)]*)$');

  static String? requiredField(String? value, {String label = 'Field ini'}) {
    if (value == null || value.trim().isEmpty) {
      return '$label wajib diisi.';
    }
    return null;
  }

  static String? email(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Email wajib diisi.';
    if (!_emailRegex.hasMatch(trimmed)) return 'Format email tidak valid.';
    return null;
  }

  static String? password(String? value, {int minLength = 8}) {
    final text = value ?? '';
    if (text.isEmpty) return 'Kata sandi wajib diisi.';
    if (text.length < minLength) {
      return 'Kata sandi minimal $minLength karakter.';
    }
    return null;
  }

  static String? phone(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Nomor handphone wajib diisi.';
    if (trimmed.length < 9 ||
        trimmed.length > 30 ||
        !_phoneRegex.hasMatch(trimmed)) {
      return 'Format nomor handphone tidak valid.';
    }
    return null;
  }
}
