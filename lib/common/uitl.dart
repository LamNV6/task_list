import 'package:intl/intl.dart';

extension DateTimeCompare on DateTime {
  String toyyyyMMdd() => DateFormat('yyyy-MM-dd').format(this);
}
