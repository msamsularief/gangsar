import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/core/image_initial.dart';
import 'package:klinik/model/article.dart';
import 'package:klinik/model/image_component.dart';
import 'package:klinik/ui/widget/card_widget.dart';
import 'package:klinik/ui/widget/image_builder.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class ArticlePage extends StatelessWidget {
  final List<String> imageUrls;
  final ImageInitial imageInitial;
  const ArticlePage({
    Key? key,
    required this.imageUrls,
    required this.imageInitial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String article = "Lorem Ipsum is simply dummy text of the printing "
        "and typesetting industry. Lorem Ipsum has been the industry's standard "
        "dummy text ever since the 1500s, when an unknown printer took a galley of "
        "type and scrambled it to make a type specimen book. "
        "It has survived not only five centuries, but also the leap into "
        "electronic typesetting, remaining essentially unchanged. "
        "It was popularised in the 1960s with the release of Letraset sheets "
        "containing Lorem Ipsum passages, and more recently with desktop "
        "publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

    return Scaffold(
      appBar: KlinikAppBar(title: "Articles"),
      backgroundColor: Colors.orange.shade50,
      body: ListView.builder(
        itemCount: imageUrls.length,
        padding: const EdgeInsets.all(20.0),
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        itemBuilder: (context, index) {
          var imageComponent = ImageComponent(
            imageUrls[index],
            index,
            imageInitial,
          );
          return cardWidget(
            margin: const EdgeInsets.only(bottom: 16.0),
            onTap: () => navigateTo(
              "/view_article",
              arguments: Article(
                title: "Lorem Ipsum",
                description: article,
                imageComponent: imageComponent,
              ),
            ),
            child: _buildItem(
              context,
              imageComponent: imageComponent,
              title: "Lorem Ipsum",
              description: article,
            ),
          );
        },
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required ImageComponent imageComponent,
    required String title,
    required String description,
  }) {
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
              _text(description),
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
          fontWeight: fontWeight ?? FontWeight.normal,
          color: Colors.black,
        ),
      );
}
