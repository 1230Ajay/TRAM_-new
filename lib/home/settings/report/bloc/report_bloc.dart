import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tram_win_10/home/settings/report/bloc/report_events.dart';
import 'package:tram_win_10/home/settings/report/bloc/report_states.dart';



class RecordingBloc extends Bloc<RecordingEvents,RecordingStates>{
  RecordingBloc():super(RecordingStates()){
    on<RecordingNameEvent>(_recordingEvent);
    on<OperatorNameEvent>(_operatorEvent);
    on<RecordingNameForRecordDataEvent>(_recodingNameForRecordingData);
  }

  void _recordingEvent(RecordingNameEvent event,Emitter<RecordingStates> emit){
    emit(state.copyWith(recording_name: event.recording_name));
  }

  void _operatorEvent(OperatorNameEvent event,Emitter<RecordingStates> emit){
    emit(state.copyWith(operator_name: event.operator_name));
  }

  void _recodingNameForRecordingData(RecordingNameForRecordDataEvent event,Emitter<RecordingStates> emit){
    emit(state.copyWith(recording_name_for_record_data: event.recording_name_for_record_data));
  }
}