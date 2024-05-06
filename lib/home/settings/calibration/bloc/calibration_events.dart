abstract class CalibrationEvents{
 const CalibrationEvents();
}

class TriggerGaugeEvent extends CalibrationEvents{
  final double gauge;
 const TriggerGaugeEvent(this.gauge);
}

class TriggerLevelEvent extends CalibrationEvents{
  final double level;
  const TriggerLevelEvent(this.level);
}

class TriggerGradientEvent extends CalibrationEvents{
  final double gradient;
 const TriggerGradientEvent(this.gradient);
}

class TriggerTempEvent extends CalibrationEvents{
  final double temp;
  const TriggerTempEvent(this.temp);
}

class TriggerTwistEvent extends CalibrationEvents{
  final double twist;
  TriggerTwistEvent(this.twist);
}


class TriggerAlignmentEvent extends CalibrationEvents{
  final double alignment;
  TriggerAlignmentEvent(this.alignment);
}


class TriggerUnitEvent extends CalibrationEvents{
  final String unit;
  TriggerUnitEvent(this.unit);
}


class TrigerDistanceEvent extends CalibrationEvents{
  final String distance;
  TrigerDistanceEvent(this.distance);
}