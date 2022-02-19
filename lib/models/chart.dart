import 'package:equatable/equatable.dart';

class Chart extends Equatable {
  final String userId;
  final String massIndex;
  final String createdAt;
  final String week;

  Chart(
    this.userId,
    this.massIndex,
    this.createdAt,
    this.week,
  );

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data["user_id"] = userId;
    data["body_mass_index"] = massIndex;
    data["dt"] = createdAt;
    data["week"] = week;
    return data;
  }

  static Chart fromMap(Map<String, dynamic> data) {
    return Chart(
      data["user_id"] as String,
      data["body_mass_index"] as String,
      data["dt"] as String,
      data["week"] as String,
    );
  }

  Chart copy({
    String? massIndex,
    String? createdAt,
    String? userId,
    String? week,
  }) {
    return Chart(
      massIndex ?? this.massIndex,
      createdAt ?? this.createdAt,
      userId ?? this.userId,
      week ?? this.week,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        massIndex,
        createdAt,
        week,
      ];
}
