import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/core/image_initial.dart';
import 'package:klinik/helper/video_helper.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoListWidget extends StatelessWidget {
  final double height;
  final List<String> videoUrls;
  final ImageInitial imageCacheInitialName;
  const VideoListWidget({
    Key? key,
    required this.height,
    required this.videoUrls,
    required this.imageCacheInitialName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          _buildList(context),
          Container(
            margin: const EdgeInsets.only(right: 4.0),
            padding: const EdgeInsets.all(4.0),
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
            ),
            width: Core.getDefaultAppWidth(context) / 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "See More",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.0,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      itemCount: videoUrls.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        String videoThumbnail = VideoHelper.getVideoThumbnail(
          videoUrls[index],
        );

        String? videoId = YoutubePlayer.convertUrlToId(videoUrls[index]);

        return GestureDetector(
          onTap: () {
            print("VIDEO ID : $videoId");
            navigateTo("/video_player", arguments: videoId!);
            // }
          },
          child: _imageBuilder(
            context,
            videoThumbnail,
            index,
          ),
        );
      },
    );
  }

  Widget _imageBuilder(
    BuildContext context,
    String videoThumbnail,
    int index,
  ) =>
      CachedNetworkImage(
        imageUrl: videoThumbnail,
        fadeInCurve: Curves.easeIn,
        cacheKey: imageCacheInitialName.name + index.toString(),
        alignment: Alignment.center,
        cacheManager: CacheManager(
          Config(
            imageCacheInitialName.name,
            repo: CacheObjectProvider(
              databaseName: imageCacheInitialName.name,
            ),
            stalePeriod: const Duration(days: 3),
          ),
        ),
        filterQuality: FilterQuality.low,
        imageBuilder: (context, imageProvider) => SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 4.0),
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                    scale: 16 / 9,
                  ),
                ),
                width: Core.getDefaultAppWidth(context) / 3,
              ),
              Container(
                height: Core.getDefaultAppBarHeight(context),
                width: Core.getDefaultAppBarHeight(context),
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(300.0),
                  color: Colors.black54,
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white54,
                  size: Core.getDefaultAppBarHeight(context),
                ),
              ),
            ],
          ),
        ),
        errorWidget: (context, url, error) => Container(
          child: const Text("Error when load image"),
          margin: const EdgeInsets.only(right: 4.0),
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
          ),
          width: Core.getDefaultAppWidth(context) / 3,
        ),
        progressIndicatorBuilder: (context, url, progress) => Container(
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            maxRadius: 40.0,
            child: CircularProgressIndicator(
              backgroundColor: Colors.white30,
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              value: progress.downloaded.toDouble(),
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).primaryColor,
              ),
            ),
          ),
          margin: const EdgeInsets.only(right: 4.0),
          height: height,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
          ),
          width: Core.getDefaultAppWidth(context) / 3,
        ),
        fadeOutCurve: Curves.easeInOut,
        useOldImageOnUrlChange: true,
      );
}
