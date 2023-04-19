import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class datetime extends StatefulWidget {
  const datetime({Key? key}) : super(key: key);

  @override
  State<datetime> createState() => _datetimeState();
}

class _datetimeState extends State<datetime> {
  TooltipBehavior? _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.longPress,
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
    );
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enableDoubleTapZooming: true,
      enablePanning: true,
      zoomMode: ZoomMode.x,
    );
  }

  List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: DateTime(2015, 1, 1, 0), yValue: 1.13),
    ChartSampleData(x: DateTime(2015, 1, 2, 2, 10), yValue: 1.12),
    ChartSampleData(x: DateTime(2015, 1, 3, 2, 50), yValue: 1.08),
    ChartSampleData(x: DateTime(2015, 1, 4, 3, 20), yValue: 1.12),
    ChartSampleData(x: DateTime(2015, 1, 5, 3, 55), yValue: 1.1),
    ChartSampleData(x: DateTime(2015, 1, 6, 6, 10), yValue: 1.12),
    ChartSampleData(x: DateTime(2015, 1, 7, 6, 40), yValue: 1.1),
    ChartSampleData(x: DateTime(2015, 1, 8, 7, 27), yValue: 1.12),
    ChartSampleData(x: DateTime(2015, 1, 9, 7, 10), yValue: 1.16),
    ChartSampleData(x: DateTime(2015, 1, 10, 8, 20), yValue: 1.1),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: Center(
          //Initialize the chart widget
          child: Container(
              height: 500,
              width: 320,
              child: SfCartesianChart(
                  tooltipBehavior: _tooltipBehavior,
                  zoomPanBehavior: _zoomPanBehavior,
                  trackballBehavior: _trackballBehavior,
                  legend: Legend(
                    isVisible: true,
                    height: '50%',
                    width: '100%',
                    position: LegendPosition.bottom,
                    overflowMode: LegendItemOverflowMode.wrap,
                  ),
                  backgroundColor: Colors.white,
                  //Specifying date time interval type as hours
                  primaryXAxis: DateTimeAxis(
                      majorGridLines: MajorGridLines(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      intervalType: DateTimeIntervalType.minutes),
                  series: <ChartSeries<ChartSampleData, DateTime>>[
                    LineSeries<ChartSampleData, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (ChartSampleData sales, _) => sales.x,
                      yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                      name: 'Sales',
                    )
                  ])),
        ));
  }
}

class ChartSampleData {
  ChartSampleData({this.x, this.yValue});

  final DateTime? x;
  final double? yValue;
}
