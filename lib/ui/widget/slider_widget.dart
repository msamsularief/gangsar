import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/core/image_initial.dart';
import 'package:klinik/helper/video_helper.dart';
import 'package:klinik/model/image_component.dart';
import 'package:klinik/ui/widget/image_builder.dart';

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
    double appHeight = 0.0;
    if (appHeight > 700) {
      appHeight = Core.getDefaultAppHeight(context) / 4;
    } else {
      appHeight = Core.getDefaultAppHeight(context) / 3.20;
    }
    return SizedBox(
      height: appHeight,
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
                color: indexChanged == i
                    ? Theme.of(context).primaryColor.withOpacity(0.6)
                    : Theme.of(context).primaryColor.withOpacity(0.18),
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
      itemBuilder: (context, index, realIndex) {
        var imageComponent = ImageComponent(
          images[realIndex],
          realIndex,
          widget.imageCacheInitialName,
        );

        return Imagebuilder(
          isForListItem: false,
          imageComponent: imageComponent,
        );
      },
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
