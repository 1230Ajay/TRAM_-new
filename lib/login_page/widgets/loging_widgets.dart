
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tram_win_10/login_page/bloc/loginPageBloc.dart';
import 'package:tram_win_10/login_page/bloc/loginPageState.dart';

import '../../common/colors/colors.dart';
import '../../common/values/widgets.dart';
import '../../home/settings/widgets/setting_widgets.dart';
import '../login_controller.dart';

Widget leftLogin({required Icon icon}) {
  return Container(
      margin: EdgeInsets.only(right: 74),
      child: Center(
        child: Stack(
          children: [

            Positioned(
                left: 0,
                bottom: 12,
                child: decorationCircle(color: AppColors.primaryElement,size: 24)),


            Positioned(
                child: decorationCircle(color: AppColors.primaryElement,size: 12)),

            Positioned(
                right: 24,
                top: 48,
                child: decorationCircle(color: AppColors.primaryElement,size: 16)),


            Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(

                  border: Border.all(color: AppColors.primaryElement, width: 8),
                  borderRadius: BorderRadius.circular(80)),
              child:icon,
            ),
          ],
        ),
      ));
}

Widget decorationCircle({required double size ,required Color color}){
  return Container(
    width: size,
    height:size,
    child: Text(""),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: color
    ),
  );
}

Widget rightLogin(LoginController loginController , {required String title, required LoginPageStates state}) {

  String password="";

  return Container(
    margin: EdgeInsets.only(top: 56),
    child: Column(
      children: [
        reUsableText(
            name: title,
            color: AppColors.primaryElementText,
            fontSize: 32),
        SizedBox(
          height: 20,
        ),

        inputTextField(
          isPasswordFeild: true,
            hintText: "Enter your password",
            icon: Icon(
              size: 20,
              Icons.lock,
              color: AppColors.primaryElementText,
            ),
            onChange: (value) {
              password = value;
            }),
        SizedBox(height: 4,),
        SizedBox(
          height: 32,
          child: reUsableText(name: state.error??"",color: AppColors.primaryElement,fontSize: 14)
        ),
        
        primaryButton(btnName: "Login",onPress: () async {
          await loginController.login(password: password);
        }),
        TextButton(onPressed: (){
        loginController.logout();
        }, child: Text("Forgot password"))
      ],
    ),
  );
}



Widget rightSetPassword( BuildContext context, LoginController loginController , {required String title}) {

  String password ="";
  String repassword="";

  return Container(
    margin: EdgeInsets.only(top: 28),
    child: Column(
      children: [
        reUsableText(
            name: title,
            color: AppColors.primaryElementText,
            fontSize: 32),
        SizedBox(
          height: 20,
        ),
        inputTextField(
            isPasswordFeild: true,
            hintText: "Enter your password",
            icon: Icon(
              size: 20,
              Icons.lock,
              color: AppColors.primaryElementText,
            ),
            onChange: (value) {
              password = value;
            }),
        SizedBox(
          height: 16,
        ),
        inputTextField(
            isPasswordFeild: true,
            hintText: "Enter your Re-password",
            icon: Icon(
              size: 20,
              Icons.lock,
              color: AppColors.primaryElementText,
            ),
            onChange: (value) {
              repassword = value;
            }),
        SizedBox(
          height: 28,
        ),
        primaryButton(btnName: "Set",onPress: (){
          loginController.setPassword(repassword: repassword, password: password);
        })
      ],
    ),
  );
}


Widget rightGetUser(LoginController loginController , {required String title}) {

  String email ="";

  return Container(
    margin: EdgeInsets.only(top: 56),
    child: Column(

      children: [
        reUsableText(
            name: title,
            color: AppColors.primaryElementText,
            fontSize: 32),
        SizedBox(
          height: 20,
        ),
        inputTextField(
            hintText: "Enter your email",
            icon: Icon(
              size: 20,
              Icons.person,
              color: AppColors.primaryElementText,
            ),
            onChange: (value) {
              email = value;
            }),
        SizedBox(
          height: 16,
        ),

        SizedBox(
          height: 28,
        ),
        primaryButton(btnName: "Get",onPress: () async {
         await loginController.getUserDetails(email);
        })
      ],
    ),
  );
}
