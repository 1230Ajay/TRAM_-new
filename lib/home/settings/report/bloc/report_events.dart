abstract class RecordingEvents{
  const RecordingEvents();
}

class RecordingNameEvent extends RecordingEvents{
  String? recording_name;
  RecordingNameEvent(this.recording_name);
}

class OperatorNameEvent extends RecordingEvents{
  String? operator_name;
  OperatorNameEvent(this.operator_name);
}

class RecordingNameForRecordDataEvent extends RecordingEvents{
  String? recording_name_for_record_data;
  RecordingNameForRecordDataEvent(this.recording_name_for_record_data);
}