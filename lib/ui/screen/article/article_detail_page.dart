import 'package:flutter/material.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/models/article.dart';
import 'package:klinik/models/image_component.dart';
import 'package:klinik/ui/widget/image_builder.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;
  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageComponent imageComponent = article.imageComponent as ImageComponent;
    return Scaffold(
      appBar: KlinikAppBar(
        title: article.title,
        centerTitle: false,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Imagebuilder(
              imageComponent: imageComponent,
              isForListItem: false,
              itemHeight: Core.getDefaultBodyHeight(context) / 3.4,
              itemWidth: Core.getDefaultAppWidth(context),
              borderRadius: BorderRadius.zero,
              boxFit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: _buildContent(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _text(
          context,
          article.title!,
          isTitle: true,
        ),
        SizedBox(
          height: 8.0,
        ),
        _text(
          context,
          article.description!,
        ),
      ],
    );
  }

  Widget _text(BuildContext context, String text, {bool isTitle = false}) =>
      Text(
        text,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.black,
              fontSize: isTitle ? 32.0 : 18.0,
              fontWeight: isTitle ? FontWeight.bold : FontWeight.w300,
            ),
      );
}
