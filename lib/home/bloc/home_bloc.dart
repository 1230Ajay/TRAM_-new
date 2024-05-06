import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_events.dart';
import 'home_states.dart';


class HomeBloc extends Bloc<HomeEvents, HomeStates> with ChangeNotifier {
  HomeBloc() : super(HomeStates()) {
    on<isStartedEvents>(_isStarted);
    on<JsonDataEvent>(_jsonDataEvent);
    on<SelectRecording>(_selectRecording);
    on<RelativeDistance>(_relativeDistance);
    on<AbsoluteDistance>(_absoluteDistance);
    on<LattitudeEvent>(_lattitude);
    on<LongitudeEvent>(_longitude);
    on<DirectionEvent>(_direction);
    on<ToResumeEvent>(_toResume);
    on<CalibartionForDistanceEvent>(_calibartionForDistanceEvent);
    on<RelativeDistanceForUi>(_relativeDistanceForUi);
    on<RecordingErrorEvent>(_recordingErrorEvent);
    on<TwistEvent>(_twistEvent);
  }

  void _isStarted(isStartedEvents event, Emitter<HomeStates> emit) {
    emit(state.copyWith(isStarted: event.isStarted));
  }

  void _jsonDataEvent(JsonDataEvent event, Emitter<HomeStates> emit) {
    emit(state.copyWith(dataEntity: event.jsonData));
  }

  void _selectRecording(SelectRecording event, Emitter<HomeStates> emit) {
    emit(state.copyWith(selectedRecodring: event.selectedRecording));
  }

  void _relativeDistance(RelativeDistance event, Emitter<HomeStates> emit) {
    emit(state.copyWith(relative: event.relative));
  }

  void _absoluteDistance(AbsoluteDistance event, Emitter<HomeStates> emit) {
    emit(state.copyWith(absolute: event.absolute));
  }

  void _lattitude(LattitudeEvent event, Emitter<HomeStates> emit) {
    emit(state.copyWith(lattitude: event.lattitude));
  }

  void _longitude(LongitudeEvent event, Emitter<HomeStates> emit) {
    emit(state.copyWith(longitude: event.longitude));
  }

  void _direction(DirectionEvent event, Emitter<HomeStates> emit) {
    emit(state.copyWith(direction: event.direction));
  }

  void _toResume(ToResumeEvent event, Emitter<HomeStates> emit) {
    emit(state.copyWith(toResume: event.toResume));
  }

  void _relativeDistanceForUi(RelativeDistanceForUi event, Emitter<HomeStates> emit){
    emit(state.copyWith(relative_distance_fo_ui: event.relative_distance_fo_ui));
  }

  void _calibartionForDistanceEvent(CalibartionForDistanceEvent event, Emitter<HomeStates> emit){
    emit(state.copyWith(calibrationForDistance: event.calibrationForDistance));
  }

  void _recordingErrorEvent(RecordingErrorEvent event,Emitter<HomeStates> emit){
    emit(state.copyWith(error: event.error));
    notifyListeners();
  }

  void _twistEvent(TwistEvent event,Emitter<HomeStates> emit){
    emit(state.copyWith(twist: event.twist));
    notifyListeners();
  }

}
