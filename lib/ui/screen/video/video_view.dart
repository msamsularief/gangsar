import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klinik/bloc/video/video.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/core/image_initial.dart';
import 'package:klinik/helper/video_helper.dart';
import 'package:klinik/model/video.dart';
import 'package:klinik/model/image_component.dart';
import 'package:klinik/ui/screen/video/video_item_view.dart';
import 'package:klinik/ui/widget/video_player/video_items.dart';

class VideoView extends StatelessWidget {
  ///Digunakan untuk menginiasi tampilan apakah menampilkan dari
  ///[Home Tab -> Videos] atau melalui tomblol [See More] dari urutan ***list video***.
  ///
  ///Jika dari **[See More]** maka set nilainya ke `false`, namun jika dari
  ///**[Home Tab -> Videos]** maka nilainya harus berupa `true`.
  final bool isFromTabMenu;
  VideoView({Key? key, required this.isFromTabMenu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20.0,
        20.0,
        20.0,
        // isFromTabMenu ? Core.getDefaultAppBarHeight(context) * 1.8 : 20.0,
        20.0,
      ),
      color: Colors.white.withOpacity(0.82),
      child: Column(
        children: videoUrls.map((e) {
          return BlocProvider(
            create: (context) => VideoBloc()..add(GetVideoDetail(e)),
            child: _videoViewBuilder(context, e),
          );
        }).toList(),
      ),
    );
  }

  Widget _videoViewBuilder(BuildContext context, String videoUrl) {
    String videoThumbnail = VideoHelper.getVideoThumbnail(
      videoUrl,
    );

    String? videoId = VideoHelper.getVideoId(videoUrl);

    Video? metaData;

    final _loading = Container(
      height: Core.getDefaultBodyHeight(context) / 3,
      width: Core.getDefaultAppWidth(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: EdgeInsets.only(bottom: 20.0),
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white30,
          color: Theme.of(context).primaryColor.withOpacity(0.4),
          valueColor: AlwaysStoppedAnimation(
            Theme.of(context).primaryColor,
          ),
        ),
      ),
    );

    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        if (state is VideoLoading) {
          return _loading;
        } else if (state is VideoLoaded) {
          metaData = state.item;
        }

        if (metaData != null) {
          var imageComponent = ImageComponent(
            videoThumbnail,
            videoUrls.indexOf(videoUrl),
            ImageInitial.videoThumbnail,
          );

          return GestureDetector(
            onTap: () {
              navigateTo(
                '/video_player',
                arguments: [videoId, Video(metaData!.title, metaData!.author)],
              );
            },
            child: VideoItemView(
              imageComponent: imageComponent,
              author: metaData!.author,
              title: metaData!.title,
            ),
          );
        } else {
          return Container(
            height: Core.getDefaultBodyHeight(context) / 3,
            width: Core.getDefaultAppWidth(context),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
          );
        }
      },
    );
  }
}
