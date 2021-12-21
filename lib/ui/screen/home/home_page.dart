import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/core/image_initial.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/slider_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      physics: const ClampingScrollPhysics(),
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
    List<String> items = ["Bumil", "Busui", "Promil"];

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
          color: Colors.white,
        ),
      );

  Widget _sizedBox({
    double? height,
  }) =>
      SizedBox(
        height: height ?? 24.0,
      );
}
