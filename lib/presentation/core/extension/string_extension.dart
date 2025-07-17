import 'package:intl/intl.dart';

extension StringExtension on String {
  String toCurrencyFormat({String locale = 'id'}) {
    final number = int.tryParse(this) ?? 0;
    return NumberFormat.decimalPattern(locale).format(number);
  }
}