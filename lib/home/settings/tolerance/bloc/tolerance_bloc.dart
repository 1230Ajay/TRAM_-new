import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tram_win_10/home/settings/tolerance/bloc/tolerabce_events.dart';
import 'package:tram_win_10/home/settings/tolerance/bloc/tolerance_states.dart';


class ToleranceBloc extends Bloc<ToleranceEvents,ToleranceStates>{
  ToleranceBloc():super(ToleranceStates()){
    on<GuageMaxEvent>(_guageMaxEvent);
    on<LevelMaxEvent>(_levelMaxEvent);
    on<TwistMaxEvent>(_twistMaxEvent);
    on<ElevationMaxEvent>(_elevationMaxEvent);
    on<TempMaxEvent>(_tempMaxEvent);

    on<GuageMinEvent>(_guageMinEvent);
    on<LevelMinEvent>(_levelMinEvent);
    on<TwistMinEvent>(_twistMinEvent);
    on<ElevationMinEvent>(_elevationMinEvent);
    on<TempMinEvent>(_tempMinEvent);
  }

  void _guageMaxEvent(GuageMaxEvent event , Emitter<ToleranceStates> emit){
   emit(state.copyWith(GaugeMax:event.GaugeMax));
  }

  void _levelMaxEvent(LevelMaxEvent event , Emitter<ToleranceStates> emit){
    emit(state.copyWith(LevelMax:event.LevelMax));
  }

  void _twistMaxEvent(TwistMaxEvent event , Emitter<ToleranceStates> emit){
    emit(state.copyWith(TwistMax:event.TwistMax));
  }

  void _elevationMaxEvent(ElevationMaxEvent event , Emitter<ToleranceStates> emit){
    emit(state.copyWith(ElevationMax:event.ElevationMax));
  }

  void _tempMaxEvent(TempMaxEvent event , Emitter<ToleranceStates> emit){
    emit(state.copyWith(TempMax:event.TempMax));
  }




  void _guageMinEvent(GuageMinEvent event , Emitter<ToleranceStates> emit){
    emit(state.copyWith(GaugeMin:event.GaugeMin));
  }


  void _levelMinEvent(LevelMinEvent event , Emitter<ToleranceStates> emit){
    emit(state.copyWith(LevelMin:event.LevelMin));
  }

  void _twistMinEvent(TwistMinEvent event , Emitter<ToleranceStates> emit){
    emit(state.copyWith(TwistMin:event.TwistMin));
  }

  void _elevationMinEvent(ElevationMinEvent event , Emitter<ToleranceStates> emit){
    emit(state.copyWith(ElevationMin:event.ElevationMin));
  }

  void _tempMinEvent(TempMinEvent event , Emitter<ToleranceStates> emit){
    emit(state.copyWith(TempMin:event.TempMin));
  }

}