import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../../../common/colors/colors.dart';
import '../../widgets/setting_widgets.dart';

Widget CalibrationTile({required String name,required String valueText,void Function()? decrease,void Function()? increse,void Function(String value)? onChange}){
  return Container(
    height: 48,
    padding: EdgeInsets.symmetric(horizontal: 24),
    decoration: BoxDecoration(
      color: AppColors.primaryElementText,
      boxShadow: [
        BoxShadow(
          color:AppColors.secondaryColor,
          spreadRadius: 2,
          blurRadius: 3,
        )
      ],
    ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(flex:2,child: reUsableText(name: name,fontSize: 18,fontWeight: FontWeight.bold)),
      Expanded(flex:2,child: Center(child: reUsableText(name: valueText.toString(),fontSize: 18,fontWeight: FontWeight.bold))),
      Expanded(child: Center(child: GestureDetector(
        onTap: ()=>decrease!(),
        child: reUsableText(name: "-",fontSize: 32,fontWeight: FontWeight.bold),))),
      Expanded(
        child: Container(
          color: AppColors.primaryElement,
            width: 100,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              cursorColor: Colors.white,
              onChanged: (value)=>onChange!(value),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: AppColors.primaryElementText),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: valueText,
                hintStyle: TextStyle(color: AppColors.primaryElementText)
              ),
            )),
      ),
      Expanded(child: Center(child: GestureDetector(
        onTap: ()=>increse!(),
        child: reUsableText(name: "+",fontSize: 24,fontWeight: FontWeight.bold),))),


  ],),
  );
}