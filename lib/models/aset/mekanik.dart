class Mekanik {
  int? id;
  String? spd11;
  String? spd12;
  String? spd13;
  String? spd14;
  String? spd15;
  String? lokasi;
  String? tglPasang;
  Mekanik({
    this.id,
    this.spd11,
    this.spd12,
    this.spd13,
    this.spd14,
    this.spd15,
    this.lokasi,
    this.tglPasang,
  });
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['spd11'] = spd11;
    map['spd12'] = spd12;
    map['spd13'] = spd13;
    map['spd14'] = spd14;
    map['spd15'] = spd15;
    map['lokasi'] = lokasi;
    map['tglPasang'] = tglPasang;

    return map;
  }

  Mekanik.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    spd11 = map['spd11'];
    spd12 = map['spd12'];
    spd13 = map['spd13'];
    spd14 = map['spd14'];
    spd15 = map['spd15'];
    lokasi = map['lokasi'];
    tglPasang = map['tglPasang'];
  }
}
