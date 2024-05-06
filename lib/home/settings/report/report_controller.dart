import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tram_win_10/home/settings/report/widgets/recording_widgets.dart';


import '../../../common/entities/data_entity.dart';
import '../../../global.dart';
import 'bloc/report_bloc.dart';

class RecordingSettingController{

  late BuildContext context;

  RecordingSettingController(this.context);


  Future<List<RecordingEntity>> getAllRecordings()async{

   List<RecordingEntity> recordings = await Global.dataBaseService.getAllRecordings();
   recordings.forEach((recording) {
     print('Recording: ${recording.name}');
   });
    return recordings;
  }

  Future<bool> saveRecording() async {

    RecordingBloc bloc = context.read<RecordingBloc>();



    if (bloc.state.recording_name != null && bloc.state.operator_name != null) {
      RecordingEntity recording = RecordingEntity();

      recording.name = bloc.state.recording_name;
      recording.operator = bloc.state.operator_name;
      recording.section = Global.storageService.getSec();
      recording.division = Global.storageService.getDiv();
      recording.zone = Global.storageService.getZone();

      try {
        Global.dataBaseService.insertRecording(recording: recording);

        return true;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> getRecordingData({required String name}) async {
   if(name!=""){

    List<RecordingDataEntity> data = await Global.dataBaseService.getRecordingsForName(name);

   }
  }


  void showRecordingPopup(
      BuildContext context,
      void Function() save
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RecordingPopup(save);
      },
    );
  }

}
