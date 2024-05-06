class ToleranceStates {
  final double? GaugeMax;
  final double? LevelMax;
  final double? TwistMax;
  final double? ElevationMax;
  final double? TempMax;

  final double? GaugeMin;
  final double? LevelMin;
  final double? TwistMin;
  final double? ElevationMin;
  final double? TempMin;

  const ToleranceStates(
      {this.GaugeMax=0,
      this.LevelMax=0,
      this.TwistMax=0,
      this.ElevationMax=0,
      this.TempMax=0,

      this.GaugeMin=0,
      this.LevelMin=0,
      this.ElevationMin=0,
      this.TwistMin=0,
      this.TempMin=0});

  ToleranceStates copyWith(
      {double? GaugeMax,
      double? LevelMax,
      double? TwistMax,
      double? ElevationMax,
      double? TempMax,
      double? GaugeMin,
      double? LevelMin,
      double? TwistMin,
      double? ElevationMin,
      double? TempMin}) {

    return ToleranceStates(



      GaugeMax:GaugeMax??this.GaugeMax,
      LevelMax:LevelMax??this.LevelMax ,
      TwistMax:TwistMax??this.TwistMax,
      ElevationMax: ElevationMax??this.ElevationMax,
      TempMax:TempMax??this.TempMax,

      GaugeMin:GaugeMin??this.GaugeMin,
      LevelMin:LevelMin??this.LevelMin,
      TwistMin:TwistMin??this.TwistMin,
      ElevationMin:ElevationMin??this.ElevationMin,
      TempMin:TempMin??this.TempMin,


    );
  }
}
