import 'package:equatable/equatable.dart';
import 'package:klinik/model/account.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  @override
  String toString() => "Login Initial";
}

class LoginLoading extends LoginState {
  @override
  String toString() => "Login Loading";
}

class LoginSuccess extends LoginState {
  final Account? account;

  LoginSuccess(this.account);

  @override
  String toString() => "Login Success : Account $account";
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});

  @override
  String toString() => "Login Failure";
}
