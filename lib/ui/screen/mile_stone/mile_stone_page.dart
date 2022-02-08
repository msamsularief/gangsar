import 'package:flutter/material.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class MileStonePage extends StatelessWidget {
  const MileStonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BuildBodyWidget(
      appBar: KlinikAppBar(
        title: 'Mile Stone',
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
