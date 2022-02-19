// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:klinik/models/video.dart';
// import 'package:klinik/ui/widget/build_body_widget.dart';
// import 'package:klinik/ui/widget/klinik_appbar.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// class VideoPlayerSecond extends StatefulWidget {
//   final String videoId;
//   final Video video;
//   const VideoPlayerSecond(
//       {Key? key, required this.videoId, required this.video})
//       : super(key: key);

//   @override
//   _VideoPlayerSecondState createState() => _VideoPlayerSecondState();
// }

// class _VideoPlayerSecondState extends State<VideoPlayerSecond> {
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: widget.videoId,
//       params: YoutubePlayerParams(
//         autoPlay: true,
//         playlist: [],
//         showControls: true,
//         showFullscreenButton: true,
//         startAt: Duration(seconds: 0),
//       ),
//     );
//     _controller.onEnterFullscreen = () {
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.landscapeLeft,
//         DeviceOrientation.landscapeRight,
//       ]);
//       log('Entered Fullscreen');
//     };
//     _controller.onExitFullscreen = () {
//       log('Exited Fullscreen');
//     };
//   }

//   @override
//   void dispose() {
//     _controller.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     const player = YoutubePlayerIFrame(
//       aspectRatio: 16 / 9,
//     );
//     return YoutubePlayerControllerProvider(
//       controller: _controller,
//       child: BuildBodyWidget(
//         appBar: KlinikAppBar(
//           title: 'Video Player Second',
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             player,
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _text(
//                     widget.video.title,
//                     fontSize: 32.0,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   Divider(
//                     height: 32.0,
//                     thickness: 1.6,
//                   ),
//                   _text(
//                     "Author :  " + widget.video.author,
//                     fontSize: 24.0,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _text(
//     String? text, {
//     double? fontSize,
//     FontWeight? fontWeight,
//   }) =>
//       Text(
//         "$text",
//         textAlign: TextAlign.left,
//         style: TextStyle(
//           fontSize: fontSize ?? 18.0,
//           color: Theme.of(context).textTheme.bodyText1!.color,
//           fontWeight: fontWeight ?? FontWeight.normal,
//         ),
//       );
// }
