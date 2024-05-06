
import 'package:flutter/material.dart';

import '../../../../common/colors/colors.dart';
import '../../widgets/setting_widgets.dart';

class ConnectionTile extends StatefulWidget {
  List<dynamic> dataList;
  String hintText;
  String name;
  Function(String value) onSelect;



  ConnectionTile(
      {super.key,
        required this.dataList,
        required this.hintText,
        required this.name,
        required this.onSelect,
     });

  @override
  State<ConnectionTile> createState() => _conectionTileState();
}

class _conectionTileState extends State<ConnectionTile> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

           Container(
                margin: EdgeInsets.only(bottom: 12),
                width: 200,
                child: reUsableText(name: "${widget.name} :",color: AppColors.primarySecondaryElementText,fontWeight: FontWeight.w500,fontSize: 18),),

           GestureDetector(
                onTap: () {
                  setState(() {
                   isOpen=!isOpen;
                  });
                },
                child: Container(
                  width: 600,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      reUsableText(
                          name: widget.hintText,
                          color: AppColors.primarySecondaryElementText,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                      Container(
                        child: Icon(Icons.keyboard_arrow_down),
                      )
                    ],
                  ),
                ),
              ),
              isOpen
                  ? Container(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      height: 100,
                      child: SingleChildScrollView(
                        child: ListView.builder(
                            primary: true,
                            shrinkWrap: true,
                            itemCount: widget.dataList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    widget
                                        .onSelect(widget.dataList[index]);
                                    setState(() {
                                      widget.hintText =
                                          widget.dataList[index];
                                      isOpen = !isOpen;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 12),
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color:AppColors.primaryElementText,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.secondaryColor,
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                        )
                                      ],
                                    ),
                                    child: reUsableText(
                                        name: widget.dataList[index],
                                        fontWeight: FontWeight.w500,
                                        color: AppColors
                                            .primarySecondaryElementText),
                                  ));
                            }),
                      ),
                    ),
                  ],
                ),
              )
                  : Container()
            ],
          ),
        ),
      ],
    );
  }
}


// Function to show the reusable popup
