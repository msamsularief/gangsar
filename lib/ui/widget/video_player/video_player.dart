import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klinik/model/video.dart';
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
  late PlayerState _playerState = PlayerState.unknown;
  late YoutubeMetaData _videoMetaData = YoutubeMetaData();

  // late AnimationController _animController;

  bool _isFullScreen = false;
  bool _isPlayerReady = false;

  void listener() {
    _isPlayerReady = true;
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }

    print("\n\n\nPLAYER STATUS : ${_controller.value.playerState} \n\n\n");
  }

  void onEnterFullScreen() {
    setState(() {
      _isFullScreen = true;
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

      if (_controller.value.isFullScreen) {
        setState(() {
          _controller.flags.copyWith(
            startAt: _controller.value.position.inSeconds,
            autoPlay: true,
          );
        });
      } else if (!_controller.value.isFullScreen) {
        setState(() {
          _controller.flags.copyWith(
            startAt: _controller.value.position.inSeconds,
            autoPlay: true,
          );
        });
      }
    });
  }

  void onExitFullScreen() {
    setState(() {
      _isFullScreen = false;
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);

      if (_controller.value.isFullScreen) {
        setState(() {
          _controller.flags.copyWith(
            startAt: _controller.value.position.inSeconds,
            autoPlay: true,
          );
        });
      } else if (!_controller.value.isFullScreen) {
        setState(() {
          _controller.flags.copyWith(
            startAt: _controller.value.position.inSeconds,
            autoPlay: true,
          );
        });
      }
    });
  }

  void initVideo() {
    String? videoId = widget.videoId;

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        enableCaption: false,
        loop: false,
        startAt: 0,
      ),
    )..addListener(listener);
  }

  @override
  void initState() {
    initVideo();
    super.initState();

    // _animController = AnimationController(
    //   vsync: this,
    //   value: 0,
    //   duration: const Duration(milliseconds: 300),
    // );
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
    // _animController.dispose();
    super.dispose();
  }

  // Future<bool> _onWillPop() async {
  //   _controller.play();
  //   return _isFullScreen;
  // }

  @override
  Widget build(BuildContext context) {
    ProgressBarColors _progressBarColors = ProgressBarColors(
      backgroundColor: Colors.white38,
      bufferedColor: Colors.white60,
      handleColor: Theme.of(context).primaryColor,
      playedColor: Theme.of(context).primaryColor,
    );

    return _isFullScreen
        ? player(_progressBarColors)
        : _buildView(context, player(_progressBarColors));

    // return WillPopScope(
    //   child: OrientationBuilder(builder: (context, orientation) {
    //     switch (orientation) {
    //       case Orientation.landscape:
    //         return Scaffold(
    //           body: player(_progressBarColors),
    //         );
    //       case Orientation.portrait:
    //         return _buildView(
    //           context,
    //           player(_progressBarColors),
    //           _isFullScreen,
    //         );
    //       default:
    //         return Container();
    //     }
    //   }),
    //   onWillPop: _onWillPop,
    // );
  }

  Widget _buildView(
    BuildContext context,
    Widget player,
  ) {
    return BuildBodyWidget(
      appBar: KlinikAppBar(
        title: "Playing Video",
      ),
      body: player,
    );
  }

  Widget player(ProgressBarColors _progressBarColors) {
    YoutubePlayerBuilder player = YoutubePlayerBuilder(
      onEnterFullScreen: onEnterFullScreen,
      onExitFullScreen: onExitFullScreen,
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        progressColors: _progressBarColors,
        topActions: [],
        bottomActions: [
          CurrentPosition(),
          ProgressBar(
            isExpanded: true,
            colors: _progressBarColors,
          ),
          RemainingDuration(),
          FullScreenButton(
            controller: _controller,
          ),
        ],
        onReady: () {
          setState(() {
            if (_playerState == PlayerState.cued) {
              _isPlayerReady = true;
              _controller.play();
            } else if (_playerState == PlayerState.paused) {
              _controller.play();
            }

            SystemChrome.setEnabledSystemUIMode(
              SystemUiMode.immersiveSticky,
              overlays: [SystemUiOverlay.bottom],
            );
          });
        },
        onEnded: (data) {},
      ),
      builder: (context, child) => _isFullScreen
          ? SizedBox(child: child)
          : SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  child,
                  _isPlayerReady
                      ? Container(
                          padding: const EdgeInsets.all(24.0),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _text(
                                widget.videoData.title,
                                fontSize: 32.0,
                                fontWeight: FontWeight.w600,
                              ),
                              _sizedBox,
                              _text("Author : " + widget.videoData.author),
                              _sizedBox,
                            ],
                          ),
                        )
                      : const CircularProgressIndicator(
                          color: Colors.white38,
                          backgroundColor: Colors.white30,
                        ),
                ],
              ),
            ),
    );

    return player;
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
