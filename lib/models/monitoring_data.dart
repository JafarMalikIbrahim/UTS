// To parse this JSON data, do
//
//     final monitoringData = monitoringDataFromJson(jsonString);
import 'dart:convert';

MonitoringData? monitoringDataFromJson(String str) =>
    MonitoringData.fromJson(json.decode(str));

String monitoringDataToJson(MonitoringData? data) =>
    json.encode(data!.toJson());

class MonitoringData {
  MonitoringData({
    this.id,
    this.realData,
    this.calcData,
    this.nextDate,
    this.draw,
  });

  String? id;
  List<Datum?>? realData;
  List<Datum?>? calcData;
  DateTime? nextDate;
  String? draw;

  factory MonitoringData.fromJson(Map<String, dynamic>? json) => MonitoringData(
        id: json?["id"],
        realData: List<Datum?>.from(
          json?["real_data"]!.map(
            (x) => Datum.fromJson(x),
          ),
        ),
        calcData: List<Datum?>.from(
          json?["calc_data"]!.map(
            (x) => Datum.fromJson(x),
          ),
        ),
        nextDate: DateTime.parse(json?["next_date"]),
        draw: json?["draw"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "real_data": realData == null
            ? []
            : List<dynamic>.from(realData!.map((x) => x!.toJson())),
        "calc_data": calcData == null
            ? []
            : List<dynamic>.from(calcData!.map((x) => x!.toJson())),
        "next_date": nextDate!.toIso8601String(),
        "draw": draw,
      };
}

class Datum {
  Datum({
    this.date,
    this.value,
  });

  DateTime? date;
  double? value;

  factory Datum.fromJson(Map<String, dynamic>? json) => Datum(
        date: DateTime.parse(json?["date"]),
        value: json?["value"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "value": value,
      };
}
