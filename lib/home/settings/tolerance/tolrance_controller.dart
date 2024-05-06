import 'package:flutter/cupertino.dart';

class ToleranceController{
  late BuildContext context;

  ToleranceController({required this.context});


  double decrease({required double value}){
    value = value-1;
    return value;
  }

  double increase({required double value}){
    value = value+1;
    return value;
  }

}