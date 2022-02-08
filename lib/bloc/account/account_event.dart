import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:klinik/model/account.dart';

@immutable
abstract class AccountEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAccount extends AccountEvent {
  final bool force;
  final String query;
  final String role;

  LoadAccount({this.force = false, this.query = "", this.role = ""});

  @override
  String toString() => "LoadAccount";
}

class LoadDetailAccount extends AccountEvent {
  final int? accountId;
  final String? nickname;

  LoadDetailAccount({this.accountId, this.nickname});

  @override
  String toString() => "LoadDetailAccount";
}

class CreateAccount extends AccountEvent {
  final String userName;
  final String email;
  final String password;
  final String phoneNum;

  CreateAccount(
    this.userName,
    this.email,
    this.password,
    this.phoneNum,
  );

  @override
  String toString() => "CreateAccount";
}

class CreatePassword extends AccountEvent {
  final String token;
  final String password;

  CreatePassword(this.token, this.password);

  @override
  String toString() => "CreatePassword";
}

/// Event to delete Account
class DeleteAccount extends AccountEvent {
  final Account account;
  DeleteAccount(this.account);

  @override
  String toString() => "DeleteAccount";
}

/// Event to update Account Role
class UpdateRole extends AccountEvent {
  final Account account;
  final List<String> roles;

  UpdateRole(this.account, this.roles);

  @override
  String toString() => "UpdateRole";
}

class UpdateAccount extends AccountEvent {
  final int id;
  final String fullName;
  final String email;
  final String nickName;
  final String phoneNum;

  UpdateAccount(
      this.id, this.fullName, this.email, this.nickName, this.phoneNum);

  @override
  String toString() => "UpdateAccount";
}

class BlockAccount extends AccountEvent {
  final Account account;

  BlockAccount(this.account);
  @override
  String toString() => "BlockAccount";
}

class UnblockAccount extends AccountEvent {
  final Account account;

  UnblockAccount(this.account);
  @override
  String toString() => "UnblockAccount";
}
