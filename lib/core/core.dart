import 'package:flutter/material.dart';

class Core {
  ///GET default app height
  static getDefaultAppHeight(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return height;
  }

  ///GET default app width
  static getDefaultAppWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return width;
  }

  ///GET default app body height
  static getDefaultBodyHeight(BuildContext context) {
    final height =
        (MediaQuery.of(context).size.height - AppBar().preferredSize.height);

    return height;
  }
}
