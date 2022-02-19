import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HplEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HplButtonPressed extends HplEvent {
  final String key;
  final String dateTime;

  HplButtonPressed({required this.key, required this.dateTime});

  @override
  String toString() => "Hpl Button Pressed { key: $key, dateTime: $dateTime }";
}

class GetHplData extends HplEvent {
  final String key;

  GetHplData(this.key);
  @override
  String toString() => "Get Hpl Data";
}

class EditHplData extends HplEvent {
  final String key;
  final String dateTime;

  EditHplData(this.key, this.dateTime);
  @override
  String toString() => "Get Hpl Data";
}
