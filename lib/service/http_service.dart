import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:manajemen_aset/models/monitoring_data.dart';

class HttpService {
  String url = 'https://ebt-polinema.id/api/wind-turbine/status';

  Future<MonitoringData> getRealData(String id, DateTime date, String draw) async {
    final http.Response res = await http.post(
      Uri.parse(url),
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'real_data': [
          {'date': date}
        ],
        'calc_data': [
          {'date': date}
        ],
        'draw': draw
      }),
    );
    if (res.statusCode == 200){
      final data = MonitoringData.fromJson(jsonDecode(res.body));
      return data;
    }else{
      throw Exception('Failed to get data.');
    }
    // var dataHasil = json.decode(res.body);
    // return MonitoringData(
    //   id: dataHasil["id"],
    //   realData: List,
    //   nextDate: null,
    //   draw: dataHasil["draw"]
    // );
    // if (res.statusCode == 200) {
    //   final jsonRes = json.decode(res.body);
    //   final dataMap = jsonRes['res'];
    //   List data = dataMap.map((i) => MonitoringData.fromJson(i)).toList();
    //   print(data);
    //   return data;
    // } else {
    //   throw Exception('Failed to get data.');
    // }
  }
}
