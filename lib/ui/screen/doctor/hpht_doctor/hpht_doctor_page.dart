import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klinik/bloc/account/account.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/helper/date_formatter.dart';
import 'package:klinik/models/account.dart';
import 'package:klinik/models/event.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class HphtDoctorPage extends StatefulWidget {
  final Event item;
  const HphtDoctorPage({Key? key, required this.item}) : super(key: key);

  @override
  _HphtDoctorPageState createState() => _HphtDoctorPageState();
}

class _HphtDoctorPageState extends State<HphtDoctorPage> {
  late Event item;
  bool isChecked = false;
  List<HphtChecker> checkers = [];

  final List<String> chartLines = [
    "Timbang",
    "Ukur Lingkar Lengan Atas",
    "Tekanan Darah",
    "Periksa Tinggi Rahim",
    "Periksa Letak dan Denyut Jantung Janin",
    "Status dan Imunisasi Tetanus",
    "Konseling",
    "Skrining Dokter",
    "Tablet Tambah Darah",
    "Test Lab Hemoglobin (Hb)",
    "Test Golongan Darah",
    "Test Lab Protein Urine",
    "Test Lab Gula Darah",
    "PPIA",
    "Tata Laksana Kasus",
  ];

  @override
  void initState() {
    super.initState();
    item = widget.item;
    chartLines
        .map(
          (e) => checkers.add(
            HphtChecker(false, e),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final Map<int, TableColumnWidth> tableColumnWidth = {
      0: FractionColumnWidth(.24),
      1: FractionColumnWidth(.04),
    };

    Account? account;

    return BuildBodyWidget(
      appBar: KlinikAppBar(
        title: "HPHT",
        centerTitle: true,
      ),
      persistentFooterButtons: [
        CustomButton.defaultButton(
          title: "Simpan",
          titleSize: 18.0,
          titleColor: Colors.white,
          titleFontWeight: FontWeight.bold,
          width: Core.getDefaultAppWidth(context),
          height: 48.0,
          onPressed: () => goBack(true),
        ),
      ],
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: Colors.white,
        child: Column(
          children: [
            // _text(context, "text"),

            Table(
              border: TableBorder.all(
                width: 0.0,
                color: Colors.transparent,
              ),
              columnWidths: tableColumnWidth,
              children: [
                TableRow(
                  children: [
                    _text(context, "Nama"),
                    _text(context, " : "),
                    BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
                        if (state is AccountDetailLoaded) {
                          account = state.account;
                        } else if (state is AccountLoading) {
                          return Container(
                            height: 20.0,
                            width: 20.0,
                            alignment: Alignment.centerLeft,
                            child: CircularProgressIndicator(
                              strokeWidth: 0.4,
                            ),
                          );
                        }

                        if (account != null) {
                          return _text(context, account!.fullName);
                        } else {
                          return _text(context, item.title);
                        }
                      },
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    _text(context, "Tanggal"),
                    _text(context, " : "),
                    _text(
                      context,
                      item.subtitle.todMMMMy(),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    _text(context, "Tempat"),
                    _text(context, " : "),
                    _text(context, " - "),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 32.0,
            ),
            _buildTable(context),
          ],
        ),
      ),
    );
  }

  ///Build untuk menampilkan `Tabel` keterangan `Index Masa Tubuh`, baik itu
  ///sudah ideal, kurang atau over.
  Widget _buildTable(BuildContext context) {
    final tableSubtitleSymmetricBorderSide = BorderSide(
      color: Colors.black54,
      width: 1.0,
    );
    final tableSubtitleBorderSidefromLRTB = BorderSide(
      color: Colors.black,
      width: 1.0,
    );

    final Map<int, TableColumnWidth> tableColumnWidth = {
      0: FractionColumnWidth(.40),
      // 1: FractionColumnWidth(.34),
    };

    final tableRowCellsMargin = EdgeInsets.all(8.0);

    print(checkers //check apakah checker berhasil.
        .map(
          (e) => e.isChecked,
        )
        .toList(
          growable: false,
        ));

    return Column(
      children: [
        Table(
          border: TableBorder.all(
            color: Colors.black,
            width: 1.0,
          ),
          columnWidths: tableColumnWidth,
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.06),
              ),
              children: [
                Container(
                  margin: tableRowCellsMargin,
                  child: _text(
                    context,
                    "HPHT",
                    fontSize: 16.0,
                  ),
                ),
                Container(
                  margin: tableRowCellsMargin,
                  child: Column(
                    children: [
                      _text(
                        context,
                        "Trimester 1",
                        fontSize: 16.0,
                      ),
                      _text(
                        context,
                        "Periksa",
                        fontSize: 16.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Table(
          columnWidths: tableColumnWidth,
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          border: TableBorder(
            verticalInside: tableSubtitleSymmetricBorderSide,
            horizontalInside: tableSubtitleSymmetricBorderSide,
            right: tableSubtitleBorderSidefromLRTB,
            left: tableSubtitleBorderSidefromLRTB,
            bottom: tableSubtitleBorderSidefromLRTB,
          ),
          children: checkers
              .map(
                (e) => TableRow(
                  key: ValueKey(e),
                  children: [
                    Container(
                      height: 32.0,
                      margin: tableRowCellsMargin,
                      child: _text(
                        context,
                        e.value,
                        fontSize: 16.0,
                      ),
                    ),
                    Container(
                      margin: tableRowCellsMargin,
                      child: Checkbox(
                        value: e.isChecked,
                        checkColor:
                            e.isChecked ? Color(0xFFFFFFFF) : Colors.grey,
                        onChanged: (onChanged) {
                          setState(() {
                            e.isChecked = !e.isChecked;
                            print(checkers[checkers.indexOf(e)].isChecked);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _text(
    BuildContext context,
    String? text, {
    double? fontSize,
  }) =>
      Text(
        "$text",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: fontSize ?? 18.0,
          color: Theme.of(context).textTheme.bodyText1!.color,
        ),
      );
}

///model untuk `checkbox` menu **[HPHT]**
class HphtChecker {
  late bool isChecked;
  final String value;

  HphtChecker(this.isChecked, this.value);
}
