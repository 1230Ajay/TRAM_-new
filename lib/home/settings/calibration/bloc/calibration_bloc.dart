import 'package:flutter_bloc/flutter_bloc.dart';

import 'calibration_events.dart';
import 'calibration_states.dart';


class CalibrationBloc extends Bloc<CalibrationEvents,CalibrationStates>{
  CalibrationBloc():super(CalibrationStates()){
    on<TriggerGaugeEvent>(_triggerGaugeEvent);
    on<TriggerLevelEvent>(_triggerLevelEvent);
    on<TriggerGradientEvent>(_triggerGradientEvent);

    on<TriggerTwistEvent>(_triggerTwistEvent);
    on<TriggerTempEvent>(_triggerTempEvent);
    on<TriggerAlignmentEvent>(_triggerAlignmentEvet);


    on<TriggerUnitEvent>(_triggerUnitEvent);
    on<TrigerDistanceEvent>(_triggerDistanceEvent);
  }

  void _triggerGaugeEvent(TriggerGaugeEvent event,Emitter<CalibrationStates> emit){
     emit(state.copyWith(gauge: event.gauge));
  }

  void _triggerLevelEvent(TriggerLevelEvent event,Emitter<CalibrationStates> emit){
     emit(state.copyWith(level: event.level));
  }

  void _triggerGradientEvent(TriggerGradientEvent event,Emitter<CalibrationStates> emit){
    emit(state.copyWith(gradient: event.gradient));

  }



  void _triggerTwistEvent(TriggerTwistEvent event,Emitter<CalibrationStates> emit){
    emit(state.copyWith(twist: event.twist));
  }

  void _triggerTempEvent(TriggerTempEvent event,Emitter<CalibrationStates> emit){
    emit(state.copyWith(temp: event.temp));
  }

  void _triggerAlignmentEvet(TriggerAlignmentEvent event,Emitter<CalibrationStates> emit){
    emit(state.copyWith(alignment: event.alignment));
  }

  void _triggerUnitEvent(TriggerUnitEvent event,Emitter<CalibrationStates> emit){
    emit(state.copyWith(unit: event.unit));
  }

  void _triggerDistanceEvent(TrigerDistanceEvent event,Emitter<CalibrationStates> emit){
    emit(state.copyWith(distance: event.distance));
  }



}