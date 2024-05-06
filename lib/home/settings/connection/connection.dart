import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:tram_win_10/home/settings/connection/widgets/conection_widget.dart';


import '../../../common/values/constants.dart';
import '../../../global.dart';
import '../../bloc/home_bloc.dart';
import '../../home_controller.dart';
import '../widgets/setting_widgets.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});



  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  @override
  Widget build(BuildContext context) {

    HomeController _homeController = HomeController(context);


    String comport = Global.storageService.getComPort();
    String baudrate  = Global.storageService.getBaudrate();


    return SingleChildScrollView(

      child: SettingPageScreens(
          title: "Connection",
          child: Container(
            width: 624,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                ConnectionTile(dataList: SerialPort.availablePorts, hintText:comport, name: "COM Port", onSelect: (value){
                  comport = value;
                }),
                SizedBox(height: 24,),
                ConnectionTile(dataList: ["9600","115200","230400"], hintText:baudrate, name: "Baud Rate", onSelect: (value){
                 baudrate = value;
                }),

                SizedBox(height: 48,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: primaryButton(btnName:"Save",onPress:(){

                        Global.storageService.setComPort(value: comport);
                        Global.storageService.setBuadrate(value: baudrate);


                        _homeController.getPortsAndOpen();

                      }),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
