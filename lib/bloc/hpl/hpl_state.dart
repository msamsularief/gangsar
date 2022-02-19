import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HplState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HplInitial extends HplState {
  @override
  String toString() => "Hpl Initial";
}

class HplLoading extends HplState {
  @override
  String toString() => "Hpl Loading";
}

class HplLoaded extends HplState {
  final String dateTime;

  HplLoaded(this.dateTime);
  @override
  String toString() => "Hpl Loaded : $dateTime";
}

class HplEdited extends HplState {
  final String dateTime;

  HplEdited(this.dateTime);
  @override
  String toString() => "Hpl Loaded : $dateTime";
}

class HplSuccess extends HplState {
  final String? dateTime;

  HplSuccess(this.dateTime);

  @override
  String toString() => "Hpl Success : dateTime $dateTime";
}

class HplFailure extends HplState {
  final String error;

  HplFailure({required this.error});

  @override
  String toString() => "Hpl Failure : Error $error";
}
