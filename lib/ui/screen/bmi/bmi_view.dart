import 'package:flutter/material.dart';
import 'package:klinik/bloc/chart/chart_bloc.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/models/chart.dart';
import 'package:klinik/ui/widget/bmi/bmi_chart_widget.dart';

///Build untuk tampilan setelah ada data `Index Masa Tubuh ( IMT )`nya.
///ini menampilkan :
/// - Informasi `IMT` terakhir dari pengguna
/// - Informasi Chart dari semua riwayat awal perhitungan `IMT` hingga minggu terakhir (42 minggu)
/// - Informasi Table indikasi perhitungan `IMT`
class BmiView extends StatelessWidget {
  final ChartBloc chartBloc;
  final List<Chart> items;
  const BmiView({Key? key, required this.chartBloc, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCard(
          child: SizedBox(
            width: Core.getDefaultAppWidth(context),
            child: Column(
              children: [
                Text(
                  "Index masa tubuh terakhir Anda adalah :",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  items.last.massIndex,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        ),
        _buildCard(
          child: Column(
            children: [
              BmiChartWidget(
                items: items,
              ),
              SizedBox(
                height: 16.0,
              ),
              _buildTable(context),
            ],
          ),
          margin: EdgeInsets.only(top: 20.0),
          topPadding: 24.0,
        ),
      ],
    );
  }

  ///Build untuk menampilkan `Tabel` keterangan `Index Masa Tubuh`, baik itu
  ///sudah ideal, kurang atau over.
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
      width: 1.0,
    );
    final tableSubtitleBorderSidefromLRTB = BorderSide(
      color: Colors.black,
      width: 1.0,
    );

    final Map<int, TableColumnWidth> tableColumnWidth = {
      0: FractionColumnWidth(.12),
      // 1: FractionColumnWidth(.34),
    };

    final tableRowCellsMargin = EdgeInsets.all(8.0);

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

  ///Untuk membuild `Base Card` agar tampilan lebih tertata.
  Widget _buildCard(
          {required Widget? child,
          EdgeInsetsGeometry? margin,
          double? topPadding}) =>
      Container(
        margin: margin,
        padding: EdgeInsets.fromLTRB(
          20.0,
          topPadding ?? 40.0,
          20.0,
          20.0,
        ),
        decoration: BoxDecoration(
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
        child: child,
      );

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
