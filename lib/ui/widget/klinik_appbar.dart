import 'package:flutter/material.dart';
import 'package:klinik/core/core.dart';

///Default AppBar untuk aplikasi Klinik Digital
class KlinikAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final List<Widget>? actions;
  final Widget? leading;

  ///Jika [child] tidak kosong, maka [title] tidak akan ditampilkan.
  final String? title;

  ///default-nya adalah **40.0**
  final double? titleTextSize;
  final PreferredSizeWidget? bottom;
  final bool? centerTitle;
  final bool automaticallyImplyLeading;
  final bool shadow;
  final double titleSpacing;
  final Color? leadingButtonColor;
  final Widget? flexibleSpace;

  ///Digunakan untuk mengganti [title].
  ///Jika [child] tidak kosong, maka [title] otomatis akan di-*replace*.
  ///
  final Widget? child;

  KlinikAppBar({
    Key? key,
    this.height,
    this.actions,
    this.leading,
    this.title,
    this.titleTextSize,
    this.bottom,
    this.centerTitle,
    this.automaticallyImplyLeading = true,
    this.shadow = true,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.leadingButtonColor,
    this.flexibleSpace,
    this.child,
  }) : super(key: key);

  @override
  Size get preferredSize {
    if (height == null) {
      return Size.fromHeight(AppBar().preferredSize.height);
    } else {
      return Size.fromHeight(height!);
    }
  }

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
        actions: actions,
        bottom: bottom,
        leading: leading == null && automaticallyImplyLeading == true
            ? TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) => Colors.transparent),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: leadingButtonColor ?? Colors.white,
                ),
              )
            : leading == null && automaticallyImplyLeading == false
                ? leading
                : leading,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        primary: false,
        centerTitle: centerTitle,
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: child ??
            Text(
              title!,
              style: TextStyle(
                fontSize: titleTextSize ?? 40.0,
              ),
            ),
        titleSpacing: titleSpacing,
        flexibleSpace: flexibleSpace,
      ),
    );
  }
}
