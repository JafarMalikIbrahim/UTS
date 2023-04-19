class Kd {
  int? id;
  String? spd31;
  String? spd32;
  String? spd33;
  String? spd34;
  String? spd35;
  String? lokasi;
  String? tglPasang;
  Kd({
    this.id,
    this.spd31,
    this.spd32,
    this.spd33,
    this.spd34,
    this.spd35,
    this.lokasi,
    this.tglPasang,
  });
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['spd31'] = spd31;
    map['spd32'] = spd32;
    map['spd33'] = spd33;
    map['spd34'] = spd34;
    map['spd35'] = spd35;
    map['lokasi'] = lokasi;
    map['tglPasang'] = tglPasang;

    return map;
  }

  Kd.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    spd31 = map['spd31'];
    spd32 = map['spd32'];
    spd33 = map['spd33'];
    spd34 = map['spd34'];
    spd35 = map['spd35'];
    lokasi = map['lokasi'];
    tglPasang = map['tglPasang'];
  }
}
