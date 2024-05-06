import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../home/settings/widgets/setting_widgets.dart';
import '../colors/colors.dart';
import '../values/widgets.dart';

void showInputPopup(BuildContext context,
    {required void Function(String value) onSave, required String name}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ReusablePopup(
        onSave: onSave,
        name: name,
      );
    },
  );
}

Future<void> DialogBarForInfoAndAlert(BuildContext context,
    {required String title,
    required String message,
    bool alert = false}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,

    // user must tap button!
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.primaryElementText,
            borderRadius: BorderRadius.circular(8)
          ),
          padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
          height: 120,
          width: 220,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  alert?Icon(Icons.crisis_alert,color: AppColors.primaryElement,):Icon(Icons.save,color:Colors.green,),
                  SizedBox(width:8,),
                  reUsableText(
                      name: title,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryElement),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  reUsableText(
                      name: message,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,color: AppColors.primarySecondaryElementText),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: Container()),
                      Column(
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("close",style: TextStyle(color: AppColors.primaryElement),)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
