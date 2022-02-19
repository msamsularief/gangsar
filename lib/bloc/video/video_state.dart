import 'package:equatable/equatable.dart';
import 'package:klinik/models/video.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object?> get props => [];
}

class VideoLoading extends VideoState {
  @override
  String toString() => 'VideoLoading';
}

class VideoLoaded extends VideoState {
  final Video item;

  VideoLoaded(this.item);
  @override
  String toString() => "VideoLoaded : { Video Meta Data : $item }";
}
