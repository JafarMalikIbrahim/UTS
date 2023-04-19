class Sensor {
  int? id;
  String? spd41;
  String? spd42;
  String? spd43;
  String? spd44;
  String? spd45;
  String? lokasi;
  String? tglPasang;
  Sensor({
    this.id,
    this.spd41,
    this.spd42,
    this.spd43,
    this.spd44,
    this.spd45,
    this.lokasi,
    this.tglPasang,
  });
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['spd41'] = spd41;
    map['spd42'] = spd42;
    map['spd43'] = spd43;
    map['spd44'] = spd44;
    map['spd45'] = spd45;
    map['lokasi'] = lokasi;
    map['tglPasang'] = tglPasang;

    return map;
  }

  Sensor.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    spd41 = map['spd41'];
    spd42 = map['spd42'];
    spd43 = map['spd43'];
    spd44 = map['spd44'];
    spd45 = map['spd45'];
    lokasi = map['lokasi'];
    tglPasang = map['tglPasang'];
  }
}
