class CalibrationEntity{
  double? gauge;
  double? level;
  double? gradient;
  double? twist;
  double? temp;
  double? alignment;

  CalibrationEntity({this.gauge,this.gradient,this.level,this.twist,this.temp,this.alignment});

  Map<String,dynamic> toJson()=>{
    "gauge":gauge,
    "level":level,
    "gradient":gradient,
    "twist":twist,
    "temp":temp,
    "alignment":alignment
  };

}