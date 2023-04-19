class It {
  int? id;
  String? spd51;
  String? spd52;
  String? spd53;
  String? spd54;
  String? spd55;
  String? lokasi;
  String? tglPasang;
  It({
    this.id,
    this.spd51,
    this.spd52,
    this.spd53,
    this.spd54,
    this.spd55,
    this.lokasi,
    this.tglPasang,
  });
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['spd51'] = spd51;
    map['spd52'] = spd52;
    map['spd53'] = spd53;
    map['spd54'] = spd54;
    map['spd55'] = spd55;
    map['lokasi'] = lokasi;
    map['tglPasang'] = tglPasang;

    return map;
  }

  It.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    spd51 = map['spd51'];
    spd52 = map['spd52'];
    spd53 = map['spd53'];
    spd54 = map['spd54'];
    spd55 = map['spd55'];
    lokasi = map['lokasi'];
    tglPasang = map['tglPasang'];
  }
}
