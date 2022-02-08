import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BmiChartWidget extends StatelessWidget {
  const BmiChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildMultiColorLineChart(context);
  }

  ///Get the chart with multi colored line series
  SfCartesianChart _buildMultiColorLineChart(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Annual rainfall of Paris'),
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
        anchorRangeToVisiblePoints: true,
        majorGridLines: const MajorGridLines(width: 0),
        minimum: 2,
        maximum: 43,
        visibleMaximum: 43,
        interval: 20,
        autoScrollingMode: AutoScrollingMode.start,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0.0),
        title: AxisTitle(text: 'Weeks'),
      ),
      primaryYAxis: NumericAxis(
        minimum: -2,
        maximum: 27,
        interval: 20,
        visibleMaximum: 27,
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
      enableMultiSelection: true,
      legend: Legend(
        isResponsive: true,
      ),
      crosshairBehavior: CrosshairBehavior(
        activationMode: ActivationMode.singleTap,
        enable: true,
        hideDelay: 2600,
        lineColor: Theme.of(context).primaryColor,
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        header: '',
        canShowMarker: false,
      ),
    );
  }

  ///Get multi colored line series
  List<LineSeries<ChartData, double>> _getMultiColoredLineSeries() {
    return <LineSeries<ChartData, double>>[
      LineSeries<ChartData, double>(
        animationDuration: 2500,
        dataSource: <ChartData>[
          ChartData(1, 19.0, Color(0xFFF8B883)),
          ChartData(2, 20.0, Color(0xFFF8B883)),
          ChartData(3, 20.5, Color(0xFFF8B883)),
          ChartData(4, 18.6, Color(0xFFF8B883)),
          ChartData(5, 20.3, Color(0xFFF8B883)),
          ChartData(6, 14.0, Color(0xFFF8B883)),
          ChartData(7, 21.0, Color(0xFFE56590)),
          ChartData(8, 21.2, Color(0xFFE56590)),
          ChartData(9, 23.4, Color(0xFFE56590)),
          ChartData(10, 21.1, Color(0xFFE56590)),
          ChartData(11, 19.3, Color(0xFFE56590)),
          ChartData(13, 17.2, Color(0xFF357CD2)),
          ChartData(14, 15.0, Color(0xFF357CD2)),
          ChartData(15, 17.0, Color(0xFF357CD2)),
          ChartData(16, 19.0, Color(0xFF357CD2)),
          ChartData(17, 21.0, Color(0xFF357CD2)),
          ChartData(18, 18.9, Color(0xFF00BDAE)),
          ChartData(19, 19.7, Color(0xFF00BDAE)),
          ChartData(20, 20.0, Color(0xFF00BDAE)),
          ChartData(21, 21.0, Color(0xFF00BDAE)),
          ChartData(22, 20.0, Color(0xFF00BDAE))
        ],
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,

        /// The property used to apply the color each data.
        pointColorMapper: (ChartData sales, _) => sales.lineColor,
        width: 2,
      ),
      LineSeries<ChartData, double>(
        animationDuration: 2500,
        dataSource: <ChartData>[
          ChartData(1, 10.0, Color(0xFFF8B883)),
          ChartData(2, 20.0, Color(0xFFF8B883)),
          ChartData(3, 20.5, Color(0xFFF8B883)),
          ChartData(4, 14.6, Color(0xFFF8B883)),
          ChartData(5, 22.3, Color(0xFFF8B883)),
          ChartData(6, 13.0, Color(0xFFF8B883)),
          ChartData(7, 12.0, Color(0xFFE56590)),
          ChartData(8, 21.2, Color(0xFFE56590)),
          ChartData(9, 20.4, Color(0xFFE56590)),
          ChartData(10, 17.1, Color(0xFFE56590)),
          ChartData(11, 16.3, Color(0xFFE56590)),
          ChartData(13, 18.2, Color(0xFF357CD2)),
          ChartData(14, 16.7, Color(0xFF357CD2)),
          ChartData(15, 16.4, Color(0xFF357CD2)),
          ChartData(16, 22.0, Color(0xFF357CD2)),
          ChartData(17, 18.4, Color(0xFF357CD2)),
          ChartData(18, 19.9, Color(0xFF00BDAE)),
          ChartData(19, 22.7, Color(0xFF00BDAE)),
          ChartData(20, 17.0, Color(0xFF00BDAE)),
          ChartData(21, 23.0, Color(0xFF00BDAE)),
          ChartData(22, 22.0, Color(0xFF00BDAE))
        ],
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,

        /// The property used to apply the color each data.
        pointColorMapper: (ChartData sales, _) => sales.lineColor,
        width: 2,
      )
    ];
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.lineColor]);
  final double x;
  final double y;
  final Color? lineColor;
}
