import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klinik/bloc/account/account.dart';
import 'package:klinik/helper/date_formatter.dart';
import 'package:klinik/models/account.dart';
import 'package:klinik/models/history.dart';
import 'package:klinik/models/hpht_checker.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class HistoryPreviewPage extends StatelessWidget {
  final History item;
  const HistoryPreviewPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<int, TableColumnWidth> tableColumnWidth = {
      0: FractionColumnWidth(.28),
      1: FractionColumnWidth(.04),
    };

    Account? account;

    return BuildBodyWidget(
      appBar: KlinikAppBar(
        title: "Riwayat Pemeriksaan",
        centerTitle: true,
      ),
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
                    _text(context, "Nama Pasien"),
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
                          return _text(context, "-");
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
                      item.timestamp.todMMMMy(),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    _text(context, "Jenis"),
                    _text(context, " : "),
                    _text(
                      context,
                      item.description,
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

    final List<HphtChecker> checkers = [];

    for (int i = 0; i < chartLines.length; i++) {
      if (i == 4 || i == 5 || i == 7) {
        checkers.add(
          HphtChecker(
            i.toString(),
            chartLines[i],
            true,
          ),
        );
      } else {
        checkers.add(
          HphtChecker(
            i.toString(),
            chartLines[i],
            false,
          ),
        );
      }
    }

    // chartLines.map((e) {
    //   int index = chartLines.indexOf(e);
    //   if (index == 4 && index == 5 && index == 7) {
    //     checkers.add(
    //       HphtChecker(
    //         chartLines.indexOf(e).toString(),
    //         e,
    //         true,
    //       ),
    //     );
    //   } else {
    //     checkers.add(
    //       HphtChecker(
    //         chartLines.indexOf(e).toString(),
    //         e,
    //         false,
    //       ),
    //     );
    //   }
    // }).toList(
    //   growable: false,
    // );

    // checkers.map((e) {
    //   final value = [e.copy(isChecked: true)];
    //   checkers.replaceRange(checkers.indexOf(e), checkers.indexOf(e), value);
    //   checkers.removeAt(checkers.indexOf(e));
    // }).toList();

    final tableSubtitleSymmetricBorderSide = BorderSide(
      color: Colors.black54,
      width: 1.0,
    );
    final tableSubtitleBorderSidefromLRTB = BorderSide(
      color: Colors.black,
      width: 1.0,
    );

    final Map<int, TableColumnWidth> tableColumnWidth = {
      0: FractionColumnWidth(.70),
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
                        e.title,
                        fontSize: 16.0,
                      ),
                    ),
                    Container(
                      margin: tableRowCellsMargin,
                      child: Icon(
                        e.isChecked
                            ? Icons.check_box_rounded
                            : Icons.check_box_outline_blank_rounded,
                        size: 24.0,
                        color: e.isChecked
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
              .toList(growable: false),
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
