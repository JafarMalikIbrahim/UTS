// model
class DataModel {
  String? day;
  List<KwhProd>? kwhProd;

  DataModel({this.day, this.kwhProd});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      day: json['day'],
      kwhProd: List<KwhProd>.from(
        json['kwh_prod'].map(
          (kwhProdJson) => KwhProd.fromJson(kwhProdJson),
        ),
      ),
    );
  }
}

class KwhProd {
  String? name;
  double? prodKwh;
  double? powerWatt;

  KwhProd({this.name, this.prodKwh, this.powerWatt});

  factory KwhProd.fromJson(Map<String, dynamic> json) {
    String name = '';
    switch (json['device_name']) {
      case 'Wind Turbine':
        name = 'PLTB';
        break;
      case 'Solar Panel':
        name = 'PLTS';
        break;
      case 'Generator Diesel':
        name = 'PLTD';
        break;
      default:
        name = '';
    }
    return KwhProd(
      name: name,
      prodKwh: json['prod_kwh']?.toDouble() ?? 0,
      powerWatt: json['power_Watt']?.toDouble() ?? 0,
    );
  }
  String getImageAsset() {
    if (name == 'PLTB') {
      return 'img/pltb.png';
    } else if (name == 'PLTS') {
      return 'img/plts.png';
    } else if (name == 'PLTD') {
      return 'img/pltd.png';
    }
    return "";
  }
}
