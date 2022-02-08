import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/core/image_initial.dart';
import 'package:klinik/helper/color_helper.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/slider_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
        left: 20.0,
        right: 20.0,
      ),
      // physics: ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMenu(context),
          _sizedBox(),
          _text(
            "Update Informasi",
            fontSize: 24.0,
          ),
          _sizedBox(height: 12.0),
          const SliderWidget(
            imageCacheInitialName: ImageInitial.informationsImage,
          ),
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    List<String> items = ["Ibu Hamil", "Ibu dan Anak", "Persiapan Kehamilan"];

    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (c, i) {
        String label = items[i];
        return Column(
          children: [
            CustomButton.defaultButton(
              onPressed: () {
                navigateTo(AppRoute.homeMenuItemPage, arguments: label);
              },
              title: label,
              titleSize: 18.0,
              titleColor: Theme.of(context).primaryColor,
              buttonDefaultColor: Colors.white,
              titleFontWeight: FontWeight.bold,
              width: Core.getDefaultAppWidth(context),
              height: 60.0,
            ),
            _sizedBox(),
          ],
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
          color: ColorHelper.fromHex("#240B1D"),
        ),
      );

  Widget _sizedBox({
    double? height,
  }) =>
      SizedBox(
        height: height ?? 24.0,
      );
}
