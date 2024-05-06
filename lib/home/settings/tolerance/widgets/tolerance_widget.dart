import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../common/colors/colors.dart';
import '../../widgets/setting_widgets.dart';

Widget ToleranceHeaderTile() {
  return Container(
    height: 48,
    padding: EdgeInsets.symmetric(horizontal: 24),
    decoration: BoxDecoration(
      color: AppColors.primaryElementText,
      boxShadow: [
        BoxShadow(
          color: AppColors.secondaryColor,
          spreadRadius: 2,
          blurRadius: 3,
        )
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 2,
            child: reUsableText(
                name: "Name", fontSize: 18, fontWeight: FontWeight.bold)),
        Expanded(child: Container()),
        Expanded(
            child: Center(
                child: reUsableText(
                    name: "Min", fontWeight: FontWeight.bold, fontSize: 18))),
        Expanded(child: Container()),
        Expanded(child: Container()),
        Expanded(
            child: Center(
                child: reUsableText(
                    name: "Max", fontWeight: FontWeight.bold, fontSize: 18))),
        Expanded(child: Container()),
      ],
    ),
  );
}

Widget ToleranceTile(
    {required String name,
    required String valueMin,
    required String valueMax,
    void Function()? decreaseMin,
    void Function()? increseMin,
    void Function()? decreaseMax,
    void Function()? increseMax,
    void Function(String value)? onChangeMax,
    void Function(String value)? onChangeMin}) {
  return Container(
    height: 48,
    padding: EdgeInsets.symmetric(horizontal: 24),
    decoration: BoxDecoration(
      color: AppColors.primaryElementText,
      boxShadow: [
        BoxShadow(
          color: AppColors.secondaryColor,
          spreadRadius: 2,
          blurRadius: 3,
        )
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 2,
            child: reUsableText(
                name: name, fontSize: 18, fontWeight: FontWeight.bold)),
        Expanded(
            child: Center(
                child: GestureDetector(
                  onTap: ()=>decreaseMin!(),
          child: reUsableText(
              name: "-", fontSize: 32, fontWeight: FontWeight.bold),
        ))),
        Expanded(
          child: Container(
              color: AppColors.primaryElement,
              width: 100,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) => onChangeMin!(value),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryElementText),
                cursorColor: Colors.white,
                decoration: InputDecoration(border: InputBorder.none,hintText: valueMin,hintStyle: TextStyle(color: AppColors.primaryElementText)),
              )),
        ),
        Expanded(
            child: Center(
                child: GestureDetector(onTap: ()=>increseMin!(),
          child: reUsableText(
              name: "+", fontSize: 24, fontWeight: FontWeight.bold),
        ))),
        Expanded(
            child: Center(
                child: GestureDetector(
                       onTap:  ()=>decreaseMax!(),
          child: reUsableText(
              name: "-", fontSize: 32, fontWeight: FontWeight.bold),
        ))),
        Expanded(
          child: Container(
              color: AppColors.primaryElement,
              width: 100,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) => onChangeMax!(value),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryElementText),
                cursorColor: Colors.white,

                decoration: InputDecoration(border: InputBorder.none,hintText: valueMax,hintStyle: TextStyle(color: AppColors.primaryElementText)),
              )),
        ),
        Expanded(
            child: Center(
                child: GestureDetector(
                  onTap:()=> increseMax!(),
          child: reUsableText(
              name: "+", fontSize: 24, fontWeight: FontWeight.bold),
        ))),
      ],
    ),
  );
}
