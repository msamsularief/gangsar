import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String userId;
  final String fullName;
  final String email;

  Account(
    this.userId,
    this.fullName,
    this.email,
  );

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data["user_id"] = userId;
    data["full_name"] = fullName;
    data["email"] = email;
    return data;
  }

  static Account fromMap(Map<String, dynamic> data) {
    return Account(
      data["user_id"] as String,
      data["full_name"] as String,
      data["email"] as String,
    );
  }

  Account copy({
    String? userId,
    String? fullName,
    String? email,
  }) {
    return Account(
      userId ?? this.userId,
      fullName ?? this.fullName,
      email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        fullName,
        email,
      ];
}
