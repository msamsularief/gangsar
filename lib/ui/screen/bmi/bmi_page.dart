import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/custom_form_field.dart';
import 'package:klinik/ui/widget/form_focus_node.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({Key? key}) : super(key: key);

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  final TextEditingController _bbController = TextEditingController();
  final TextEditingController _tbController = TextEditingController();
  late FocusNode _bbFocus;
  late FocusNode _tbFocus;

  bool textIsEmpty = false;
  String? errorMessage = "";
  String? bmiMessage = "";

  @override
  void initState() {
    _bbFocus = FocusNode();
    _tbFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _bbFocus.dispose();
    _tbFocus.dispose();
    _bbController.dispose();
    _tbController.dispose();
    super.dispose();
  }

  void _onSubmitted() {
    setState(() {
      _tbFocus.unfocus();

      if (_bbController.text.isNotEmpty && _tbController.text.isNotEmpty) {
        setState(() {
          textIsEmpty = false;
          double bb = double.parse(_bbController.text);
          double tb = double.parse(_tbController.text);

          print("\nBerat Badan : $bb & Tinggi Badan : $tb\n");

          var _tb = tb / 100;
          print("\n\nTB : $_tb\n\n");
          var tbTotal = _tb * 2;
          var bmi = bb / tbTotal;

          print("\n\n\nBMI Anda adalah : ${bmi.toStringAsPrecision(4)}\n\n\n");

          bmiMessage = bmi.toStringAsPrecision(4);
        });
      } else {
        if (_bbController.text.isEmpty) {
          textIsEmpty = true;
          errorMessage = "Berat Badan harus diisi !";
        }
        if (_tbController.text.isEmpty) {
          textIsEmpty = true;
          errorMessage = "Tinggi Badan tidak boleh kosong !";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double sizeActionButton = 40.0;

    void _handleClick(String value) {
      switch (value) {
        case 'History':
          navigateTo("/bmi_history");
          break;
      }
    }

    return BuildBodyWidget(
      appBar: KlinikAppBar(
        title: "Index Masa Tubuh",
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: PopupMenuButton(
              onSelected: _handleClick,
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 32.0,
              ),
              itemBuilder: (context) => ["History"]
                  .map(
                    (e) => PopupMenuItem(
                      child: Text(
                        e,
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
                      value: e,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      body: bmiMessage!.isNotEmpty
          ? _bmiMessageBuildBody(context)
          : GestureDetector(
              child: _buildBody(context),
              onTap: () {
                _bbFocus.unfocus();
                _tbFocus.unfocus();
              },
            ),
    );
  }

  Widget _bmiMessageBuildBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 8.0,
            blurStyle: BlurStyle.solid,
            color: Colors.purple.shade100.withOpacity(0.2),
            offset: Offset(1.0, 0.8),
            spreadRadius: 2,
          ),
          BoxShadow(
            blurRadius: 8.0,
            blurStyle: BlurStyle.solid,
            color: Colors.blueGrey.shade200.withOpacity(0.2),
            offset: Offset(1.8, 2.8),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text("Index masa tubuh Anda adalah :"),
          Text(
            "$bmiMessage",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Container(
            margin: EdgeInsets.only(top: 32.0),
            width: Core.getDefaultAppWidth(context) / 2,
            child: CustomButton.defaultButton(
              title: "Hitung Ulang",
              titleSize: 18.0,
              titleColor: Colors.white,
              buttonDefaultColor: Theme.of(context).primaryColor,
              titleFontWeight: FontWeight.bold,
              width: Core.getDefaultAppWidth(context),
              height: 48.0,
              onPressed: () => setState(() => bmiMessage = ""),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 8.0,
            blurStyle: BlurStyle.solid,
            color: Colors.purple.shade100.withOpacity(0.2),
            offset: Offset(1.0, 0.8),
            spreadRadius: 2,
          ),
          BoxShadow(
            blurRadius: 8.0,
            blurStyle: BlurStyle.solid,
            color: Colors.blueGrey.shade200.withOpacity(0.2),
            offset: Offset(1.8, 2.8),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Form(
        child: Column(
          children: [
            Text(
              "Perhitungan ini dapat digunakan untuk perempuan yang ingin melihat kisaran kenaikan berat badan yang sehat selama kehamilan berdasarkan berat badan mereka sebelum hamil.",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    wordSpacing: 0.6,
                    letterSpacing: 0.8,
                  ),
              textAlign: TextAlign.justify,
              softWrap: true,
            ),
            SizedBox(
              height: 32.0,
            ),
            Text("Berat Badan (kg) :"),
            Container(
              margin: EdgeInsets.only(
                top: 8.0,
                bottom: 24.0,
              ),
              width: Core.getDefaultAppWidth(context) / 3,
              child: CustomFormField(
                controller: _bbController,
                focusNode: _bbFocus,
                hintText: "55",
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (p0) => formFocusNode(context, _tbFocus),
              ),
            ),
            Text("Tinggi Badan (cm) :"),
            Container(
              margin: EdgeInsets.only(
                top: 8.0,
                bottom: 32.0,
              ),
              width: Core.getDefaultAppWidth(context) / 3,
              child: CustomFormField(
                controller: _tbController,
                focusNode: _tbFocus,
                hintText: "170",
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.go,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (p0) => _onSubmitted(),
              ),
            ),
            textIsEmpty
                ? Text(
                    "$errorMessage",
                    style: TextStyle(color: Colors.black),
                  )
                : SizedBox(),
            Container(
              margin: EdgeInsets.only(top: !textIsEmpty ? 0.0 : 32.0),
              width: Core.getDefaultAppWidth(context) / 2,
              child: CustomButton.defaultButton(
                title: "Hitung",
                titleSize: 18.0,
                titleColor: Colors.white,
                buttonDefaultColor: Theme.of(context).primaryColor,
                titleFontWeight: FontWeight.bold,
                width: Core.getDefaultAppWidth(context),
                height: 48.0,
                onPressed: _onSubmitted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
