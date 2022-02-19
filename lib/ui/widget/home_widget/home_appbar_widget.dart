import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/core/image_initial.dart';
import 'package:klinik/models/image_component.dart';
import 'package:klinik/ui/widget/home_widget/home_klinik_appbar.dart';
import 'package:klinik/ui/widget/image_builder.dart';

HomeKlinikAppBar buildHomeAppBar(BuildContext context, {String? title}) {
  final String imageUrl =
      "https://cdn2.iconfinder.com/data/icons/business-and-finance-related-hand-gestures/256/face_female_blank_user_avatar_mannequin-512.png";

  final userName = "Gangsar O";

  final avatarWidget = Container(
    decoration: BoxDecoration(
      color: Colors.white60,
      borderRadius: BorderRadius.circular(80.0),
    ),
    height: 54.0,
    width: 54.0,
    padding: EdgeInsets.all(4.0),
    child: Imagebuilder(
      imageComponent: ImageComponent(
        imageUrl,
        0,
        ImageInitial.photoProfile,
      ),
      isForListItem: false,
      borderRadius: BorderRadius.circular(80.0),
      boxFit: BoxFit.fill,
    ),
  );

  final rowWidget = Container(
    margin: EdgeInsets.only(top: 14.0, left: 16.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => navigateTo(AppRoute.detailProfile),
          child: avatarWidget,
        ),
        SizedBox(
          width: 8.0,
        ),
        GestureDetector(
          onTap: () => navigateTo(AppRoute.detailProfile),
          child: Text(
            title ?? userName,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                  fontSize: 40.0,
                ),
          ),
        ),
      ],
    ),
  );

  final appbarHeight = Core.getDefaultAppHeight(context) > 800
      ? Core.getDefaultAppBarHeight(context) * 2.2
      : Core.getDefaultAppBarHeight(context) * 2.0;

  return HomeKlinikAppBar(
    useSwipeableToOpenEndDrawer: true,
    title: title ?? userName,
    child: title != null
        ? Padding(
            padding: EdgeInsets.only(top: 26.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                    fontSize: 40.0,
                  ),
            ),
          )
        : SizedBox(),
    centerTitle: title != null ? true : false,
    automaticallyImplyLeading: false,
    height: appbarHeight,
    flexibleSpace: title != null ? null : rowWidget,
    actions: [
      Builder(
        builder: (context) => GestureDetector(
          onTap: () => Scaffold.of(context).openEndDrawer(),
          child: Container(
            margin: EdgeInsets.only(top: 20.0, right: 16.0),
            height: 40.0,
            width: 40.0,
            child: Icon(
              Icons.menu,
              color: Colors.white,
              size: 40.0,
            ),
          ),
        ),
      ),
    ],
  );
}
