import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/core/image_initial.dart';
import 'package:klinik/model/article.dart';
import 'package:klinik/model/image_component.dart';
import 'package:klinik/ui/widget/article/article_items.dart';
import 'package:klinik/ui/widget/image_builder.dart';
import 'package:klinik/utils/route_arguments.dart';

class ArticleListWidget extends StatelessWidget {
  final double? imageHeight;
  final ImageInitial imageInitial;
  const ArticleListWidget({
    Key? key,
    this.imageHeight,
    required this.imageInitial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = 0.0;
    if (imageHeight == null) {
      height = Core.getDefaultAppBarHeight(context) * 1.8;
    }
    return SizedBox(
      height: height,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          _buildList(context),
          GestureDetector(
            onTap: () {
              navigateTo(
                AppRoute.articles,
                arguments: RouteArgument(
                  imageInitial: imageInitial,
                  imageUrls: articleImgUrls,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(4.0),
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.white,
              ),
              width: Core.getDefaultAppWidth(context) / 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "See More",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18.0,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    List<String> imgUrls = articleImgUrls;
    List<String> urls = [];

    String article = "Lorem Ipsum is simply dummy text of the printing "
        "and typesetting industry. Lorem Ipsum has been the industry's standard "
        "dummy text ever since the 1500s, when an unknown printer took a galley of "
        "type and scrambled it to make a type specimen book. "
        "It has survived not only five centuries, but also the leap into "
        "electronic typesetting, remaining essentially unchanged. "
        "It was popularised in the 1960s with the release of Letraset sheets "
        "containing Lorem Ipsum passages, and more recently with desktop "
        "publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

    if (imgUrls.length > 5) {
      for (var i = 0; i <= 4; i++) {
        urls.add(imgUrls[i]);
      }
    }

    return ListView.builder(
      itemCount: urls.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        String imgUrl = urls[index];

        ImageComponent imageComponent = ImageComponent(
          imgUrl,
          index,
          imageInitial,
        );

        return GestureDetector(
          onTap: () {
            print("""
ARTICLE ID : $index\n
ARTICLE IMG URL : $imgUrl\n
""");

            navigateTo(
              "/view_article",
              arguments: Article(
                title: "Lorem Ipsum",
                description: article,
                imageComponent: imageComponent,
              ),
            );
          },
          child: _imageBuilder(context, imageComponent),
        );
      },
    );
  }

  Widget _imageBuilder(
    BuildContext context,
    ImageComponent imageComponent,
  ) =>
      Imagebuilder(
        imageComponent: imageComponent,
        isForListItem: true,
        itemWidth: Core.getDefaultAppWidth(context) / 3,
      );
}
