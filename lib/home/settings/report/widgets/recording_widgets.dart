import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/colors/colors.dart';
import '../../../../global.dart';
import '../../../bloc/home_bloc.dart';
import '../../../bloc/home_events.dart';
import '../../widgets/setting_widgets.dart';
import '../bloc/report_bloc.dart';
import '../bloc/report_events.dart';

Widget RecordingHeaderTile(
    {required String fileName,
    required String zone,
    required String section,
    required String timeStamp,
    required BuildContext context}) {
  return Container(
    margin: EdgeInsets.only(bottom: 2),
    color: AppColors.primaryElement,
    height: 36,
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Row(
      children: [
        Expanded(
            child: reUsableText(
                name: fileName,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryElementText)),
        Expanded(
            child: reUsableText(
                name: zone,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryElementText)),
        Expanded(
            child: reUsableText(
                name: section,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryElementText)),
        Expanded(
            child: reUsableText(
                name: timeStamp,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryElementText)),
      ],
    ),
  );
}

Widget RecordingTile({
  required String fileName,
  required String zone,
  required String section,
  required String timeStamp,
  void Function()? onPress,
  required bool isSelected,
}) {
  return Container(
    margin: EdgeInsets.only(top: 8),
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border:
                      Border.all(color: AppColors.primaryElement, width: 1.4)),
              child: Center(
                  child: Container(
                      height: 16,
                      width: 16,
                      child: isSelected
                          ? Icon(
                              color: AppColors.primaryElement,
                              size: 16,
                              Icons.done)
                          : SizedBox())),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: reUsableText(
                    name: fileName, fontSize: 14, fontWeight: FontWeight.w600)),
            Expanded(
                child: reUsableText(
                    name: zone, fontSize: 14, fontWeight: FontWeight.w600)),
            Expanded(
                child: reUsableText(
                    name: section, fontSize: 14, fontWeight: FontWeight.w600)),
            Expanded(
                child: reUsableText(
                    name: timeStamp,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    ),
  );
}

class RecordingPopup extends StatefulWidget {
  final Function() save;

  RecordingPopup(this.save);

  @override
  State<RecordingPopup> createState() => _RecordingPopupState();
}

class _RecordingPopupState extends State<RecordingPopup> {
  @override
  void didChangeDependencies() {
    // TODO: implement
    super.didChangeDependencies();
  }
  


  @override
  Widget build(BuildContext context) {



    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0), // Set border radius here
      ),
      backgroundColor: AppColors.primaryElementText,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          reUsableText(
              name: "Add Recording",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryElement),
          IconButton(
              onPressed: () {
                context.read<HomeBloc>().add(RecordingErrorEvent(""));
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close,
                color: AppColors.primaryElement,
              ))
        ],
      ),
      content: Container(
        width: 400,
        height: 274,
        // padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              onChanged: (value) {
                context.read<RecordingBloc>().add(RecordingNameEvent(value));
              },
              decoration: InputDecoration(
                labelText: 'Enter Recording Name',
                hintStyle: TextStyle(color: AppColors.primaryElement),
              ),
              validator: (value) {
                if (value==null || value =="") {
                  return 'Please enter a value';
                }
                if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value!)) {
                  return 'Only letters and numbers are allowed';
                }
                return null; // Return null if input is valid
              },
            ),
            SizedBox(height: 20),




            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                context.read<HomeBloc>().add(CalibartionForDistanceEvent(context.read<HomeBloc>().state.absolute??0));
                if(value!=""){
                  context
                      .read<HomeBloc>()
                      .add(RelativeDistance(int.parse(value)*100000));
                }else{
                  context
                      .read<HomeBloc>()
                      .add(RelativeDistance(0));
                }
              },
              decoration: InputDecoration(
                labelText: 'Km Start',
                hintStyle: TextStyle(color: AppColors.primaryElement),
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Restricts input to only digits
              validator: (value) {
                if (value==null || value=="") {
                  return 'Please enter a value';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null; // Return null if input is valid
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        context.read<HomeBloc>().add(DirectionEvent("UP"));
                      });
                    },
                    icon: Container(
                      child: Row(
                        children: [Icon(context.read<HomeBloc>().state.direction=="UP"?Icons.radio_button_checked:Icons.radio_button_off_outlined),reUsableText(name: "UP")],
                      ),
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        context.read<HomeBloc>().add(DirectionEvent("DN"));
                      });
                    },
                    icon: Container(
                      child: Row(
                        children: [Icon(context.read<HomeBloc>().state.direction=="DN"?Icons.radio_button_checked:Icons.radio_button_off_outlined),reUsableText(name: "DOWN")],
                      ),
                    ))
              ],
            ),
            reUsableText(name:   context.read<HomeBloc>().state.error??"",color: AppColors.primaryElement),
            SizedBox(height: 20),
            Center(
              child: primaryButton(
                btnName: "Save",
                onPress: () async {
                  if(context.read<RecordingBloc>().state.recording_name!="" &&context.read<RecordingBloc>().state.recording_name!=null &&context.read<HomeBloc>().state.relative!="" &&context.read<HomeBloc>().state.relative!=null){
                    context.read<HomeBloc>().add(RecordingErrorEvent(""));
                    widget.save();
                    Navigator.of(context).pop();
                  }else{
                    context.read<HomeBloc>().add(RecordingErrorEvent("Recoring name & KM start can't be empty"));
                  }
                 setState(() {

                 });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
