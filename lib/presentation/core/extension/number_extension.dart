import 'package:intl/intl.dart';

extension NumberExtension on String {
  int toIntFromFormatted() {
    return int.tryParse(replaceAll('.', '')) ?? 0;
  }
}

extension CurrencyExtension on int {
  String toCurrencyFormat() {
    return NumberFormat.decimalPattern('id_ID').format(this);
  }
}
