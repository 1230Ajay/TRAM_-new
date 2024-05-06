import 'package:flutter/cupertino.dart';

import '../../../../common/colors/colors.dart';
import '../../widgets/setting_widgets.dart';

Widget SaathiTile({required String name, required String id}){
  return Container(
    height: 48,
    margin: EdgeInsets.only(bottom: 4),
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
        reUsableText(name: name,fontSize: 18,fontWeight: FontWeight.bold,),
        Container(
          width: 100,
          margin: EdgeInsets.symmetric(vertical: 8),
          color: AppColors.primaryElement,
            child: Center(child: reUsableText(name:id,fontSize: 18,fontWeight: FontWeight.bold,color: AppColors.primaryElementText))
        ),
      ],
    ),
  );
}