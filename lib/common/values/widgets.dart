
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../home/settings/widgets/setting_widgets.dart';
import '../colors/colors.dart';



Widget inputTextField(
    {required String hintText,
      Function(String text)? onChange,
      required Icon icon,bool isPasswordFeild = false,double width=200,Color textColor=AppColors.primaryElementText}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      icon,
      SizedBox(
        width: 8,
      ),
      Container(
        width: width,
        height: 24,
        child: TextField(
          obscureText:isPasswordFeild,
          onChanged: (value) => onChange!(value),
          cursorColor: textColor,
          style: TextStyle(color: textColor, fontSize: 16),
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: 14,
                  color: textColor.withOpacity(0.5),
                  fontWeight: FontWeight.w300)),
        ),
      ),
    ],
  );
}




class ReusablePopup extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  final String name;
  Function(String) onSave;

  ReusablePopup({required this.onSave,required this.name});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0), // Set border radius here
      ),
      backgroundColor:AppColors.primaryElementText,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          reUsableText(name:"Add $name",fontSize: 18,fontWeight: FontWeight.w500,color: AppColors.primaryElement),
          IconButton(onPressed: (){
            Navigator.of(context).pop();
          }, icon:Icon(Icons.close,color: AppColors.primaryElement,))
        ],
      ),
      content: Container(
        height: 112,
        width: 400,
        // padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration:  InputDecoration(labelText: 'Enter $name',hintStyle: TextStyle(color: AppColors.primaryElement)),
            ),
            SizedBox(height: 20),
            Center(
              child: primaryButton(btnName: "Save",onPress:  () {
                onSave(_textEditingController.text);
                Navigator.of(context).pop();
              },),
            ),
          ],
        ),
      ),
    );
  }
}