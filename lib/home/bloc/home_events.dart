

import '../../common/entities/data_entity.dart';
import '../../common/entities/location.dart';

abstract class HomeEvents {
  const HomeEvents();
}

class isStartedEvents extends HomeEvents {
  final bool? isStarted;
  const isStartedEvents({this.isStarted});
}

class JsonDataEvent extends HomeEvents {
  final DataEntity jsonData;
  JsonDataEvent({required this.jsonData});
}

class SelectRecording extends HomeEvents {
  final String selectedRecording;
  const SelectRecording(this.selectedRecording);
}

class AbsoluteDistance extends HomeEvents {
  final int absolute;

  const AbsoluteDistance(this.absolute);
}

class RelativeDistance extends HomeEvents {
  final double relative;

  const RelativeDistance(this.relative);
}


class LongitudeEvent extends HomeEvents {
  final double longitude;

  const LongitudeEvent(this.longitude);
}


class LattitudeEvent extends HomeEvents {
  final double lattitude;

  const LattitudeEvent(this.lattitude);
}

class DirectionEvent extends HomeEvents {
  final String direction;
  const DirectionEvent(this.direction);
}

class ToResumeEvent extends HomeEvents {
  final bool toResume;
  const ToResumeEvent(this.toResume);
}

class RelativeDistanceForUi extends HomeEvents{
 final double? relative_distance_fo_ui;
 RelativeDistanceForUi(this.relative_distance_fo_ui);
}

class CalibartionForDistanceEvent extends HomeEvents{
  final int calibrationForDistance;
  CalibartionForDistanceEvent(this.calibrationForDistance);
}

class RecordingErrorEvent extends HomeEvents{
  final String? error;
  RecordingErrorEvent(this.error);
}

class TwistEvent extends HomeEvents{
  final double? twist;
  TwistEvent(this.twist);
}
