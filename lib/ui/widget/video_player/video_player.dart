import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klinik/models/video.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String videoId;
  final Video videoData;
  VideoPlayer({Key? key, required this.videoId, required this.videoData})
      : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer>
    with TickerProviderStateMixin {
  late YoutubePlayerController _controller;

  void initVideo() {
    String? videoId = widget.videoId;

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        enableCaption: true,
        loop: true,
        startAt: 0,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initVideo();
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProgressBarColors _progressBarColors = ProgressBarColors(
      backgroundColor: Colors.white38,
      bufferedColor: Colors.white60,
      handleColor: Theme.of(context).primaryColor,
      playedColor: Theme.of(context).primaryColor,
    );

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        aspectRatio: MediaQuery.of(context).devicePixelRatio,
        bottomActions: [
          CurrentPosition(
            controller: _controller,
          ),
          ProgressBar(
            controller: _controller,
            isExpanded: true,
            colors: _progressBarColors,
          ),
          RemainingDuration(
            controller: _controller,
          ),
          FullScreenButton(
            controller: _controller,
            color: Colors.white,
          ),
        ],
      ),
      builder: (context, child) => BuildBodyWidget(
        appBar: KlinikAppBar(
          title: "Video Player",
        ),
        body: Column(
          children: [
            child,
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _text(
                    widget.videoData.title,
                    fontSize: 32.0,
                    fontWeight: FontWeight.w600,
                  ),
                  Divider(
                    height: 32.0,
                    thickness: 1.6,
                  ),
                  _text(
                    "Author :  " + widget.videoData.author,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _text(
    String? text, {
    double? fontSize,
    FontWeight? fontWeight,
  }) =>
      Text(
        "$text",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: fontSize ?? 18.0,
          color: Theme.of(context).textTheme.bodyText1!.color,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      );

  Widget get _sizedBox => const SizedBox(
        height: 20.0,
      );
}
