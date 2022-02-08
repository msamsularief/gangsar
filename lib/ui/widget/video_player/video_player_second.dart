// import 'package:flutter/material.dart';
// import 'package:klinik/ui/widget/klinik_appbar.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerSecond extends StatefulWidget {
//   final String videoUrl;
//   const VideoPlayerSecond({Key? key, required this.videoUrl}) : super(key: key);

//   @override
//   _VideoPlayerSecondState createState() => _VideoPlayerSecondState();
// }

// class _VideoPlayerSecondState extends State<VideoPlayerSecond> {
//   late VideoPlayerController _controller;
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(
//       widget.videoUrl,
//     )..setLooping(false);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }

//   Future<dynamic> _init() async {
//     await _controller.initialize();
//     return Null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: KlinikAppBar(
//         title: "Video Player",
//       ),
//       body: SingleChildScrollView(
//         child: FutureBuilder(
//           future: _init(),
//           builder: (context, snap) {
//             if (snap.connectionState == ConnectionState.done) {
//               return Container(
//                 child: Text("ON DATA"),
//               );
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
