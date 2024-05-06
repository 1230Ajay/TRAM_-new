class CalibrationStates {
  final double? gauge;
  final double? level;
  final double? gradient;
  final double? temp;
  final double? twist;
  final double? alignment;
  final String? unit;
  final String? distance;

  const CalibrationStates(
      {this.temp=0,
      this.level=0,
      this.twist=0,
      this.gradient=0,
      this.gauge=0,
      this.alignment=0,
        this.unit ,this.distance
      });

  CalibrationStates copyWith(
      {double? gauge,
      double? level,
      double? gradient,
      double? temp,
      double? twist,
      double? alignment, String? unit,String? distance}) {

    return CalibrationStates(
        gauge: gauge ?? this.gauge,
        level: level ?? this.level,
        gradient: gradient ?? this.gradient,
        temp: temp ?? this.temp,
        alignment: alignment ?? this.alignment,
        twist: twist??this.twist,
        unit: unit??this.unit,
        distance: distance??this.distance
    );

  }
}
