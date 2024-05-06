
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tram_win_10/login_page/bloc/loginPageEvent.dart';
import 'package:tram_win_10/login_page/bloc/loginPageState.dart';

class LoginpageBloc extends Bloc<LoginPageEvents,LoginPageStates> with ChangeNotifier{
  LoginpageBloc():super(LoginPageStates()){
    on<ErrorEvent>(_errorEvent);
  }

  void _errorEvent(ErrorEvent event,Emitter<LoginPageStates> emit){
    emit(state.copyWith(error: event.error));
    print("${state.error} , ${event.error}");
    notifyListeners();
  }

}