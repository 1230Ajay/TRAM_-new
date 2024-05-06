import 'package:flutter/material.dart';


import '../../../common/colors/colors.dart';
import '../../../common/routes/names.dart';
import '../../../common/values/constants.dart';
import '../../../global.dart';
import '../calibration/calibration.dart';
import '../connection/connection.dart';
import '../report/report.dart';
import '../saathi/saathi.dart';
import '../tolerance/tolerance.dart';




Widget reUsableText({required String name,Color color=AppColors.primaryText,int fontSize=16,FontWeight fontWeight=FontWeight.normal}){
  return Text(name,style: TextStyle(color: color,fontSize: fontSize.toDouble(),fontWeight: fontWeight),);
}

Widget SettingPage({required int index}){
  List<Widget> settingPage = <Widget>[
    Recodrings(),
    CalibrationPage(),
    TolerancePage(),
    SaathiPage(),
    ConnectionPage()
  ];
  return settingPage[index];
}



Widget SettingPageScreens({required String title,required Widget child }){
  return Container(
    margin: EdgeInsets.only(top: 24,left: 36,right: 36),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 24),
          child: child,
        )
      ],
    ),
  );
}

class MyPopup extends StatefulWidget {
  @override
  _MyPopupState createState() => _MyPopupState();
}

class _MyPopupState extends State<MyPopup> {
  int _selectedIndex = 0; // Track the index of the selected button

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0), // Set border radius here
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        width: 900,
        height: 456,

        child: Stack(
          children: [
            Positioned(
              right: 12,
              top: 12,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  color: AppColors.primaryElement, // Replace with your color
                  size: 24,
                ),
              ),
            ),


            Positioned(
              left: 0,
              top: 48,
              bottom: 0,
              width: 214,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 14),
                    padding: EdgeInsets.only(left: 14),
                    height: 400,
                    child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                             if(index<5) {
                               _selectedIndex = index;
                             }else{
                               Global.storageService.remove(key: AppConstants.PASSWORD);
                               Global.storageService.remove(key: AppConstants.EMAIL);
                               Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.INITIAL, (route) => false);
                             }
                            });

                          },
                          child: Row(
                            children: [
                              buttonListTile(
                                icon: buttonList(color: _selectedIndex == index
                                    ? AppColors.primaryElement
                                    : AppColors.primarySecondaryElementText
                                )[index]["icon"],
                                name: buttonList(color: _selectedIndex == index
                                    ? AppColors.primaryElement
                                    : AppColors.primarySecondaryElementText
                                )[index]["name"],
                                color: _selectedIndex == index
                                    ? AppColors.primaryElement
                                    : AppColors.primarySecondaryElementText,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),


            Positioned(
              left: 200, // Adjust as needed
              top: 32,
              bottom: 0,
              right: 0,
              child: Center(
                child: SettingPage(index: _selectedIndex),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


List<Map<String,dynamic>> buttonList({required Color color}){
  return[ {"icon":Icon(Icons.file_open,color: color,),"name":"Report"},
    {"icon":Icon(Icons.compass_calibration,color: color,),"name":"Calibration"},
    {"icon":Icon(Icons.watch,color: color,),"name":"Tolerance"},
    {"icon":Icon(Icons.handshake,color: color,),"name":"Saathi"},
    {"icon":Icon(Icons.private_connectivity,color: color,),"name":"Connection"},
    {"icon":Icon(Icons.logout,color: color,),"name":"Log Out"}
  ];
}

Widget buttonListTile({required Icon icon,required String name, required Color color}){
  return Container(
    height: 48,
    width: 186,
    child: Row(
      children: [
        icon,
        SizedBox(width: 12,),
        Text(name,style: TextStyle(color: color,fontSize: 18,fontWeight: FontWeight.w500),)
      ],
    ),
  );
}


void showPopup(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    builder: (BuildContext context) {
      return MyPopup();
    }, context: context,
  );
}


Widget   primaryButton({required String btnName,void Function()? onPress}){
  return ElevatedButton(
       style: ElevatedButton.styleFrom(
           backgroundColor: AppColors.primaryElement,
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      onPressed:()=>onPress!() , child: Container(
    width: 72,
    height: 36,
    child: Center(child: reUsableText(name: btnName,color: AppColors.primaryElementText,fontWeight: FontWeight.bold)),
  ));
}


class CustomPopup extends StatelessWidget {
  final String title;
  final String content;

  CustomPopup({required this.title, required this.content});

  Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // You can make this more customizable if needed
  }
}

