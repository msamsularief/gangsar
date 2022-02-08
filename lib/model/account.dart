import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String fullName;
  final String email;

  Account(
    this.fullName,
    this.email,
  );

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};

    data["full_name"] = fullName;
    data["email"] = email;
    return data;
  }

  static Account fromMap(Map<String, dynamic> data) {
    return Account(
      data["full_name"] as String,
      data["email"] as String,
    );
  }

  Account copy({
    String? fullName,
    String? email,
  }) {
    return Account(
      fullName ?? this.fullName,
      email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        email,
      ];
}
