import 'package:equatable/equatable.dart';

class History extends Equatable {
  final String id;
  final String timestamp;
  final String description;
  final bool isChecked;

  History(
    this.id,
    this.timestamp,
    this.description,
    this.isChecked,
  );

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["ts"] = timestamp;
    data["description"] = description;
    data["is_checked"] = isChecked;
    return data;
  }

  static History fromMap(Map<String, dynamic> data) {
    return History(
      data["id"] as String,
      data["ts"] as String,
      data["description"] as String,
      data["is_checked"] as bool,
    );
  }

  History copy({
    String? id,
    String? timestamp,
    String? description,
    bool? isChecked,
  }) {
    return History(
      id ?? this.id,
      timestamp ?? this.timestamp,
      description ?? this.description,
      isChecked ?? this.isChecked,
    );
  }

  @override
  List<Object?> get props => [
        id,
        timestamp,
        description,
        isChecked,
      ];
}
