import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../common/values/constants.dart';
import '../../../global.dart';
import 'bloc/calibration_bloc.dart';
import 'bloc/calibration_events.dart';

class CalibrationController{
  late BuildContext context;
  CalibrationController({required this.context});

  double decrease({required double value}){
    value = value-1;
    return value;
  }

  double increase({required double value}){
    value = value+1;
    return value;
  }

}