import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object?> get props => [];
}

class GetVideoDetail extends VideoEvent {
  final String videoUrl;

  GetVideoDetail(this.videoUrl);
  @override
  String toString() => 'GetVideoDetail';
}
