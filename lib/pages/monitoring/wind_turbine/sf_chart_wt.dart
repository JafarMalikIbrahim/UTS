import 'package:flutter/material.dart';
import 'package:manajemen_aset/models/wind_turbine.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SfChartWt extends StatelessWidget {
  const SfChartWt({
    Key? key,
    required TooltipBehavior? tooltipBehavior,
    required ZoomPanBehavior zoomPanBehavior,
    required TrackballBehavior trackballBehavior,
    required List<WtData> dataWt,
  })  : _tooltipBehavior = tooltipBehavior,
        _zoomPanBehavior = zoomPanBehavior,
        _trackballBehavior = trackballBehavior,
        _dataWt = dataWt,
        super(key: key);

  final TooltipBehavior? _tooltipBehavior;
  final ZoomPanBehavior _zoomPanBehavior;
  final TrackballBehavior _trackballBehavior;
  final List<WtData> _dataWt;

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
            ((_dataWt.length <= 30) ? 0 : ((_dataWt.length).toDouble() - 20)),
        visibleMaximum: ((_dataWt.length - 1).toDouble()),
      ),
      series: <ChartSeries<WtData, dynamic>>[
        SplineSeries<WtData, dynamic>(
          name: 'Wind Speed (m/s)',
          dataSource: _dataWt,
          enableTooltip: true,
          color: const Color.fromARGB(225, 0, 74, 173),
          xValueMapper: (WtData data, _) => data.dateUtc,
          yValueMapper: (WtData data, _) => data.windSpeed,
          yAxisName: 'yAxis',
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.triangle,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<WtData, dynamic>(
          name: 'Rpm Bilah',
          dataSource: _dataWt,
          enableTooltip: true,
          color: const Color.fromARGB(224, 190, 27, 223),
          xValueMapper: (WtData data, _) => data.dateUtc,
          yValueMapper: (WtData data, _) => data.rpmBilah,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<WtData, dynamic>(
          name: 'Rpm Generator',
          dataSource: _dataWt,
          enableTooltip: true,
          color: const Color.fromARGB(255, 27, 223, 102),
          xValueMapper: (WtData data, _) => data.dateUtc,
          yValueMapper: (WtData data, _) => data.rpmGenerator,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<WtData, dynamic>(
          name: 'Power (W)',
          dataSource: _dataWt,
          enableTooltip: true,
          color: const Color.fromARGB(255, 248, 56, 56),
          xValueMapper: (WtData data, _) => data.dateUtc,
          yValueMapper: (WtData data, _) => data.powerWatt,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<WtData, dynamic>(
          name: 'Tegangan (V)',
          dataSource: _dataWt,
          enableTooltip: true,
          color: const Color.fromARGB(223, 255, 136, 0),
          xValueMapper: (WtData data, _) => data.dateUtc,
          yValueMapper: (WtData data, _) => data.voltDc,
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.triangle,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<WtData, dynamic>(
          name: 'Arus (A)',
          dataSource: _dataWt,
          enableTooltip: true,
          color: const Color.fromARGB(223, 0, 110, 255),
          xValueMapper: (WtData data, _) => data.dateUtc,
          yValueMapper: (WtData data, _) => data.ampereDc,
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