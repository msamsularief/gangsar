import 'package:flutter/material.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/helper/color_helper.dart';
import 'package:klinik/models/image_component.dart';
import 'package:klinik/ui/widget/card_widget.dart';
import 'package:klinik/ui/widget/image_builder.dart';

class VideoItemView extends StatelessWidget {
  final ImageComponent imageComponent;
  final String title;
  final String author;

  const VideoItemView({
    Key? key,
    required this.imageComponent,
    required this.title,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return cardWidget(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: _buildItem(
        context,
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Column(
      children: [
        Imagebuilder(
          imageComponent: imageComponent,
          isForListItem: false,
          itemHeight: Core.getDefaultBodyHeight(context) / 3.6,
          itemWidth: Core.getDefaultAppWidth(context),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          boxFit: BoxFit.cover,
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
          ),
          width: Core.getDefaultAppWidth(context),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _text(
                title,
                fontWeight: FontWeight.w500,
              ),
              _text(author),
            ],
          ),
        ),
      ],
    );
  }

  Widget _text(String text, {FontWeight? fontWeight}) => Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: ColorHelper.fromHex("#240B1D"),
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      );
}
