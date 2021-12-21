import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/core/image_initial.dart';
import 'package:klinik/helper/video_helper.dart';

class SliderWidget extends StatefulWidget {
  final List<String>? images;
  final ImageInitial imageCacheInitialName;
  const SliderWidget(
      {Key? key, this.images, required this.imageCacheInitialName})
      : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  CarouselController carouselController = CarouselController();

  int indexChanged = 0;
  List<String> images = [];

  void _initialImages() {
    if (widget.images != null) {
      List<String> listItems = [];
      widget.images!.map((e) {
        String videoUrl = VideoHelper.getVideoThumbnail(e);
        listItems.add(videoUrl);
      }).toList();
      setState(() {
        images = listItems;
      });
    } else {
      images = [
        "https://image.freepik.com/free-vector/guaranteed-discount-advertisement-promo-banner_124507-3312.jpg",
        "https://www.couponbricks.com/static/country-select-home/img/country-select-home/find.png",
        "https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX30030312.jpg",
      ];
    }
  }

  @override
  void initState() {
    super.initState();
    _initialImages();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Core.getDefaultAppHeight(context) / 4,
      width: Core.getDefaultAppWidth(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: _indicatorBuilder(context),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            flex: 14,
            child: _sliderBuilder(context),
          ),
        ],
      ),
    );
  }

  Widget _indicatorBuilder(BuildContext context) => SizedBox(
        width: Core.getDefaultAppWidth(context),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: images.length,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return Container(
              margin: const EdgeInsets.only(left: 2.0),
              decoration: BoxDecoration(
                color: indexChanged == i ? Colors.white : Colors.white30,
                borderRadius: BorderRadius.circular(4.0),
              ),
              height: 16.0,
              width: 16.0,
            );
          },
        ),
      );

  Widget _sliderBuilder(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, realIndex) => CachedNetworkImage(
        imageUrl: images[realIndex],
        fadeInCurve: Curves.easeIn,
        cacheKey: widget.imageCacheInitialName.name + realIndex.toString(),
        alignment: Alignment.center,
        cacheManager: CacheManager(
          Config(
            widget.imageCacheInitialName.name,
            repo: CacheObjectProvider(
              databaseName: widget.imageCacheInitialName.name,
            ),
            stalePeriod: const Duration(milliseconds: 100),
          ),
        ),
        filterQuality: FilterQuality.low,
        fit: BoxFit.fitWidth,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fitWidth,
              scale: 1.0,
            ),
          ),
          width: Core.getDefaultAppWidth(context),
        ),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
          ),
          width: Core.getDefaultAppWidth(context),
          child: Text(
            "Error when load image from\n$url\n$error",
          ),
        ),
        progressIndicatorBuilder: (context, url, progress) => Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white30,
            color: Theme.of(context).primaryColor.withOpacity(0.4),
            value: progress.downloaded.toDouble(),
            valueColor: AlwaysStoppedAnimation(
              Theme.of(context).primaryColor,
            ),
          ),
        ),
        fadeOutCurve: Curves.easeInOut,
        useOldImageOnUrlChange: true,
      ),
      carouselController: carouselController,
      options: CarouselOptions(
        aspectRatio: 1.9,
        autoPlay: false,
        initialPage: 0,
        pageSnapping: true,
        disableCenter: false,
        viewportFraction: 1.00,
        enableInfiniteScroll: false,
        onPageChanged: (i, c) {
          print("INDEX : $i");
          setState(() => indexChanged = i);
        },
      ),
    );
  }
}
