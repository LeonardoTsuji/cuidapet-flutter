import 'package:intl/intl.dart';

class Formatter {
  static NumberFormat currency() {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  }

  static DateFormat date(String pattern) {
    return DateFormat(pattern);
  }
}
