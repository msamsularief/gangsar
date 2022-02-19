import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/helper/color_helper.dart';

///Create a Scaffold with Gradient background.
///
///Usahakan ini dijadikan Default ketika membuat Tampilan Baru.
///Jika ada yang kurang, bisa ditambahkan sesuai dengan fungsi yang dibutuhkan.
class BuildBodyWidget extends StatelessWidget {
  final Widget body;

  ///GUNAKAN `KlinikAppBar()` WIDGET !!!
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;
  final Widget? endDrawer;
  final List<Widget>? persistentFooterButtons;

  final ScrollController controller = ScrollController();

  ///Default value is False.
  final bool swipeBackgroudColors;
  BuildBodyWidget({
    Key? key,
    required this.body,
    this.appBar,
    this.swipeBackgroudColors = false,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: appBar,
      backgroundColor: Colors.white,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      extendBodyBehindAppBar: true,
      drawer: drawer,
      endDrawer: endDrawer,
      drawerDragStartBehavior: DragStartBehavior.start,
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,
      resizeToAvoidBottomInset: true,
      persistentFooterButtons: persistentFooterButtons,
      body: Stack(
        children: [
          Positioned(
            height: Core.getDefaultAppHeight(context),
            width: Core.getDefaultAppWidth(context),
            child: Container(
              // width: Core.getDefaultAppWidth(context),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorHelper.fromHex("#FF9CEE").withOpacity(0.4),
                    // ColorHelper.fromHex("#FFE65100"),
                    // ColorHelper.fromHex("#FFE65100"),
                    // Colors.orangeAccent.shade400,
                    ColorHelper.fromHex("#FF9CEE").withOpacity(0.2),
                    ColorHelper.fromHex("#FF9CEE").withOpacity(0.06),
                    ColorHelper.fromHex("#FF9CEE").withOpacity(0.02),
                  ],
                  begin: swipeBackgroudColors
                      ? Alignment.bottomCenter
                      : Alignment.topCenter,
                  end: swipeBackgroudColors
                      ? Alignment.topCenter
                      : Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          SafeArea(
            child: appBar != null
                ? Container(
                    height: Core.getDefaultAppHeight(context),
                    width: Core.getDefaultAppWidth(context),
                    color: Colors.transparent,
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      controller: controller,
                      physics: AlwaysScrollableScrollPhysics(),
                      child: body,
                    ),
                  )
                : Container(
                    height: Core.getDefaultAppHeight(context),
                    width: Core.getDefaultAppWidth(context),
                    color: Colors.transparent,
                    child: SingleChildScrollView(
                      controller: controller,
                      physics: AlwaysScrollableScrollPhysics(),
                      child: body,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
