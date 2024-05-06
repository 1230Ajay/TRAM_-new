

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tram_win_10/login_page/bloc/loginPageBloc.dart';
import 'package:tram_win_10/login_page/bloc/loginPageEvent.dart';

import '../common/api/LoginApi.dart';
import '../common/entities/login.dart';
import '../common/routes/names.dart';
import '../common/values/constants.dart';
import '../global.dart';

class LoginController{
  BuildContext context;
  LoginController(this.context);

  Future<void> login({required String password})async {

    String user_password = Global.storageService.getPassowrd();

    if(user_password==password){
      Navigator.of(context).pushNamed(AppRoutes.HOME_PAGE);
      context.read<LoginpageBloc>().add(ErrorEvent(""));
    }else{
      context.read<LoginpageBloc>().add(ErrorEvent("Incorrect Password....."));
    }
  }

  Future<void> logout()async{
    Global.storageService.remove(key: AppConstants.PASSWORD);
    Global.storageService.remove(key: AppConstants.EMAIL);
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.INITIAL, (route) => false);
  }


  Future getUserDetails(String email)async{
    LoginRequestEntity loginRequestEntity = LoginRequestEntity(email: email);
   var res = await LoginApi.login(entity: loginRequestEntity);
   if(res!=null){
     print("your email we got : ${res.email} ${res.designation} ${res.sec} ${res.div} ${res.zone}");


     Global.storageService.setEmail(value: res.email??"");
     Global.storageService.setDesignation(value: res.designation??"");
     Global.storageService.setOperatorName(value: res.name??"");

     Global.storageService.setDiv(value: res.div??"");
     Global.storageService.setSec(value: res.sec??"");
     Global.storageService.setZone(value: res.zone??"");


     Navigator.of(context).pushNamed(AppRoutes.SETPASSWORD);
   }

  }

  Future setPassword({ required String repassword,required String password})async{
    if(repassword==password){
      bool isSet = await Global.storageService.setPassword(value: password);
      if(isSet){

        Navigator.of(context).pushNamed(AppRoutes.HOME_PAGE);
      }{
        print("something went wrong");
      }
    }
  }

}
