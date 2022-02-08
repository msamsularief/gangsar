import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:klinik/model/account.dart';

@immutable
abstract class AccountState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Loading state
class AccountLoading extends AccountState {
  /// Set true to block screen with blocking loading modal box.
  final bool block;
  AccountLoading({this.block = false});
  @override
  String toString() => "AccountLoading";
}

class AccountListLoading extends AccountState {
  @override
  String toString() => "AccountListLoading";
}

class AccountListLoaded extends AccountState {
  final List<Account> items;
  AccountListLoaded(this.items);
  @override
  String toString() => "AccountListLoaded";
}

class AccountListUpdated extends AccountState {
  final List<Account> items;

  AccountListUpdated(this.items);
  @override
  String toString() => "AccountListUpdated";
}

/// State when error/failure occurred
class AccountFailure extends AccountState {
  final String? error;
  AccountFailure({this.error});
  @override
  String toString() => "AccountFailure";
}

class AccountCreated extends AccountState {
  final String token;
  AccountCreated(this.token);
  @override
  String toString() => "AccountCreated";
}

class PasswordCreated extends AccountState {
  final Account account;

  PasswordCreated(this.account);
  @override
  String toString() => "PasswordCreated";
}

/// State when Account already deleted
class AccountDeleted extends AccountState {
  final Account account;
  AccountDeleted(this.account);
  @override
  String toString() => "AccountDeleted";
}

class AccountBlocked extends AccountState {
  final Account account;
  AccountBlocked(this.account);
  @override
  String toString() => "AccountBlocked";
}

class AccountUnblocked extends AccountState {
  final Account account;
  AccountUnblocked(this.account);
  @override
  String toString() => "AccountUnblocked";
}

class RoleUpdated extends AccountState {
  final List<String> roles;

  RoleUpdated(this.roles);

  @override
  String toString() => "RoleUpdated";
}

class AccountUpdated extends AccountState {
  final Account account;

  AccountUpdated(this.account);

  @override
  String toString() => "AccountUpdated";
}

class AccountDetailLoaded extends AccountState {
  final Account account;

  AccountDetailLoaded(this.account);

  @override
  String toString() => "AccountDetailLoaded";
}
