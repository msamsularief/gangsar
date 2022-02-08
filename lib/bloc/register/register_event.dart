import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final String email;
  final String password;
  final String fullName;
  final String phoneNum;

  RegisterButtonPressed({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNum,
  });

  @override
  String toString() =>
      "Register Button Pressed { email: $email, password: $password, full_name: $fullName}";
}
