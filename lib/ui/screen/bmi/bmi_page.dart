import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klinik/bloc/chart/chart.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/models/chart.dart';
import 'package:klinik/ui/screen/bmi/bmi_view.dart';
import 'package:klinik/ui/widget/bmi/bmi_chart_widget.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/custom_form_field.dart';
import 'package:klinik/ui/widget/error_page_widget.dart';
import 'package:klinik/ui/widget/form_focus_node.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';
import 'package:klinik/ui/widget/loading_widget.dart';

class BmiPage extends StatefulWidget {
  final String userId;
  const BmiPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  final String titlePage = "Index Masa Tubuh";
  final TextEditingController _bbController = TextEditingController();
  final TextEditingController _tbController = TextEditingController();
  late FocusNode _bbFocus;
  late FocusNode _tbFocus;

  late DateTime currentDate;

  bool textIsEmpty = false;
  bool isCreateAgain = false;
  bool showPresistentButton = false;

  int incrementWeeks = 2;

  String? errorMessage = "";
  String? bmiMessage;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    _bbFocus = FocusNode();
    _tbFocus = FocusNode();
  }

  @override
  void dispose() {
    _bbFocus.dispose();
    _tbFocus.dispose();
    _bbController.dispose();
    _tbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Chart> items = [];
    DateTime? nextInputDate;

    final chartBloc = BlocProvider.of<ChartBloc>(context);
    void _handleClick(String value) {
      switch (value) {
        case 'History':
          navigateTo("/bmi_history");
          break;
      }
    }

    return BlocListener<ChartBloc, ChartState>(
      listener: (context, state) {
        if (state is ChartListLoaded) {
          items = state.items!;
          bmiMessage = items.last.massIndex;
          isCreateAgain = false;
          showPresistentButton = true;
        }
        if (state is ChartListFailure) {
          bmiMessage = null;
          isCreateAgain = true;
          showPresistentButton = false;
          // return ErrorPageWidget(
          //   title: titlePage,
          //   message: state.message!,
          //   subMessage: 'Mulai hitung untuk menambahkan data Anda.',
          //   child: CustomButton.defaultButton(
          //     title: "Hitung Index Masa Tubuh",
          //     titleSize: 18.0,
          //     titleColor: Colors.white,
          //     buttonDefaultColor: Theme.of(context).primaryColor,
          //     titleFontWeight: FontWeight.bold,
          //     width: Core.getDefaultAppWidth(context),
          //     height: 48.0,
          //     onPressed: () => setState(() {
          //       bmiMessage = null;
          //       _bbController.clear();
          //       _tbController.clear();
          //     }),
          //   ),
          // );
        }
      },
      child: BlocBuilder<ChartBloc, ChartState>(
        builder: (context, state) {
          if (state is ChartListLoading) {
            return LoadingWidget(title: titlePage);
          }

          return BuildBodyWidget(
            appBar: KlinikAppBar(
              title: titlePage,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: PopupMenuButton(
                    onSelected: _handleClick,
                    icon: Icon(
                      Icons.more_vert_rounded,
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
            persistentFooterButtons: showPresistentButton == true
                ? [
                    Container(
                      margin: EdgeInsets.only(top: 24.0, bottom: 24.0),
                      width: Core.getDefaultAppWidth(context),
                      child: CustomButton.defaultButton(
                        title: "Hitung Ulang",
                        titleSize: 18.0,
                        titleColor: Colors.white,
                        buttonDefaultColor: Theme.of(context).primaryColor,
                        titleFontWeight: FontWeight.bold,
                        width: Core.getDefaultAppWidth(context),
                        height: 48.0,
                        onPressed: () => setState(() {
                          bmiMessage = null;
                          showPresistentButton = false;
                          isCreateAgain = true;
                          _bbController.clear();
                          _tbController.clear();
                        }),
                      ),
                    ),
                  ]
                : null,
            body: isCreateAgain == false && items.isNotEmpty
                ? BmiView(chartBloc: chartBloc, items: items)
                : BlocBuilder<ChartBloc, ChartState>(
                    builder: (context, state) {
                      if (state is ChartListLoaded) {
                        items = state.items!;
                      } else if (state is ChartListFailure) {
                        items = [];
                      }
                      return _buildBody(context, chartBloc, items);
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget _buildBody(
      BuildContext context, ChartBloc chartBloc, List<Chart> items) {
    print("ITEM LENGTH : ${items.length}");

    ///ADD DATA TO SERVER
    void _addData() async {
      DateTime currentDate = DateTime.now();

      chartBloc.add(
        CreateChart(
          widget.userId,
          bmiMessage!,
          currentDate.toString(),
          items.isNotEmpty
              ? "${int.parse(items.last.week) + 1}"
              : "${items.length + 1}",
        ),
      );
      chartBloc.add(LoadChartList(widget.userId));
    }

    ///Untuk submit dan menghitung Index Masa Tubuh.
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

            print(
                "\n\n\nBMI Anda adalah : ${bmi.toStringAsPrecision(4)}\n\n\n");

            bmiMessage = bmi.toStringAsPrecision(4);
            _addData();
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
              width: Core.getDefaultAppWidth(context) / 2.6,
              child: CustomFormField(
                controller: _bbController,
                focusNode: _bbFocus,
                hintText: "masukkan berat badan anda",
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
              width: Core.getDefaultAppWidth(context) / 2.6,
              child: CustomFormField(
                controller: _tbController,
                focusNode: _tbFocus,
                hintText: "masukkan tinggi badan anda",
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
              width: Core.getDefaultAppWidth(context),
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
