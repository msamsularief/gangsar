import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/utils/route_arguments.dart';

class SidebarMenuItem extends StatelessWidget {
  final String title;
  final String? routeName;
  final RouteArgument? arguments;
  final GestureTapCallback? onTap;

  const SidebarMenuItem(this.title, this.routeName,
      {Key? key, this.onTap, this.arguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        onTap: onTap ??
            () {
              goBack();
              navigateTo(routeName!, arguments: arguments);
            });
  }
}
