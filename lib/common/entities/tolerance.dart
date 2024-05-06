class ToleranceEntity {
  double? gaugeMax;
  double? levelMax;
  double? elevationMax;
  double? twistMax;
  double? temperatureMax;

  double? gaugeMin;
  double? levelMin;
  double? elevationMin;
  double? twistMin;
  double? temperatureMin;

  ToleranceEntity(
      {this.gaugeMax,
      this.levelMax,
      this.elevationMax,
      this.twistMax,
      this.temperatureMax,
      this.gaugeMin,
      this.levelMin,
      this.elevationMin,
      this.temperatureMin,
      this.twistMin});

  Map<String, dynamic> toJson() => {
        "gaugeMax": gaugeMax,
        "levelMax": levelMax,
        "elevationMax": elevationMax,
        "twistMax": twistMax,
        "temperatureMax": temperatureMax,
        "gaugeMin": gaugeMin,
        "levelMin": levelMin,
        "elevationMin": elevationMin,
        "twistMin": twistMin,
        "temperatureMin": temperatureMin
      };

  factory ToleranceEntity.fromJson(Map<String, dynamic> json) => ToleranceEntity(
      gaugeMax: json["gaugeMax"],
      levelMax: json["levelMax"],
      elevationMax: json["elevationMax"],
      twistMax: json["twistMax"],
      temperatureMax: json["temperatureMax"],

      gaugeMin: json["gaugeMin"],
      levelMin: json["levelMin"],
      elevationMin: json["elevationMin"],
      twistMin: json["twistMin"],
      temperatureMin: json["temperatureMin"]);
}
