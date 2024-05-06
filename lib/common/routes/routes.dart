import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tram_win_10/login_page/bloc/loginPageBloc.dart';
import '../../global.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/home.dart';
import '../../home/settings/calibration/bloc/calibration_bloc.dart';
import '../../home/settings/calibration/calibration.dart';
import '../../home/settings/report/bloc/report_bloc.dart';
import '../../home/settings/report/report.dart';
import '../../home/settings/tolerance/bloc/tolerance_bloc.dart';
import '../../home/settings/tolerance/tolerance.dart';
import '../../login_page/Login.dart';
import '../../login_page/get_user_details.dart';
import '../../login_page/set_password.dart';
import 'names.dart';

class AppPages{
  static List<PageEntity> Routes(){
    return [

      PageEntity(route: AppRoutes.HOME_PAGE, page: MyHomePage(),bloc: BlocProvider(create: (_)=>HomeBloc(),)),
      PageEntity(route: AppRoutes.TOLERANCE, page: TolerancePage(),bloc: BlocProvider(create: (_)=>ToleranceBloc(),)),
      PageEntity(route: AppRoutes.CALIBRATION, page: CalibrationPage(),bloc: BlocProvider(create: (_)=>CalibrationBloc(),)),
      PageEntity(route: "recording", page: Recodrings(),bloc: BlocProvider(create: (_)=>RecordingBloc(),)),
      PageEntity(route: AppRoutes.SETPASSWORD, page: SetPassowrdpage()),
      PageEntity(route: AppRoutes.INITIAL, page: getUserDetails()),
      PageEntity(route:AppRoutes.LOGIN_PAGE , page: LoginPage(),bloc: BlocProvider(create: (_)=>LoginpageBloc(),))
    ];
  }


  static List<BlocProvider> allBlocProviders(BuildContext context){
    List<BlocProvider> blocProviders = <BlocProvider>[];
    for(var bloc in Routes()){
      if(bloc.bloc!=null){
        blocProviders.add(bloc.bloc);
      }
    }

    return blocProviders;
  }

  static MaterialPageRoute GenrRatePageRoute(RouteSettings settings){
    if(settings!=null){
      var result = Routes().where((element) => element.route==settings.name);

      if(result.isNotEmpty){
        if( result.first.route==AppRoutes.INITIAL && Global.storageService.getEmail()!=""){
          if(Global.storageService.getPassowrd()!=""){
            return MaterialPageRoute(builder: (_)=>LoginPage(),settings: settings);
          }else{
            return MaterialPageRoute(builder: (_)=>SetPassowrdpage(),settings: settings);
          }
        }
        return MaterialPageRoute(builder: (_)=>result.first.page,settings: settings);
      }
    }

    return MaterialPageRoute(builder: (_)=>MyHomePage(),settings: settings);

  }

}




class PageEntity{
   String route;
   Widget page;
   dynamic bloc;
  PageEntity({required this.route,required this.page,this.bloc});
}