import 'package:bloc/bloc.dart';
import 'package:klinik/bloc/video/video.dart';
import 'package:klinik/helper/video_helper.dart';
import 'package:klinik/models/video.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoState get initialState => VideoLoading();
  VideoBloc() : super(VideoLoading()) {
    on<VideoEvent>((event, emit) => emit(initialState));
    on<GetVideoDetail>((event, emit) async {
      emit(initialState);
      final Map<String, dynamic> result =
          await VideoHelper.getVideoDetail(event.videoUrl);

      // print("\nRESULT : $result\n");

      if (result.toString().isNotEmpty) {
        final data = Video.fromMap(result);

        print("\nDATA : $data\n");
        if (data.props.isNotEmpty) {
          emit(VideoLoaded(data));
        } else {
          emit(VideoLoading());
          emit(VideoLoaded(Video("", "")));
        }
      }
    });
  }
}
