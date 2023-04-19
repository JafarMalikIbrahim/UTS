class Elektrik {
  int? id;
  String? spd21;
  String? spd22;
  String? spd23;
  String? spd24;
  String? spd25;
  String? lokasi;
  String? tglPasang;
  Elektrik({
    this.id,
    this.spd21,
    this.spd22,
    this.spd23,
    this.spd24,
    this.spd25,
    this.lokasi,
    this.tglPasang,
  });
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['spd21'] = spd21;
    map['spd22'] = spd22;
    map['spd23'] = spd23;
    map['spd24'] = spd24;
    map['spd25'] = spd25;
    map['lokasi'] = lokasi;
    map['tglPasang'] = tglPasang;

    return map;
  }

  Elektrik.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    spd21 = map['spd21'];
    spd22 = map['spd22'];
    spd23 = map['spd23'];
    spd24 = map['spd24'];
    spd25 = map['spd25'];
    lokasi = map['lokasi'];
    tglPasang = map['tglPasang'];
  }
}
