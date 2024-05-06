import 'package:flutter/material.dart';
import 'package:tram_win_10/home/settings/saathi/widgets/saathi_widgets.dart';


import '../widgets/setting_widgets.dart';

class SaathiPage extends StatefulWidget {
  const SaathiPage({super.key});

  @override
  State<SaathiPage> createState() => _SaathiPageState();
}

class _SaathiPageState extends State<SaathiPage> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: SettingPageScreens(title: "Saathi", child: Container(
        margin: EdgeInsets.only(top: 48),
        child: Column(
          children: [
            SaathiTile(name:"Rx ID",id:"0"),
            SaathiTile(name:"Tx ID",id:"0"),
            SaathiTile(name:"Group ID",id:"0"),
            SizedBox(height: 28,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: primaryButton(btnName:"Save",onPress:(){}),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
