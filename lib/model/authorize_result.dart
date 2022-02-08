import 'package:klinik/model/account.dart';

class AuthorizeResult {
  late final Account? account;
  late final String? message;

  AuthorizeResult({this.account, this.message});
}
