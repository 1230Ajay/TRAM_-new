import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:battery_plus/battery_plus.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tram_win_10/home/settings/calibration/bloc/calibration_bloc.dart';
import 'package:tram_win_10/home/settings/calibration/bloc/calibration_events.dart';
import 'package:tram_win_10/home/settings/calibration/bloc/calibration_states.dart';
import 'package:tram_win_10/home/settings/report/bloc/report_bloc.dart';
import 'package:tram_win_10/home/settings/report/bloc/report_events.dart';
import 'package:tram_win_10/home/settings/tolerance/bloc/tolerabce_events.dart';
import 'package:tram_win_10/home/settings/tolerance/bloc/tolerance_bloc.dart';

import '../common/controller/global_controller.dart';
import '../common/entities/data_entity.dart';
import '../global.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_events.dart';

class sysInfo {
  DateTime? dateTime;
  int? battery;
  sysInfo({this.dateTime, this.battery});
}

class HomeController {
  BuildContext context;
  HomeController(this.context);
  AudioPlayer audioPlayer = AudioPlayer();
  Battery battery = Battery();


  Future<void> init() async {
    String tolerance = await Global.storageService.getTolerance();

    Map<String,dynamic> data_t =  jsonDecode(tolerance);
    if(context.mounted){

      context.read<ToleranceBloc>().add(GuageMaxEvent(data_t["gaugeMax"]??5));
      context.read<ToleranceBloc>().add(LevelMaxEvent(data_t["levelMax"]??5));
      context.read<ToleranceBloc>().add(ElevationMaxEvent(data_t["elevationMax"]??500));
      context.read<ToleranceBloc>().add(TempMaxEvent(data_t["temperatureMax"]??35));
      context.read<ToleranceBloc>().add(TwistMaxEvent(data_t["twistMax"]??10));

      context.read<ToleranceBloc>().add(GuageMinEvent(data_t["gaugeMin"]??-5));
      context.read<ToleranceBloc>().add(LevelMinEvent(data_t["levelMin"]??-5));
      context.read<ToleranceBloc>().add(ElevationMinEvent(data_t["elevationMin"]??-500));
      context.read<ToleranceBloc>().add(TempMinEvent(data_t["temperatureMin"]??-5));
      context.read<ToleranceBloc>().add(TwistMinEvent(data_t["twistMin"]??10));

    }


    String calibration = await Global.storageService.getCalibration();
    print("Tolerance : $calibration");
    Map<String,dynamic> data_c =  jsonDecode(calibration);
    if(context.mounted){
      context.read<CalibrationBloc>().add(TriggerGaugeEvent(data_c["gauge"]??0));
      context.read<CalibrationBloc>().add(TriggerLevelEvent(data_c["level"]??0));
      context.read<CalibrationBloc>().add(TriggerAlignmentEvent(data_c["alignment"]??0));
      context.read<CalibrationBloc>().add(TriggerTempEvent(data_c["temp"]??0));
      context.read<CalibrationBloc>().add(TriggerTwistEvent(data_c["twist"]??0));
      context.read<CalibrationBloc>().add(TriggerGradientEvent(data_c["gradient"]??0));
      context.read<CalibrationBloc>().add(TrigerDistanceEvent(Global.storageService.getDistance().toString()??"1"));
      context.read<CalibrationBloc>().add(TriggerUnitEvent(Global.storageService.getUnit()));
    }
  }


  Stream<sysInfo> dateTime() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield sysInfo(
          dateTime: await DateTime.now(),
        battery: 40
        // battery:  await battery.batteryLevel
      );
    }
  }

  Stream<Map<String,dynamic>> getDistances() async*{
     while(true){
     await  Future.delayed(Duration(seconds: 1));
       HomeBloc homeBloc =  context.read<HomeBloc>();
       yield {"abs":homeBloc.state.dataEntity?.speed??0,"rel":homeBloc.state.relative_distance_fo_ui??0};
     }
  }

   Stream<Map<String,dynamic>> getLocationCordinatesLive() async* {
    while(true){
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        print("please enable service to get location");
      }

      permission = await Geolocator.checkPermission();
      if(permission==await LocationPermission.denied){
        permission = await Geolocator.requestPermission();
        if(permission==LocationPermission.denied){
          print("sorry we cant continue because you have denied location permission");
        }
      }

      Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      double long = currentPosition.longitude;
      double lat = currentPosition.latitude;

      context.read<HomeBloc>().add(LattitudeEvent(lat));
      context.read<HomeBloc>().add(LongitudeEvent(long));

      Future.delayed(Duration(seconds:1));
      yield {"lat":lat.toStringAsFixed(6),"long":long.toStringAsFixed(6)};
    }
  }

  Stream<Map<String, dynamic>> getLocation() async* {
    while (true) {
      var location = await Global.storageService.getLocationData();
      if (location != "") {
        Map<String, dynamic> locationJson = jsonDecode(location);
        await Future.delayed(Duration(seconds: 1));
        yield locationJson;
      } else {
        await Future.delayed(Duration(seconds: 1));
        yield {
          "zone": "set zone",
          "division": "set division",
          "section": "set section"
        };
      }
    }
  }

// Import this for utf8.decode

  Stream<DataEntity> readData() async* {
    while (true) {
      // Yield the DataEntity after a 2-second delay
      await Future.delayed(Duration(milliseconds:500));
      yield context.read<HomeBloc>().state.dataEntity??DataEntity(
        gauge: 0,
        level: 0,
        gradient: 0,
        twist: 0,
        temp: 0,
        speed: 0,
      );
    }
  }

  Future<void> getPortsAndOpen() async {
    HomeBloc homeBloc = context.read<HomeBloc>();
    try {

      List<String> ports = SerialPort.availablePorts;

      if (ports.isEmpty) {
        print("No serial ports available.");
        return;
      }

      SerialPort port = SerialPort(Global.storageService.getComPort());

      var config = SerialPortConfig();
      config.baudRate = 115200;

      SerialPortReader reader = SerialPortReader(port,timeout: 10000);

      await port.openReadWrite();

      port.config= config;
      if(port.isOpen){

        Map<String, dynamic> jsonData = {};
        String data = "";

        Stream<String> read_stream = reader.stream.map((event) => String.fromCharCodes(event));

        read_stream.listen((event) {
          data += event;

          // Process complete lines
          while (data.contains('{') && data.contains('}')) {
            int startIndex = data.indexOf('{');
            int endIndex = data.indexOf('}', startIndex);

            if (startIndex >= 0 && endIndex >= 0) {

              String completeLine = data.substring(startIndex, endIndex + 1);
              jsonData = jsonDecode(completeLine);

              double long = homeBloc.state.longitude??0;
              double lat = homeBloc.state.lattitute??0;


              DataEntity _dataEntity = DataEntity();

               CalibrationStates calibrationStates = context.read<CalibrationBloc>().state;

               int calibrationForDistance = homeBloc.state.calibrationForDistance??0;


              _dataEntity.gauge = jsonData["g"]-calibrationStates.gauge;
              _dataEntity.level = calculateLevel(double.parse(jsonData["l"].toString()),jsonData["g"]-calibrationStates.gauge)-calibrationStates.level!.toDouble();
              _dataEntity.temp = jsonData["t"]-calibrationStates.temp;
              _dataEntity.gradient = calculateGradient(toAngle(double.parse(jsonData["e"].toString()))) -calibrationStates.level!.toDouble();
              _dataEntity.speed = jsonData["d"]-calibrationForDistance;
              _dataEntity.latitude =lat;
              _dataEntity.longitude = long;



              // print("using home bloc ------------------- : ${homeBloc.state.calibrationForDistance}  ${homeBloc.state.absolute}");
              // print("using conetext ------------------- : ${context.read<HomeBloc>().state.calibrationForDistance}  ${homeBloc.state.absolute}");

              homeBloc.add(AbsoluteDistance(jsonData["d"].toInt()));

              homeBloc.add(JsonDataEvent(jsonData: _dataEntity));
              data = data.substring(endIndex + 1);

            }
          }
        });
      }else{
       print("an error has occured during port opening");

      }
    } on SerialPortError catch (e) {

      DialogBarForInfoAndAlert(context, title: "Com Port Error", message: "Comport opeing erro has occured",alert: true);
      print("an error has occured during port opening , $e");
      // Handle serial port-related errors
      print("Serial port error occurred:........................................................................................... $e");
    } on FormatException catch (e) {

      DialogBarForInfoAndAlert(context, title: "Json Decode error", message: "Unalbe to decode code to json from please varify data",alert: true);
      // Handle JSON parsing errors
      print("JSON parsing error occurred:............................................................... $e");
    } catch (e){
    DialogBarForInfoAndAlert(context, title: "Something went wrong", message: "",alert: true);
      // Handle other unexpected errors
      print("Unexpected error occurred:.......................................................................... $e");
    }
  }


  double map(double x, double in_min, double in_max, double out_min, double out_max)
  {
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
  }

  double calculateLevel(double analogValue,double gauge){
    double angle = toAngle(analogValue);
    print(analogValue);
    double level = tan(degreesToRadians(angle))*((gauge+1676)/2);
    print("level : $level");
    return level.floorToDouble();
  }

  double toAngle(double value)
  {
    return map(value, 0, 1024, -15, 15);
  }

  double degreesToRadians(double degrees) {
    double radian = degrees * pi / 180;
    // print("radian : $radian");
    return radian;
  }

  bool CheckToPlaySound({required double minValue,required double maxVlue ,required double actualValue}){
    if(actualValue >= minValue && actualValue <= maxVlue){
      playSound(isToPlay: true);
      return true;
    }else{
      playSound(isToPlay: false);
      return false;
    }
  }

  void insertData(RecordingDataEntity _recording_data) async{
    await   Global.dataBaseService.insertRecordingData(recordingData: _recording_data, recordingName: context.read<HomeBloc>().state.selectedRecording??"");
  }

  Future getRecordingName()async{
     String RecordingName =  context.read<HomeBloc>().state.selectedRecording??"";
     List<RecordingEntity>  rc = await Global.dataBaseService.getRecordingByName(RecordingName);

     if(rc.isNotEmpty){
       int relateiveDistance =    await Global.dataBaseService.getLastRelativeDistance(RecordingName);
       if(relateiveDistance!=null && relateiveDistance !=0){
         context.read<HomeBloc>().add(DirectionEvent(rc[0].direction!));
         context.read<HomeBloc>().add(RelativeDistance(relateiveDistance.toDouble()));
       }
     }
  }


  double calculateGradient(double angle){
    print(angle);
    double ten = 1/tan(degreesToRadians(angle));
    print("twist : $ten");
    return ten;
  }



  double calculateRelativeDistance(int cunrrentDistance){
   try{
     String direction =  context.read<HomeBloc>().state.direction??"";
     double currentRelativeDistance = context.read<HomeBloc>().state.relative!;
     if(direction=="UP"){
      double rd = currentRelativeDistance+cunrrentDistance;
      context.read<HomeBloc>().add(RelativeDistanceForUi(rd));
       return rd;
     }else if(direction=="DN"){
       double rd = currentRelativeDistance-cunrrentDistance;
       context.read<HomeBloc>().add(RelativeDistanceForUi(rd));
       return rd;
     }else{
       return -1;
     }
   }catch(e){
     return -1;
   }
  }


  void SaveRecording(){

    String direction= context.read<HomeBloc>().state.direction;
    String km_range= context.read<HomeBloc>().state.relative.toString();
    String recording_name= context.read<RecordingBloc>().state.recording_name??"";

    if(km_range!=null && recording_name!=""){
      RecordingEntity recordingEntity = RecordingEntity();

      recordingEntity.name = recording_name;
      recordingEntity.direction = direction;
      recordingEntity.operator = Global.storageService.getOperatorName();
      recordingEntity.zone = Global.storageService.getZone();
      recordingEntity.division = Global.storageService.getDiv();
      recordingEntity.section = Global.storageService.getSec();

      context.read<HomeBloc>().add(SelectRecording(recording_name));
      context.read<HomeBloc>().add(RelativeDistance(double.parse(km_range)));

      Global.dataBaseService.insertRecording(recording:recordingEntity);

      RecordingDataEntity recordingDataEntity = RecordingDataEntity();

      recordingDataEntity.relative_distance = context.read<HomeBloc>().state.relative.toString();

      Global.dataBaseService.insertRecordingData(recordingData:recordingDataEntity, recordingName: recording_name);

      context.read<RecordingBloc>().add(RecordingNameEvent(""));
    }

  }

  bool toResume(){
    bool toResume = context.read<HomeBloc>().state.toResume!;
    return toResume;
  }


  RecordingDataEntity calculateAverage(List<RecordingDataEntity> data){
    int totalCount = data.length;
    double sumGauge =data.map((e) => double.parse(e.gauge??"0")).reduce((a, b) => a+b);
    double sumLevel =data.map((e) => double.parse(e.level??"0")).reduce((a, b) => a+b);
    double sumGradient =data.map((e) => double.parse(e.gradient??"0")).reduce((a, b) => a+b);
    double sumTemp =data.map((e) => double.parse(e.temp??"0")).reduce((a, b) => a+b);

    RecordingDataEntity recordingDataEntity = RecordingDataEntity();

    recordingDataEntity.gauge = (sumGauge/totalCount).toStringAsFixed(2);
    recordingDataEntity.level = (sumLevel/totalCount).toStringAsFixed(4);
    recordingDataEntity.gradient = (sumGradient/totalCount).toStringAsFixed(2);
    recordingDataEntity.temp = (sumTemp/totalCount).toStringAsFixed(2);

    return recordingDataEntity;

  }

  void playSound({required bool isToPlay}){
     if(isToPlay){
       if(audioPlayer.state ==PlayerState.playing){
         audioPlayer.stop();
       }
     }else{
       audioPlayer.play(AssetSource("audios/warning.mp3"));
     }

  }

  double calculateTwist({required double previous_level, required double level}){
    double distance = Global.storageService.getDistance();
    String unit = Global.storageService.getUnit();
    if(unit=="Meter"){
      return ((previous_level-level)/distance);
    }else{
      double D = distance*0.3048;
      return ((previous_level-level)/D);
    }
  }


}





