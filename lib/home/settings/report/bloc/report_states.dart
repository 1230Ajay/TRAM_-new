class RecordingStates{
  String? recording_name;
  String? operator_name;


  String? recording_name_for_record_data;

  RecordingStates({this.recording_name, this.operator_name,this.recording_name_for_record_data});

  RecordingStates copyWith({String? recording_name,String? operator_name,String? recording_name_for_record_data}){
    return RecordingStates(recording_name:recording_name??this.recording_name , operator_name: operator_name??this.operator_name,recording_name_for_record_data: recording_name_for_record_data??this.recording_name_for_record_data);
  }

}