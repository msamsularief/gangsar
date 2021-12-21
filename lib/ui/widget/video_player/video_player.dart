import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String videoId;
  const VideoPlayer({Key? key, required this.videoId}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer>
    with TickerProviderStateMixin {
  late YoutubePlayerController _controller;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  late AnimationController _animController;

  bool _isPlayerReady = false;
  bool _isFullScreen = false;
  String? videoId = "";

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  void onEnterFullScreen() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void onExitFullScreen() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void initState() {
    super.initState();

    videoId = widget.videoId;

    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        controlsVisibleAtStart: false,
        enableCaption: true,
        loop: true,
      ),
    )..addListener(listener);

    _animController = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 300),
    );
    _playerState = PlayerState.unknown;
    _videoMetaData = const YoutubeMetaData();
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
    _animController.dispose();
    // _idController.dispose();
    // _seekToController.dispose();
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
      onEnterFullScreen: onEnterFullScreen,
      onExitFullScreen: onExitFullScreen,
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        progressColors: _progressBarColors,
        bottomActions: [
          CurrentPosition(),
          ProgressBar(
            isExpanded: true,
            colors: _progressBarColors,
          ),
          RemainingDuration(),
          FullScreenButton(),
        ],
        onReady: () {
          setState(() {
            _isPlayerReady = true;
            SystemChrome.setEnabledSystemUIMode(
              SystemUiMode.immersiveSticky,
              overlays: [SystemUiOverlay.bottom],
            );
          });
        },
        onEnded: (data) {
          _controller.pause();
          _controller.reload();
        },
      ),
      builder: (context, child) => BuildBodyWidget(
        appBar: KlinikAppBar(title: "Playing Video"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              child,
              _sizedBox,
              _isPlayerReady
                  ? Container(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _text(
                            _videoMetaData.title,
                            fontSize: 24.0,
                          ),
                          _sizedBox,
                          _text("Author : " + _videoMetaData.author),
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
      ),
    );
  }

  Widget _text(
    String? text, {
    double? fontSize,
  }) =>
      Text(
        "$text",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: fontSize ?? 18.0,
          color: Colors.white,
        ),
      );

  Widget get _sizedBox => const SizedBox(
        height: 20.0,
      );
}

// import 'package:flutter/material.dart';
// import 'package:flutter_youtube_view/flutter_youtube_view.dart';
// import 'package:klinik/core/core.dart';
// import 'package:klinik/ui/widget/build_body_widget.dart';
// import 'package:klinik/ui/widget/klinik_appbar.dart';

// class VideoPlayer extends StatefulWidget {
//   final String videoId;
//   const VideoPlayer({Key? key, required this.videoId}) : super(key: key);

//   @override
//   State<VideoPlayer> createState() => _VideoPlayerState();
// }

// class _VideoPlayerState extends State<VideoPlayer>
//     implements YouTubePlayerListener {
//   late FlutterYoutubeViewController _viewController;
//   double _currentVideoSecond = 0.0;
//   String _playerState = "";

//   void _onYoutubeCreated(FlutterYoutubeViewController controller) =>
//       _viewController = controller;

//   void _loadOrCueVideo() {
//     _viewController.loadOrCueVideo('gcj2RUWQZ60', _currentVideoSecond);
//   }

//   @override
//   void onCurrentSecond(double second) {
//     print("onCurrentSecond second = $second");
//     _currentVideoSecond = second;
//   }

//   @override
//   void onError(String error) {
//     print("ERROR when playing.\n$error");
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text("Error when playing video.\n msg : $error"),
//         backgroundColor: Colors.red.shade200,
//         duration: const Duration(milliseconds: 800),
//         elevation: 2.0,
//         padding: const EdgeInsets.all(16.0),
//         width: Core.getDefaultAppWidth(context),
//       ),
//     );
//   }

//   @override
//   void onReady() {
//     _viewController.play();
//   }

//   @override
//   void onStateChange(String state) {
//     print("onStateChange state = $state");
//     setState(() {
//       _playerState = state;
//     });
//   }

//   @override
//   void onVideoDuration(double duration) {
//     print("onVideoDuration duration = $duration");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BuildBodyWidget(
//       appBar: KlinikAppBar(title: "Video Player"),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: Core.getDefaultAppHeight(context) / 2,
//               width: Core.getDefaultAppWidth(context),
//               child: FlutterYoutubeView(
//                 listener: this,
//                 onViewCreated: _onYoutubeCreated,
//                 scaleMode: YoutubeScaleMode.fitWidth,
//                 params: YoutubeParam(
//                   videoId: widget.videoId,
//                   autoPlay: true,
//                   showFullScreen: false,
//                   showUI: true,
//                   showYoutube: false,
//                   startSeconds: 0.0,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
