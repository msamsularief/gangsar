import 'package:equatable/equatable.dart';
import 'package:klinik/models/access_token.dart';
import 'package:meta/meta.dart';

@immutable
abstract class KlinikState extends Equatable {
  @override
  List<Object?> get props => [];
}

class KlinikLoading extends KlinikState {
  @override
  String toString() => "Klinik Loading";
}

class AuthenticationUninisialized extends KlinikState {
  @override
  String toString() => "Authentication Uninisialized";
}

class AuthenticationAuthenticated extends KlinikState {
  @override
  String toString() => "Authentication Authenticated";
}

class AuthenticationUnauthenticated extends KlinikState {
  // final String? message;

  // AuthenticationUnauthenticated({this.message});
  @override
  String toString() => 'Authentication Unauthenticated';
}

class AuthenticationLoading extends KlinikState {
  @override
  String toString() => 'Authentication Loading';
}

// class LoginFailed extends KlinikState {
//   @override
//   String toString() => "LoginFailed";
// }

// class LoginSuccess extends KlinikState {
//   final AccessToken accessToken;

//   LoginSuccess(this.accessToken);

//   @override
//   String toString() => "LoginSuccess { accessToken: $accessToken }";
// }
