import 'package:flutter/material.dart';
import 'package:manajemen_aset/models/realtime_energy.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SfChart extends StatelessWidget {
  const SfChart({
    Key? key,
    required TooltipBehavior? tooltipBehavior,
    required ZoomPanBehavior zoomPanBehavior,
    required TrackballBehavior trackballBehavior,
    required List<RealtimeEnergy> dataReal,
  })  : _tooltipBehavior = tooltipBehavior,
        _zoomPanBehavior = zoomPanBehavior,
        _trackballBehavior = trackballBehavior,
        _dataReal = dataReal,
        super(key: key);

  final TooltipBehavior? _tooltipBehavior;
  final ZoomPanBehavior _zoomPanBehavior;
  final TrackballBehavior _trackballBehavior;
  final List<RealtimeEnergy> _dataReal;

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
        visibleMinimum: ((_dataReal.length <= 30)
            ? 0
            : ((_dataReal.length).toDouble() - 20)),
        visibleMaximum: ((_dataReal.length - 1).toDouble()),
      ),
      series: <ChartSeries<dynamic, dynamic>>[
        SplineSeries<RealtimeEnergy, dynamic>(
          name: 'Power PLTB (W)',
          dataSource: _dataReal,
          enableTooltip: true,
          color: const Color.fromARGB(255, 248, 56, 56),
          xValueMapper: (RealtimeEnergy data, _) => data.dateUtc,
          yValueMapper: (RealtimeEnergy data, _) => data.powerWatt,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<RealtimeEnergy, dynamic>(
          name: 'Wind Speed (m/s)',
          dataSource: _dataReal,
          enableTooltip: true,
          color: const Color.fromARGB(225, 0, 74, 173),
          xValueMapper: (RealtimeEnergy data, _) => data.dateUtc,
          yValueMapper: (RealtimeEnergy data, _) => data.windSpeed,
          yAxisName: 'yAxis',
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.triangle,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<RealtimeEnergy, dynamic>(
          name: 'Power PLTS (W)',
          dataSource: _dataReal,
          enableTooltip: true,
          color: const Color.fromARGB(224, 0, 173, 43),
          xValueMapper: (RealtimeEnergy data, _) => data.dateUtc,
          yValueMapper: (RealtimeEnergy data, _) => data.powerSp,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<RealtimeEnergy, dynamic>(
          name: 'Solar Rad (W/m²)',
          dataSource: _dataReal,
          enableTooltip: true,
          color: const Color.fromARGB(223, 230, 172, 14),
          xValueMapper: (RealtimeEnergy data, _) => data.dateUtc,
          yValueMapper: (RealtimeEnergy data, _) => data.solarRad,
          yAxisName: 'yAxis',
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.triangle,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<RealtimeEnergy, dynamic>(
          name: 'Power PLTD (W)',
          dataSource: _dataReal,
          enableTooltip: true,
          color: const Color.fromARGB(255, 19, 156, 190),
          xValueMapper: (RealtimeEnergy data, _) => data.dateUtc,
          yValueMapper: (RealtimeEnergy data, _) => data.powerDiesel,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
          ),
        ),
        SplineSeries<RealtimeEnergy, dynamic>(
          name: 'BBM (liter)',
          dataSource: _dataReal,
          enableTooltip: true,
          color: const Color.fromARGB(255, 109, 38, 34),
          xValueMapper: (RealtimeEnergy data, _) => data.dateUtc,
          yValueMapper: (RealtimeEnergy data, _) => data.bbm,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 5,
            width: 5,
          ),
        ),
      ],
    );
  }
}
