import 'package:flutter/material.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KlinikAppBar(
        title: "History",
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final List<int> items = [5, 4, 3, 2, 1];
    final tableSubtitleSymmetricBorderSide = BorderSide(
      color: Colors.black54,
      width: 2.0,
    );
    final tableSubtitleBorderSidefromLRTB = BorderSide(
      color: Colors.black,
      width: 2.0,
    );

    final Map<int, TableColumnWidth> tableColumnWidth = {
      0: FractionColumnWidth(.26),
      1: FractionColumnWidth(.34),
    };

    final tableRowCellsMargin = EdgeInsets.all(8.0);

    return Container(
      height: Core.getDefaultBodyHeight(context),
      width: Core.getDefaultAppWidth(context),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _text(
              "Data Pasien",
              textSize: 20.0,
            ),
            Divider(
              height: 4.0,
              color: Colors.black26,
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Column(
                children: items.map(
                  (e) {
                    int index = items.indexOf(e);

                    String? text = "";
                    String? subText = "";

                    if (index == 0) {
                      text = "Nama Pasien";
                      subText = "Ibu Gangsar";
                    } else if (index == 1) {
                      text = "Nomor Rekam Medis";
                      subText = "000.000000.0000";
                    }

                    return Container(
                      margin: EdgeInsets.only(
                        bottom: index == items.last ? 0.0 : 4.0,
                      ),
                      child: text.isNotEmpty
                          ? _rowWidget(
                              title: text,
                              description: subText,
                            )
                          : null,
                    );
                  },
                ).toList(),
              ),
            ),
            Divider(
              height: 4.0,
              color: Colors.black26,
            ),
            _sizedBox(16.0),
            _text(
              "Riwayat Checkup",
              textSize: 20.0,
            ),
            _sizedBox(8.0),
            Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 2.0,
              ),
              columnWidths: tableColumnWidth,
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    Container(
                      margin: tableRowCellsMargin,
                      child: _text("Tanggal"),
                    ),
                    Container(
                      margin: tableRowCellsMargin,
                      child: _text("Poli"),
                    ),
                    Container(
                      margin: tableRowCellsMargin,
                      child: _text("Dokter"),
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
              children: items
                  .map(
                    (e) => TableRow(
                      children: [
                        Container(
                          margin: tableRowCellsMargin,
                          child: _text("18 Januari 2022"),
                        ),
                        Container(
                          margin: tableRowCellsMargin,
                          child: _text("Anak dan Kandungan"),
                        ),
                        Container(
                          margin: tableRowCellsMargin,
                          child: _text("dr. Siska Ernawati Sp.A, Sp.OG"),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowWidget({
    required String? title,
    required String? description,
  }) =>
      Row(
        children: [
          Expanded(
            flex: 3,
            child: _text(title ?? "Nomor Rekam Medis"),
          ),
          _text(" :  "),
          Expanded(
            flex: 7,
            child: _text(description ?? "000.000000.0000"),
          ),
        ],
      );

  Widget _text(
    String? text, {
    double? textSize = 16.0,
  }) =>
      Text(
        "$text",
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(
          color: Colors.black,
          fontSize: textSize,
        ),
      );

  _sizedBox(double? height) => SizedBox(
        height: height,
      );
}
