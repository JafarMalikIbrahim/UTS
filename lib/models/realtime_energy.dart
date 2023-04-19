class RealtimeEnergy {
  String dateUtc;
  double windSpeed;
  double powerWatt;

  double powerSp;
  double powerDiesel;
  double solarRad;
  double bbm;
  RealtimeEnergy(
    this.dateUtc,
    this.windSpeed,
    this.powerWatt,
    this.powerSp,
    this.powerDiesel,
    this.solarRad,
    this.bbm,
  );
}
