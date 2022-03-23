import 'package:intl/intl.dart';
import 'package:klinik/core/locale_formater.dart';

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
    final DateFormat formatter = DateFormat(
      'd MMMM y',
      LocalFormatter.indonesian,
    );

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
    final DateFormat formatter = DateFormat(
      'EEEE, d MMMM y',
      LocalFormatter.indonesian,
    );

    return formatter.format(dateTime);
  }

  ///Untuk menampilkan nama bulan dalam format Indonesia
  ///```dart
  ///('id_ID')
  ///```
  String toMMMM() {
    final DateTime dateTime = DateTime.parse(this);
    final DateFormat formatter = DateFormat.MMMM(
      LocalFormatter.indonesian,
    );

    return formatter.format(dateTime);
  }

  ///Untuk menampilkan tanggal saja
  String toD() {
    final DateTime dateTime = DateTime.parse(this);
    final DateFormat formatter = DateFormat.d(
      LocalFormatter.indonesian,
    );

    return formatter.format(dateTime);
  }
}
