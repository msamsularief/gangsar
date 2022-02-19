import 'package:equatable/equatable.dart';

class AccessToken extends Equatable {
  // final int accountId;
  final String token;

  AccessToken(
    // this.accountId,
    this.token,
  );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};

    // data["account_id"] = this.accountId;
    data["token"] = token;
    return data;
  }

  static AccessToken fromMap(Map<String, dynamic> data) {
    return AccessToken(
      // data["account_id"] as int,
      data["token"] as String,
    );
  }

  AccessToken copy({
    // int? accountId,
    String? token,
  }) {
    return AccessToken(
      // // accountId ?? this.accountId,
      token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [
        // accountId,
        token,
      ];
}
