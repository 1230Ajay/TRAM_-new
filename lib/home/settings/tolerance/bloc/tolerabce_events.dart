abstract class ToleranceEvents{
  const ToleranceEvents();
}

class GuageMaxEvent extends ToleranceEvents{
  final double GaugeMax;
  const GuageMaxEvent(this.GaugeMax);
}

class LevelMaxEvent extends ToleranceEvents{
  final double LevelMax;
  const LevelMaxEvent(this.LevelMax);
}

class TwistMaxEvent extends ToleranceEvents{
  final double TwistMax;
  const TwistMaxEvent(this.TwistMax);
}


class ElevationMaxEvent extends ToleranceEvents{
  final double ElevationMax;
  const ElevationMaxEvent(this.ElevationMax);
}


class TempMaxEvent extends ToleranceEvents{
  final double TempMax;
  const TempMaxEvent(this.TempMax);
}


class GuageMinEvent extends ToleranceEvents{
  final double GaugeMin;
  const GuageMinEvent(this.GaugeMin);
}

class LevelMinEvent extends ToleranceEvents{
  final double LevelMin;
  const LevelMinEvent(this.LevelMin);
}

class TwistMinEvent extends ToleranceEvents{
  final double TwistMin;
  const TwistMinEvent(this.TwistMin);
}


class ElevationMinEvent extends ToleranceEvents{
  final double ElevationMin;
  const ElevationMinEvent(this.ElevationMin);
}


class TempMinEvent extends ToleranceEvents{
  final double TempMin;
  const TempMinEvent(this.TempMin);
}

