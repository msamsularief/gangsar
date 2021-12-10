import 'package:intl/intl.dart';

extension DateFormatter on String {
  String todMMMMy() {
    final DateTime dateTime = DateTime.parse(this);
    final DateFormat formatter = DateFormat('d MMMM y', "id_ID");

    return formatter.format(dateTime);
  }
}
