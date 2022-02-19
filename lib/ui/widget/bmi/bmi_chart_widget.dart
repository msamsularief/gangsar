import 'dart:math';

import 'package:flutter/material.dart';
import 'package:klinik/models/chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BmiChartWidget extends StatelessWidget {
  final List<Chart> items;
  const BmiChartWidget({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildMultiColorLineChart(context);
  }

  ///Get the chart with multi colored line series
  SfCartesianChart _buildMultiColorLineChart(BuildContext context) {
    List<double> numbersIndexKg = [];
    List<double> numbersWeeks = [];
    items.map((e) {
      numbersIndexKg.add(double.parse(e.massIndex));
      numbersWeeks.add(double.parse(e.week));
    }).toList();

    final numberMax = numbersIndexKg.reduce((max));
    final weekMax = numbersWeeks.reduce((max));
    final weekMin = numbersWeeks.reduce((min));

    return SfCartesianChart(
      title: ChartTitle(
        text: 'Grafik Peningkatan Berat Badan'.toUpperCase(),
        textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
            ),
      ),
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
        anchorRangeToVisiblePoints: true,
        majorGridLines: const MajorGridLines(width: 0),
        minimum: weekMin > 0 ? weekMin - 1 : 0,
        maximum: weekMax,
        visibleMaximum: weekMax + 3,
        interval: 1,
        autoScrollingMode: AutoScrollingMode.start,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0.0),
        title: AxisTitle(text: 'Weeks'),
      ),
      primaryYAxis: NumericAxis(
        minimum: -2,
        maximum: numberMax,
        interval: 1,
        visibleMaximum: numberMax + 3,
        axisLine: const AxisLine(width: 0),
        labelFormat: '{value}kg',
        autoScrollingMode: AutoScrollingMode.start,
        enableAutoIntervalOnZooming: true,
        majorGridLines: const MajorGridLines(width: 1.0),
        majorTickLines: const MajorTickLines(size: 2),
      ),
      series: _getMultiColoredLineSeries(),
      trackballBehavior: TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        lineType: TrackballLineType.vertical,
        tooltipSettings: const InteractiveTooltip(format: 'point.x : point.y'),
      ),
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
        enablePinching: true,
        selectionRectBorderWidth: 2,
      ),
      legend: Legend(
        isResponsive: true,
        isVisible: false,
      ),
      crosshairBehavior: CrosshairBehavior(
        activationMode: ActivationMode.singleTap,
        enable: false,
        hideDelay: 2600,
        lineColor: Theme.of(context).primaryColor,
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        header: 'aaa',
        canShowMarker: false,
      ),
    );
  }

  ///Get multi colored line series
  List<LineSeries<ChartData, double>> _getMultiColoredLineSeries() {
    List<ChartData> charts = [];
    items.map((e) {
      Color color;
      ChartData data;
      final toDouble = double.parse(e.massIndex);
      Key key = ValueKey(e.userId);
      if (toDouble < 18.5) {
        color = Color.fromARGB(255, 255, 110, 81);
        data = ChartData(
          double.parse(e.week),
          double.parse(e.massIndex),
          color,
          key,
        );
        charts.add(data);
      } else if (toDouble >= 18.5 && toDouble <= 24.9) {
        color = Color.fromARGB(255, 42, 229, 49);
        data = ChartData(
          double.parse(e.week),
          double.parse(e.massIndex),
          color,
          key,
        );
        charts.add(data);
      } else if (toDouble >= 25.0 && toDouble <= 29.9) {
        color = Color.fromARGB(255, 255, 61, 12);
        data = ChartData(
          double.parse(e.week),
          double.parse(e.massIndex),
          color,
          key,
        );
        charts.add(data);
      } else {
        color = Color.fromARGB(255, 215, 0, 0);
        data = ChartData(
          double.parse(e.week),
          double.parse(e.massIndex),
          color,
          key,
        );
        charts.add(data);
      }
    }).toList();

    return <LineSeries<ChartData, double>>[
      LineSeries<ChartData, double>(
        animationDuration: 2500,

        dataSource: charts,
        xValueMapper: (ChartData chart, _) => chart.x,
        yValueMapper: (ChartData chart, _) => chart.y,

        /// The property used to apply the color each data.
        pointColorMapper: (ChartData chart, _) => chart.lineColor,
        width: 3.6,
      ),
    ];
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.lineColor, Key? key]);
  final double x;
  final double y;
  final Color? lineColor;
}
