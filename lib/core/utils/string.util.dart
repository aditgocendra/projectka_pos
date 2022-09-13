import 'package:intl/intl.dart';

class StringUtil {
  static String rupiahFormat(int num) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(num);
  }

  static String dMMMyFormat(DateTime dateTime) {
    return DateFormat('d MMM y', 'id').format(
      dateTime,
    );
  }
}
