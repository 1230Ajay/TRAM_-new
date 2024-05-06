import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tram_win_10/login_page/widgets/loging_widgets.dart';

import '../common/colors/colors.dart';
import 'login_controller.dart';

class SetPassowrdpage extends StatefulWidget {
  const SetPassowrdpage({super.key});

  @override
  State<SetPassowrdpage> createState() => _SetPassowrdpageState();
}

class _SetPassowrdpageState extends State<SetPassowrdpage> {

  late LoginController loginController;

  @override
  void didChangeDependencies() {
    loginController = LoginController(context);
    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryText.withOpacity(0.3),
              boxShadow: [
                BoxShadow(
                  color:Colors.grey.withOpacity(0.7),
                  offset:Offset(0,1),
                  spreadRadius: 2,
                  blurRadius:4,
                )
              ],
            ),
            child: Stack(
              children: [
                Container(
                  height: 360,
                  width: 620,
                  decoration: BoxDecoration(color: AppColors.primaryElement),
                  child: SizedBox(),
                ),
                Container(
                  height: 312,
                  width: 620,
                  decoration: BoxDecoration(
                      color: AppColors.primaryText,
                      borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(160))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [leftLogin(icon:  Icon(Icons.lock,color: AppColors.primaryElementText,size: 120,)), rightSetPassword(context,loginController,title: "Set Password")],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );;
  }
}
