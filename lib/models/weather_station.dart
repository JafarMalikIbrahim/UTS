// model
class WsData {
  String dateUtc;
  double windSpeed;
  double windDir;
  double temp;
  double uvIndex;
  double solarRad;

  WsData(
    this.dateUtc,
    this.windSpeed,
    this.windDir,
    this.temp,
    this.uvIndex,
    this.solarRad,
  );
}