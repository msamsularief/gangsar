import 'package:flutter/material.dart';
import 'package:klinik/ui/widget/bmi/bmi_chart_widget.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class BmiHistoryPage extends StatelessWidget {
  const BmiHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KlinikAppBar(
        title: "Riwayat",
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _text(context, "Riwayat index masa tubuh Anda."),
            BmiChartWidget(),
            _buildTable(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTable(BuildContext context) {
    final List<int> chartLines = [for (var i = 1; i <= 4; i++) i];
    final List<String> imtItems = [
      "<18.5",
      "18.5-24.9",
      "25.0-29.9",
      ">30",
    ];
    final List<String> gainWieghtRecommendations = [
      "12.5-18 kg",
      "11.5-16 kg",
      "7-11.5 kg",
      "5-9 kg",
    ];

    final tableSubtitleSymmetricBorderSide = BorderSide(
      color: Colors.black54,
      width: 2.0,
    );
    final tableSubtitleBorderSidefromLRTB = BorderSide(
      color: Colors.black,
      width: 2.0,
    );

    final Map<int, TableColumnWidth> tableColumnWidth = {
      // 0: FractionColumnWidth(.26),
      // 1: FractionColumnWidth(.34),
    };

    final tableRowCellsMargin = EdgeInsets.all(8.0);

    return Column(
      children: [
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
                  child: _text(
                    context,
                    "Tanda",
                    fontSize: 16.0,
                  ),
                ),
                Container(
                  margin: tableRowCellsMargin,
                  child: _text(
                    context,
                    "BB Pra-Kehamilan",
                    fontSize: 16.0,
                  ),
                ),
                Container(
                  margin: tableRowCellsMargin,
                  child: _text(
                    context,
                    "IMT Pra-Kehamilan",
                    fontSize: 16.0,
                  ),
                ),
                Container(
                  margin: tableRowCellsMargin,
                  child: _text(context, "Rekomendasi Peningkatan Berat Badan",
                      fontSize: 16.0),
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
          children: chartLines
              .map(
                (e) => TableRow(
                  children: [
                    Container(
                      margin: tableRowCellsMargin,
                      child: _text(
                        context,
                        "line1",
                        fontSize: 16.0,
                      ),
                    ),
                    Container(
                      margin: tableRowCellsMargin,
                      child: _text(
                        context,
                        " ",
                        fontSize: 16.0,
                      ),
                    ),
                    Container(
                      margin: tableRowCellsMargin,
                      child: _text(
                        context,
                        imtItems[e - 1],
                        fontSize: 16.0,
                      ),
                    ),
                    Container(
                      margin: tableRowCellsMargin,
                      child: _text(
                        context,
                        gainWieghtRecommendations[e - 1],
                        fontSize: 16.0,
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
