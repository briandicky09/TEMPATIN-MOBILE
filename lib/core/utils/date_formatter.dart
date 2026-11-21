import 'package:intl/intl.dart';

/// Indonesian date formatting helpers (`id_ID`).
abstract final class DateFormatter {
  static String shortDate(DateTime date) =>
      DateFormat('dd MMM yyyy', 'id_ID').format(date);

  static String dateTime(DateTime date) =>
      DateFormat('dd MMM yyyy, HH:mm', 'id_ID').format(date);

  static String apiDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
}
