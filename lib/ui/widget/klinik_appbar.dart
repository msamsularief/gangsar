import 'package:flutter/material.dart';
import 'package:klinik/core/core.dart';

///Default AppBar untuk aplikasi Klinik Digital
class KlinikAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final List<Widget>? children;
  final Widget? leading;
  final String title;
  final PreferredSizeWidget? bottom;
  final bool? centerTitle;
  final bool automaticallyImplyLeading;
  final bool shadow;
  final double titleSpacing;

  @override
  final Size preferredSize = Size.fromHeight(AppBar().preferredSize.height);

  KlinikAppBar({
    Key? key,
    this.height,
    this.children,
    this.leading,
    required this.title,
    this.bottom,
    this.centerTitle,
    this.automaticallyImplyLeading = true,
    this.shadow = true,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      height: height,
      width: Core.getDefaultAppWidth(context),
      decoration: BoxDecoration(
        boxShadow: shadow
            ? [
                const BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ]
            : [],
        color: Theme.of(context).primaryColor,
      ),
      child: AppBar(
        actions: children,
        bottom: bottom,
        leading: leading,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        primary: false,
        centerTitle: centerTitle,
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 40.0,
          ),
        ),
        titleSpacing: titleSpacing,
      ),
    );
  }
}
