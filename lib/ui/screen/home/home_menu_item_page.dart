import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/core/image_initial.dart';
import 'package:klinik/ui/widget/article/article_list_widget.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';
import 'package:klinik/ui/widget/slider_widget.dart';
import 'package:klinik/ui/widget/video_player/video_items.dart';
import 'package:klinik/ui/widget/video_player/video_list_widget.dart';

class HomeMenuItemPage extends StatelessWidget {
  final String title;
  const HomeMenuItemPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> bumilItems = [
      "Index Masa Tubuh",
      "Hari Perkiraan Lahir",
      "Perkembangan Janin",
      "Kesehatan Ibu",
    ];
    List<String> busuiItems = [
      "Index Masa Tubuh",
      "HPHT",
    ];
    // List<String> promilItems = ["BMI", "HPHT"];

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
            _sizedBox(),
            _buildBodyItem(
              context,
              title.toLowerCase() == "ibu hamil" ? bumilItems : busuiItems,
            ),
            _sizedBox(
              height: 56.0,
            ),
            _text(
              context,
              "Videos",
              fontSize: 24.0,
            ),
            _sizedBox(),
            VideoListWidget(
              imageCacheInitialName: ImageInitial.videoThumbnail,
              videoUrls: videoUrls,
            ),
            _sizedBox(
              height: 32.0,
            ),
            _text(
              context,
              "Articles",
              fontSize: 24.0,
            ),
            _sizedBox(),
            ArticleListWidget(
              imageInitial: ImageInitial.articleImage,
            ),
            _sizedBox(
              height: 32.0,
            ),
            _text(
              context,
              "Update Informasi",
              fontSize: 24.0,
            ),
            _sizedBox(),
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
          onPressed: () {
            print("\n\nLABEL : $label\n\n");
            if (label.toLowerCase() == "index masa tubuh") {
              navigateTo(AppRoute.bodyMassIndex);
            }
          },
          title: label,
          titleSize: 24.0,
          textPadding: EdgeInsets.all(20.0),
          titleColor: Theme.of(context).primaryColor,
          buttonDefaultColor: Colors.white,
          titleFontWeight: FontWeight.bold,
          width: Core.getDefaultAppWidth(context),
        );
      },
    );
  }

  Widget _text(
    BuildContext context,
    String? text, {
    double? fontSize,
  }) =>
      Text(
        "$text",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: fontSize ?? 18.0,
          color: Theme.of(context).textTheme.bodyText1!.color,
        ),
      );

  Widget _sizedBox({double? height}) => SizedBox(
        height: height ?? 20.0,
      );
}
