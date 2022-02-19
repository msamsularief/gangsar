import 'package:flutter/material.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class LoadingWidget extends StatelessWidget {
  final String title;
  const LoadingWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BuildBodyWidget(
      appBar: KlinikAppBar(
        title: title,
      ),
      body: Container(
        height: Core.getDefaultBodyHeight(context),
        alignment: Alignment.center,
        child: SizedBox(
          height: 80.0,
          width: 80.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
