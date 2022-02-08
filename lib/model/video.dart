import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final String title;
  final String author;

  Video(
    this.title,
    this.author,
  );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};

    data["title"] = title;
    data["author_name"] = author;
    return data;
  }

  static Video fromMap(Map<String, dynamic> data) {
    return Video(
      data["title"] as String,
      data["author_name"] as String,
    );
  }

  Video copy({
    String? title,
    String? author,
  }) {
    return Video(
      title ?? this.title,
      author ?? this.author,
    );
  }

  @override
  List<Object?> get props => [
        title,
        author,
      ];
}
