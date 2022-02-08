import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {
  @override
  String toString() => "Register Initial";
}

class RegisterLoading extends RegisterState {
  @override
  String toString() => "Register Loading";
}

class RegisterSuccess extends RegisterState {
  final String? message;

  RegisterSuccess({required this.message});

  @override
  String toString() => "Register Success : Message $message";
}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure({required this.error});

  @override
  String toString() => "Register Failure";
}
