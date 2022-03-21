import 'package:equatable/equatable.dart';

//model untuk `checkbox` menu **[HPHT]**
class HphtChecker extends Equatable {
  final String id;
  final String title;
  final bool isChecked;

  HphtChecker(
    this.id,
    this.title,
    this.isChecked,
  );

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["is_checked"] = isChecked;
    return data;
  }

  static HphtChecker fromMap(Map<String, dynamic> data) {
    return HphtChecker(
      data["id"] as String,
      data["title"] as String,
      data["is_checked"] as bool,
    );
  }

  HphtChecker copy({
    String? id,
    String? title,
    String? description,
    bool? isChecked,
  }) {
    return HphtChecker(
      id ?? this.id,
      title ?? this.title,
      isChecked ?? this.isChecked,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        isChecked,
      ];
}
