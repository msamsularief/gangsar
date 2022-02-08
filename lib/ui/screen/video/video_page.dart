import 'package:flutter/material.dart';
import 'package:klinik/ui/screen/video/video_view.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BuildBodyWidget(
      appBar: KlinikAppBar(
        title: "Videos",
      ),
      body: VideoView(
        isFromTabMenu: false,
      ),
    );
  }
}
