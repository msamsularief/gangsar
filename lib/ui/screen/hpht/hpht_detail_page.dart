import 'package:flutter/material.dart';
import 'package:klinik/helper/color_helper.dart';
import 'package:klinik/helper/date_formatter.dart';
import 'package:klinik/ui/widget/card_widget.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class HphtDetailPage extends StatelessWidget {
  final int inDays;
  final DateTime date;
  const HphtDetailPage({Key? key, required this.inDays, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<DateTime> suburDates = [];
    final initHaid = DateTime(date.year, date.month, date.day);

    final lastHaid = DateTime(
      initHaid.year,
      initHaid.month,
      initHaid.day + 6,
    );

    final haidExpectationDay = DateTime(
      lastHaid.year,
      lastHaid.month,
      lastHaid.day + 21,
    );

    final lastHaidExpectDay = DateTime(
      haidExpectationDay.year,
      haidExpectationDay.month,
      haidExpectationDay.day + 6,
    );

    print(haidExpectationDay.toString().todMMMMy());

    final lastMonthHaid = DateTime(
      initHaid.year,
      initHaid.month,
      initHaid.day - 20,
    );

    final initMasaSubur = haidExpectationDay.add(Duration(days: -5));

    print(initMasaSubur.toString().todMMMMy());

    final lastMasaSubur = DateTime(
      initMasaSubur.year,
      initMasaSubur.month,
      initMasaSubur.day + 4,
    );

    final Map<int, TableColumnWidth> tableColumnWidth = {
      0: FractionColumnWidth(.30),
      1: FractionColumnWidth(.04),
    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: KlinikAppBar(
        title: "Kalender Kesuburan",
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Table(
              border: TableBorder.all(
                width: 0.0,
                color: Colors.transparent,
              ),
              columnWidths: tableColumnWidth,
              children: [
                TableRow(
                  children: [
                    _text("Haid Bulan Lalu"),
                    _text(" : "),
                    _text(
                      lastMonthHaid.toString().towdMMMMy(),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    _text("Haid Terakhir"),
                    _text(" : "),
                    _text(
                      initHaid.toString().towdMMMMy(),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    _text("Lama Haid"),
                    _text(" : "),
                    _text(
                      "$inDays ${inDays == 1 && inDays != 0 ? "Day" : "Days"}",
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 24.0,
            ),
            GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              children: [
                cardWidget(
                  backgroundColor: Colors.blue.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _sizedBox(
                        height: 8.0,
                      ),
                      _text(
                        "Masa Subur :",
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                      Divider(
                        height: 16.0,
                        thickness: 2.0,
                        color: Colors.white,
                      ),
                      _text(
                        initMasaSubur.toString().toMMMM(),
                        fontSize: 40.0,
                        textHeight: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                      _text(
                        "${initMasaSubur.toString().toD()}"
                        "-"
                        "${lastMasaSubur.toString().toD()}",
                        fontSize: 56.0,
                        fontWeight: FontWeight.w900,
                        textHeight: 1.2,
                      ),
                    ],
                  ),
                ),
                cardWidget(
                  backgroundColor: Colors.orange.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _sizedBox(
                        height: 8.0,
                      ),
                      _text(
                        "Haid Selanjutnya :",
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                      Divider(
                        height: 16.0,
                        thickness: 2.0,
                        color: Colors.white,
                      ),
                      _text(
                        " ${haidExpectationDay.toString().toMMMM()} ",
                        fontSize: 40.0,
                        textHeight: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                      _text(
                        "${haidExpectationDay.toString().toD()}"
                        "-"
                        "${lastHaidExpectDay.toString().toD()}",
                        fontSize: 56.0,
                        fontWeight: FontWeight.w900,
                        textHeight: 1.2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _text(
    String? text, {
    TextAlign? textAlign,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? textHeight,
  }) =>
      Text(
        "$text",
        textAlign: textAlign ?? TextAlign.left,
        style: TextStyle(
          color: color ?? ColorHelper.fromHex("#240B1D"),
          fontSize: fontSize ?? 18.0,
          fontWeight: fontWeight ?? FontWeight.normal,
          height: textHeight ?? 1.5,
        ),
      );

  Widget _sizedBox({double? height}) => SizedBox(
        height: height ?? 20.0,
      );
}
