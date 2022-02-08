import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/model/image_component.dart';

class Imagebuilder extends StatelessWidget {
  final ImageComponent imageComponent;
  final double? itemHeight;
  final double? itemWidth;

  ///Jika gambar bukan untuk tampilan Item dari sebuah List,
  ///maka harus di set ke `false`.
  final bool isForListItem;

  ///Hanya digunakan ketika memang harus merubah radius dari bordernya.
  ///
  ///*Contoh: hendak membuat tampilan seperti Circle Avatar. Dimana Radiusnya
  ///harus lebih besar dari 16.0.*
  ///
  ///Default-nya adalah `BorderRadius.circular(16.0)`.
  final BorderRadiusGeometry? borderRadius;
  final BoxFit? boxFit;

  const Imagebuilder({
    Key? key,
    this.itemHeight,
    this.itemWidth,
    required this.isForListItem,
    this.borderRadius,
    this.boxFit,
    required this.imageComponent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = 0.0;
    double width = 0.0;
    if (itemHeight == null) {
      height = Core.getDefaultAppBarHeight(context);
    }
    if (itemWidth == null) {
      width = Core.getDefaultAppWidth(context);
    }
    if (itemHeight != null) {
      height = itemHeight!;
    }
    if (itemWidth != null) {
      width = itemWidth!;
    }

    return CachedNetworkImage(
      imageUrl: imageComponent.imageUrl,
      fadeInCurve: Curves.easeIn,
      cacheKey:
          imageComponent.imageInitial.name + imageComponent.index.toString(),
      alignment: Alignment.center,
      cacheManager: CacheManager(
        Config(
          imageComponent.imageInitial.name,
          repo: CacheObjectProvider(
            databaseName: imageComponent.imageInitial.name,
          ),
          stalePeriod: const Duration(milliseconds: 100),
        ),
      ),
      filterQuality: FilterQuality.low,
      fit: boxFit ?? BoxFit.fitWidth,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(16.0),
          color: Colors.white,
          image: DecorationImage(
            image: imageProvider,
            fit: boxFit ?? BoxFit.fitWidth,
            scale: 16 / 9,
          ),
        ),
        margin: isForListItem
            ? const EdgeInsets.only(
                right: 4.0,
              )
            : null,
        width: width,
        height: height,
      ),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(16.0),
        width: width,
        height: height,
        child: Text(
          "Error when load image from\n$url\n$error",
        ),
      ),
      progressIndicatorBuilder: (context, url, progress) => Container(
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          maxRadius: 40.0,
          child: CircularProgressIndicator(
            backgroundColor: Colors.white30,
            color: Theme.of(context).primaryColor.withOpacity(0.4),
            value: progress.downloaded.toDouble(),
            valueColor: AlwaysStoppedAnimation(
              Theme.of(context).primaryColor,
            ),
          ),
        ),
        margin: isForListItem ? const EdgeInsets.only(right: 4.0) : null,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        height: height,
        width: width,
      ),
      fadeOutCurve: Curves.easeInOut,
      useOldImageOnUrlChange: true,
    );
  }
}
