import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/main.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path/path.dart' as path;

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  CarouselController carouselController = CarouselController();

  int indexChanged = 0;
  List<String> images = [];

  File fileFromTempDir(String filename) {
    String pathName = path.join(myTemporaryDirectory.path, filename + ".jpg");
    return File(pathName);
  }

  @override
  void initState() {
    images = [
      "https://image.freepik.com/free-vector/guaranteed-discount-advertisement-promo-banner_124507-3312.jpg",
      "https://www.couponbricks.com/static/country-select-home/img/country-select-home/find.png",
      "https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX30030312.jpg",
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: Core.getDefaultAppWidth(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: images
                .map(
                  (e) => Container(
                    margin: const EdgeInsets.only(left: 2.0),
                    decoration: BoxDecoration(
                      color: indexChanged == images.indexOf(e)
                          ? Colors.white
                          : Colors.white30,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    height: 16.0,
                    width: 16.0,
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        _sliderBuilder(context),
      ],
    );
  }

  Widget _sliderBuilder(BuildContext context) {
    return CarouselSlider(
      items: images
          .map(
            (e) => Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(
                  image: NetworkToFileImage(
                    url: e,
                    debug: true,
                    file: fileFromTempDir(
                      "Home-Image-" + images.indexOf(e).toString(),
                    ),
                    scale: 1.0,
                  ),
                  scale: 1.0,
                  fit: BoxFit.fitWidth,
                ),
              ),
              width: Core.getDefaultAppWidth(context),
            ),
          )
          .toList(),
      carouselController: carouselController,
      options: CarouselOptions(
        aspectRatio: 1.8,
        autoPlay: false,
        initialPage: 0,
        pageSnapping: true,
        disableCenter: false,
        viewportFraction: 1.03,
        enableInfiniteScroll: false,
        onPageChanged: (i, c) {
          setState(() => indexChanged = i);
        },
      ),
    );
  }
}
