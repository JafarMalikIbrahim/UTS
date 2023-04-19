class Sipil {
  int? id;
  String? spd61;
  String? spd62;
  String? spd63;
  String? spd64;
  String? spd65;
  String? lokasi;
  String? tglPasang;
  Sipil({
    this.id,
    this.spd61,
    this.spd62,
    this.spd63,
    this.spd64,
    this.spd65,
    this.lokasi,
    this.tglPasang,
  });
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['spd61'] = spd61;
    map['spd62'] = spd62;
    map['spd63'] = spd63;
    map['spd64'] = spd64;
    map['spd65'] = spd65;
    map['lokasi'] = lokasi;
    map['tglPasang'] = tglPasang;

    return map;
  }

  Sipil.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    spd61 = map['spd61'];
    spd62 = map['spd62'];
    spd63 = map['spd63'];
    spd64 = map['spd64'];
    spd65 = map['spd65'];
    lokasi = map['lokasi'];
    tglPasang = map['tglPasang'];
  }
}
