import 'package:intl/intl.dart';

extension DateFormatter on String {
  ///Untuk menampilkan tanggal berformat `'d MMMM y'`
  ///dengan local formatter `'id_ID'`.
  ///
  ///For example :
  ///```dart
  ///final datetime = DateTime(1999, 1, 20, 19, 45);
  ///final value = datetime.toString().todMMMMy();
  ///
  ///print(value); // 20 Januari 1999
  ///```
  String todMMMMy() {
    final DateTime dateTime = DateTime.parse(this);
    final DateFormat formatter = DateFormat('d MMMM y', "id_ID");

    return formatter.format(dateTime);
  }

  ///Untuk menampilkan tanggal berformat `'EEEE, d MMMM y'`,
  ///dengan local formatter `'id_ID'`.
  ///
  ///For example :
  ///```dart
  ///final datetime = DateTime(1999, 1, 20, 19, 45);
  ///final value = datetime.toString().todMMMMy();
  ///
  ///print(value); // Rabu, 20 Januari 1999
  ///```
  String towdMMMMy() {
    final DateTime dateTime = DateTime.parse(this);
    final DateFormat formatter = DateFormat('EEEE, d MMMM y', "id_ID");

    return formatter.format(dateTime);
  }
}
