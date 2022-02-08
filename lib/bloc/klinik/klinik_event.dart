import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class KlinikEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartupEvent extends KlinikEvent {
  StartupEvent();
}

class LoggedIn extends KlinikEvent {
  // final String message;

  // LoggedIn({required this.message});

  @override
  String toString() => 'LoggedIn';
}

class LoggedOut extends KlinikEvent {
  @override
  String toString() => 'LoggedOut';
}
