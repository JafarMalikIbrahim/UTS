// realtime
class SpData {
  String dateTime;
  double solarRad;
  double energiPrimer;
  double volt;
  double ampere;
  double power;

  SpData(
    this.dateTime,
    this.solarRad,
    this.energiPrimer,
    this.volt,
    this.ampere,
    this.power,
  );
}

class SpDailyProd {
  String id;
  String day;
  double powerWatt;
  double powerKwh;

  SpDailyProd(
    this.id,
    this.day,
    this.powerWatt,
    this.powerKwh,
  );
}
