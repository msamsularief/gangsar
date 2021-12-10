import 'package:flutter/material.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/helper/color_helper.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

///Create a Scaffold with Gradient background.
///
///Usahakan ini dijadikan Default ketika membuat Tampilan Baru.
///Jika ada yang kurang, bisa ditambahkan sesuai dengan fungsi yang dibutuhkan.
class BuildBodyWidget extends StatelessWidget {
  final Widget? body;
  final KlinikAppBar? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  ///Default value is False.
  final bool swipeBackgroudColors;
  const BuildBodyWidget({
    Key? key,
    required this.body,
    this.appBar,
    this.swipeBackgroudColors = false,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned(
            height: Core.getDefaultAppHeight(context),
            child: Container(
              width: Core.getDefaultAppWidth(context),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorHelper.fromHex("#FFE65100"),
                    ColorHelper.fromHex("#FFE65100"),
                    // Colors.orangeAccent.shade400,
                    ColorHelper.fromHex("#FFFF9100"),
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
          Positioned(
            child: SizedBox(
              height: Core.getDefaultAppHeight(context),
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
