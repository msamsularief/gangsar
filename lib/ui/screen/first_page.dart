import 'package:flutter/material.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KlinikAppBar(title: "First Page"),
      body: Container(),
    );
  }
}
