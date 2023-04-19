import 'package:flutter/material.dart';
import 'package:manajemen_aset/models/solar_panel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SfChartSp extends StatelessWidget {
  const SfChartSp({
    Key? key,
    required TooltipBehavior? tooltipBehavior,
    required ZoomPanBehavior zoomPanBehavior,
    required TrackballBehavior trackballBehavior,
    required List<SpData> dataSp,
  })  : _tooltipBehavior = tooltipBehavior,
        _zoomPanBehavior = zoomPanBehavior,
        _trackballBehavior = trackballBehavior,
        _dataSp = dataSp,
        super(key: key);

  final TooltipBehavior? _tooltipBehavior;
  final ZoomPanBehavior _zoomPanBehavior;
  final TrackballBehavior _trackballBehavior;
  final List<SpData> _dataSp;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
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
      axes: <ChartAxis>[
        NumericAxis(
          name: 'yAxis',
          // title: AxisTitle(
          //   text: 'm/s',
          //   textStyle: const TextStyle(fontSize: 12),
          // ),
          opposedPosition: true,
          interval: 5,
        )
      ],
      primaryXAxis: CategoryAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        interval: 10,
        zoomFactor: 0.95,
        visibleMinimum:
            ((_dataSp.length <= 30) ? 0 : ((_dataSp.length).toDouble() - 20)),
        visibleMaximum: ((_dataSp.length - 1).toDouble()),
      ),
      series: <ChartSeries<SpData, dynamic>>[
        SplineSeries<SpData, dynamic>(
          name: 'Solar Rad',
          dataSource: _dataSp,
          enableTooltip: true,
          color: const Color.fromARGB(255, 153, 16, 187),
          xValueMapper: (SpData data, _) => data.dateTime,
          yValueMapper: (SpData data, _) => data.solarRad,
          yAxisName: 'yAxis',
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.triangle,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<SpData, dynamic>(
          name: 'Power (W)',
          dataSource: _dataSp,
          enableTooltip: true,
          color: const Color.fromARGB(255, 248, 56, 56),
          xValueMapper: (SpData data, _) => data.dateTime,
          yValueMapper: (SpData data, _) => data.power,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<SpData, dynamic>(
          name: 'Tegangan (V)',
          dataSource: _dataSp,
          enableTooltip: true,
          color: const Color.fromARGB(223, 255, 136, 0),
          xValueMapper: (SpData data, _) => data.dateTime,
          yValueMapper: (SpData data, _) => data.volt,
          yAxisName: 'yAxis',
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.triangle,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<SpData, dynamic>(
          name: 'Arus (A)',
          dataSource: _dataSp,
          enableTooltip: true,
          color: const Color.fromARGB(223, 0, 110, 255),
          xValueMapper: (SpData data, _) => data.dateTime,
          yValueMapper: (SpData data, _) => data.ampere,
          yAxisName: 'yAxis',
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.triangle,
            height: 5,
            width: 5,
          ),
        ),
      ],
    );
  }
}
