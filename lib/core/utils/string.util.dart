import 'package:intl/intl.dart';

class StringUtil {
  static String rupiahFormat(int num) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(num);
  }
}
