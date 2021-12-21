import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/core/image_initial.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';
import 'package:klinik/ui/widget/slider_widget.dart';
import 'package:klinik/ui/widget/video_player/video_list_widget.dart';

class HomeMenuItemPage extends StatelessWidget {
  final String title;
  const HomeMenuItemPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> bumilItems = ["BMI", "HPL", "Mile Stone", "Lokasi Terdekat"];
    List<String> busuiItems = ["BMI", "HPHT"];
    // List<String> promilItems = ["BMI", "HPHT"];

    List<String> videoUrls = [
      "https://www.youtube.com/watch?v=G2quVLcJVBk&ab_channel=Let%27sLearnPublicHealth",
      "https://www.youtube.com/watch?v=8PH4JYfF4Ns&ab_channel=Let%27sLearnPublicHealth",
      "https://www.youtube.com/watch?v=3Dtq3mKT_Yk&ab_channel=TheColoradoTrust",
      "https://www.youtube.com/watch?v=G2quVLcJVBk&ab_channel=Let%27sLearnPublicHealth",
      "https://www.youtube.com/watch?v=8PH4JYfF4Ns&ab_channel=Let%27sLearnPublicHealth",
      "https://www.youtube.com/watch?v=3Dtq3mKT_Yk&ab_channel=TheColoradoTrust",
      "https://www.youtube.com/watch?v=G2quVLcJVBk&ab_channel=Let%27sLearnPublicHealth",
      "https://www.youtube.com/watch?v=8PH4JYfF4Ns&ab_channel=Let%27sLearnPublicHealth",
      "https://www.youtube.com/watch?v=3Dtq3mKT_Yk&ab_channel=TheColoradoTrust",
    ];

    return BuildBodyWidget(
      appBar: KlinikAppBar(
        title: title.toUpperCase(),
        centerTitle: true,
        automaticallyImplyLeading: true,
        shadow: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sizedBox,
            _buildBodyItem(
              context,
              title.toLowerCase() == "bumil" ? bumilItems : busuiItems,
            ),
            _sizedBox,
            _sizedBox,
            _text(
              "Videos",
              fontSize: 24.0,
            ),
            _sizedBox,
            VideoListWidget(
              height: Core.getDefaultAppBarHeight(context) * 2,
              imageCacheInitialName: ImageInitial.videoThumbnail,
              videoUrls: videoUrls,
            ),
            _sizedBox,
            _sizedBox,
            _text(
              "Articles",
              fontSize: 24.0,
            ),
            _sizedBox,
            VideoListWidget(
                height: Core.getDefaultAppBarHeight(context) * 2,
                imageCacheInitialName: ImageInitial.videoThumbnail,
                videoUrls: videoUrls),
            _sizedBox,
            _sizedBox,
            _text(
              "Update Informasi",
              fontSize: 24.0,
            ),
            _sizedBox,
            const SliderWidget(
              imageCacheInitialName: ImageInitial.informationsImage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyItem(BuildContext context, List<String> items) {
    return GridView.builder(
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      itemBuilder: (context, index) {
        String label = items[index];
        return CustomButton.defaultButton(
          onPressed: () {},
          title: label,
          titleSize: 18.0,
          titleColor: Theme.of(context).primaryColor,
          titleFontWeight: FontWeight.bold,
          width: Core.getDefaultAppWidth(context),
          // height: 60.0,
        );
      },
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
