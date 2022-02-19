import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/models/app_info.dart';
import 'package:klinik/ui/widget/sidebar_menu_item.dart';

Widget buildHomeDrawer(BuildContext context) {
  List<String> items = ["History"];
  List<Widget> widgets = [];

  final divider = Divider(
    height: 0.0,
    color: Theme.of(context).primaryColor,
    thickness: 0.2,
  );

  final header = Container(
    height: 100.0,
    width: Core.getDefaultAppWidth(context),
    margin: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
    ),
    // color: Colors.white.withOpacity(0.92),
    color: Theme.of(context).primaryColor.withOpacity(0.01),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16.0, top: 20.0),
          child: Text(
            "MENU",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 40.0,
                ),
          ),
        ),
        Divider(
          height: 0.0,
          thickness: 1.0,
          color: Theme.of(context).primaryColor,
        ),
      ],
    ),
  );

  final childrenHeight = MediaQuery.of(context).padding.top + 100.0;

  final listItem = Container(
    height: Core.getDefaultAppHeight(context) - childrenHeight,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.58),
          Colors.white.withOpacity(0.74),
          Colors.white.withOpacity(0.96),
        ],
      ),
    ),
    child: Column(
      children: [
        Expanded(
          flex: 9,
          child: Column(
            children: items
                .map(
                  (e) => Column(
                    children: [
                      SidebarMenuItem(
                        e,
                        AppRoute.history,
                      ),
                      divider,
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "App Version : ${appInfo.version}",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.normal,
                ),
          ),
        ),
      ],
    ),
  );

  widgets.add(header);
  widgets.add(listItem);

  return Drawer(
    backgroundColor: Theme.of(context).primaryColor,
    // backgroundColor: Colors.white,
    elevation: 8.0,
    child: Container(
      height: Core.getDefaultAppHeight(context),
      color: Colors.white.withOpacity(0.88),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: widgets,
        ),
      ),
    ),
  );
}
