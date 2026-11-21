import 'package:intl/intl.dart';

/// Formats Indonesian Rupiah amounts consistently (e.g. `Rp 850.000`).
abstract final class CurrencyFormatter {
  static final NumberFormat _idrFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  static String formatIdr(num amount) => _idrFormat.format(amount);

  static String formatMonthly(num amount) => '${formatIdr(amount)} / bln';
}
