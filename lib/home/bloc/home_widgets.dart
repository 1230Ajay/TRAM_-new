import 'dart:math';

import 'package:battery_indicator/battery_indicator.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tram_win_10/home/settings/tolerance/bloc/tolerance_bloc.dart';
import 'package:tram_win_10/home/settings/tolerance/bloc/tolerance_states.dart';
import '../../common/colors/colors.dart';
import '../../common/controller/global_controller.dart';
import '../../common/entities/data_entity.dart';
import '../../global.dart';
import '../home_controller.dart';
import '../recording.dart';
import '../settings/report/report_controller.dart';
import '../settings/widgets/setting_widgets.dart';
import 'home_bloc.dart';
import 'home_events.dart';
import 'home_states.dart';

Widget logo() {
  return Container(
    child: Row(
      children: [
        Image.asset(
          "assets/images/indian_railways_logo.png",
          height: 60,
        ),
        SizedBox(
          width: 8,
        ),
        Image.asset(
          "assets/images/tram.png",
          height: 60,
        )
      ],
    ),
  );
}

Widget batteryAndDateTime(dynamic data) {
  return Row(
    children: [
      Text(
        "${data?.dateTime?.year.toString()}-${data?.dateTime?.month.toString()}-${data?.dateTime?.day.toString()} ${data?.dateTime?.hour.toString()}:${data?.dateTime?.minute.toString()}:${data?.dateTime?.second.toString()}",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(width: 12),
      Text(
        "${data.battery.toString()}%",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(width: 8),
      BatteryIndicator(
        batteryLevel: data.battery??0,
        style: BatteryIndicatorStyle.skeumorphism,
        ratio: 1.8,
        showPercentNum: false,
      )
    ],
  );
}

Widget PrimaryButton({required String btnName, void Function()? onPress}) {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.primaryElement,
        borderRadius: BorderRadius.circular(4)),
    height: 42,
    width: 120,
    child: GestureDetector(
      onTap: () => onPress!(),
      child: Center(
        child: Text(
          btnName,
          style: TextStyle(
              color: AppColors.primaryElementText,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
    ),
  );
}

Widget PrimaryToggleButton(
    {required String firstBtnName,
    required String secondBtnName,
    void Function()? onPress,
    required HomeStates state}) {
  return GestureDetector(
    onTap: () {
      onPress!();
    },
    child: Container(
      decoration: BoxDecoration(
          color: AppColors.primaryElement,
          borderRadius: BorderRadius.circular(8)),
      height: 48,
      width: 190,
      child: Center(
        child: Text(
          state.isStarted! ? secondBtnName : firstBtnName,
          style: TextStyle(
              color: AppColors.primaryElementText,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
    ),
  );
}

Widget rightnav(HomeController homeController, BuildContext context) {
  return Row(
    children: [
      StreamBuilder(
        stream: homeController.dateTime(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for data
            return Container();
          } else {
            // If data is available, show the counter value
            return batteryAndDateTime(snapshot.data);
          }
        },
      ),
      SizedBox(
        width: 12,
      ),
      SizedBox(
        width: 12,
      ),
      IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            showPopup(context);
          }),
      SizedBox(
        width: 12,
      ),
      CircleAvatar(
          radius: 24, backgroundColor: Colors.white, child: Winndowbar())
    ],
  );
}

Widget MyAppBar(HomeController homeController, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        logo(),
        rightnav(
          homeController,
          context,
        ),
      ],
    ),
  );
}

Widget Dials(
    {

      required int angle,
    List<String>? numbers,
    required String name,
    String unit = "mm",
    bool isTwoTypeValue = false,
    String valueForLeft = "L",
    String valueForRight = "R",
    required int value,  bool alert=true}) {
  return Container(
    height: 200,
    width: 200,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFCADBEB),
                    Color(0xFFCADBFB),
                  ]),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF3f6080).withOpacity(.2),
                    blurRadius: 32,
                    offset: Offset(40, 20)),
                BoxShadow(
                    color: Color(0xFFFFFFFF),
                    blurRadius: 32,
                    offset: Offset(-20, -10))
              ]),
        ),
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
        Transform.rotate(
          angle: 11.79,
          child: Container(
            constraints: BoxConstraints.expand(),
            child: CustomPaint(
              painter: numbers != null
                  ? ClockPainter(angle: angle, numbers: numbers)
                  : ClockPainter(
                      angle: angle,
                    ),
            ),
          ),
        ),
        Container(
            width: 144,
            height: 144,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:  alert?AppColors.secondaryColor:AppColors.primaryElement.withOpacity(0.7),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 32),
              child: Column(
                children: [
                  Text(
                    isTwoTypeValue
                        ? (value == 0
                            ? value.toString()
                            : value < 0
                                ? "${(value * (-1)).toString()}${valueForLeft}"
                                : "${value.toString()}${valueForRight}")
                        : value.toString(),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: alert?AppColors.primaryText.withOpacity(.9):AppColors.primaryElementText),
                  ),
                  Text(name,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: alert?AppColors.primaryText.withOpacity(.9):AppColors.primaryElementText)),
                  Text(
                    unit,
                    style: TextStyle(fontWeight: FontWeight.bold,color: alert?AppColors.primaryText.withOpacity(.9):AppColors.primaryElementText),
                  )
                ],
              ),
            )),
      ],
    ),
  );
}

Widget Dials2(
    {required int angle,
    List<String>? numbers,
    required String name,
    required String unit,
    bool alert = true
    }) {
  return Container(
    height: 200,
    width: 200,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFCADBEB),
                    Color(0xFFCADBFB),
                  ]),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF3f6080).withOpacity(.2),
                    blurRadius: 32,
                    offset: Offset(40, 20)),
                BoxShadow(
                    color: Color(0xFFFFFFFF),
                    blurRadius: 32,
                    offset: Offset(-20, -10))
              ]),
        ),
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
        Transform.rotate(
          angle: 11.79,
          child: Container(
            constraints: BoxConstraints.expand(),
            child: CustomPaint(
              painter: numbers != null
                  ? ClockPainter2(angle: angle, numbers: numbers)
                  : ClockPainter2(
                      angle: angle,
                    ),
            ),
          ),
        ),
        Container(
            width: 144,
            height: 144,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: alert?AppColors.secondaryColor:AppColors.primaryElement.withOpacity(0.7),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 32),
              child: Column(
                children: [
                  Text(
                    angle.toString(),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: alert?AppColors.primaryText.withOpacity(.9):AppColors.primaryElementText),
                  ),
                  Text(name,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: alert?AppColors.primaryText.withOpacity(.9):AppColors.primaryElementText)),
                  Text(
                    unit,
                    style: TextStyle(fontWeight: FontWeight.bold,color: alert?AppColors.primaryText.withOpacity(.9):AppColors.primaryElementText),
                  )
                ],
              ),
            )),
      ],
    ),
  );
}

Widget dialList({required HomeController controller}) {


  double? previousValue;
  DateTime? previousTime;

  double calculateSpeedPerHour(double valueInCm) {
    // Convert value from centimeters to kilometers
    double valueInKm = valueInCm / 100000.0; // 1 kilometer = 100000 centimeters

    if (previousValue == null || previousTime == null) {
      // Initialize previous value and time
      previousValue = valueInKm;
      previousTime = DateTime.now();
      return 0.0; // Initial speed is 0
    } else {
      // Calculate time difference in hours
      DateTime currentTime = DateTime.now();
      double timeDifferenceHours = currentTime.difference(previousTime!).inMilliseconds / (1000 * 3600);

      // Calculate speed per hour in kilometers per hour
      double speedPerHour = (valueInKm - previousValue!) / timeDifferenceHours;

      // Update previous value and time
      previousValue = valueInKm;
      previousTime = currentTime;

      return speedPerHour;
    }
  }
  return StreamBuilder(
      stream: controller.readData(),
      builder: (context, snapshot) {

        //getting tolerance value from context
       ToleranceStates toleranceStates = context.read<ToleranceBloc>().state;

       double guage_min = toleranceStates.GaugeMin??-5;
       double level_min = toleranceStates.LevelMin??-5;
       double temp_min = toleranceStates.TempMin??-5;
       double gradient_min = toleranceStates.ElevationMin??-500;

       double guage_max = toleranceStates.GaugeMax??5;
       double level_max = toleranceStates.LevelMax??5;
       double temp_max = toleranceStates.TempMax??35;
       double gradient_max = toleranceStates.ElevationMax??-500;

       //cheking value is in range or not
       bool gaugeAlert =  controller.CheckToPlaySound(minValue: guage_min, maxVlue: guage_max, actualValue: snapshot.data == null ? 0 : snapshot.data!.gauge!.toDouble());
       bool levelAlert = controller.CheckToPlaySound(minValue: level_min, maxVlue: level_max, actualValue: snapshot.data == null ? 0 : snapshot.data!.level!.toDouble());
       bool tempAlert = controller.CheckToPlaySound(minValue: temp_min, maxVlue: temp_max, actualValue: snapshot.data == null ? 0 : snapshot.data!.temp!.toDouble());
       bool gradientAlert = controller.CheckToPlaySound(minValue:gradient_min, maxVlue: gradient_max, actualValue: snapshot.data == null ? 0 : snapshot.data!.gradient!);

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 60),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Dials(
                      value: snapshot.data == null ? 0 : snapshot.data!.gauge!.toInt(),
                      angle: snapshot.data == null ? 0 : snapshot.data!.gauge!.toInt(),
                      name: "GAUGE",
                      alert:gaugeAlert
                  ),
                  Dials(
                      value: snapshot.data == null ? 0 : snapshot.data!.level!.toInt(),
                      angle: snapshot.data == null ? 0 : snapshot.data!.level!.toInt(),
                      name: "LEVEL",
                      isTwoTypeValue: true,
                      alert: levelAlert
                  ),
                  Dials(
                      alert: gradientAlert,
                      value: snapshot.data == null
                          ? 0
                          : snapshot.data!.gradient!.toInt(),
                      angle:
                          snapshot.data == null ? 0 : -snapshot.data!.gradient!.toInt(),
                      numbers: [
                        "  -1.5k",
                        "-1k",
                        "-0.5k",
                        "   0",
                        "0.5k",
                        "1k",
                        "1.5k"
                      ],
                      name: "GRADIENT",
                      unit: "Meter",
                      isTwoTypeValue: true,
                      valueForLeft: "F",
                      valueForRight: "R"),
                ],
              ),
              SizedBox(
                height: 72,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Dials(
                      value:context.read<HomeBloc>().state.twist?.toInt()??0,
                      angle: context.read<HomeBloc>().state.twist == null
                          ? 0
                          : context.read<HomeBloc>().state.twist!.toInt() - 15,
                      numbers: [
                        "  0",
                        "    5",
                        "10",
                        " 15",
                        "   20",
                        " 25",
                        "30"
                      ],
                      name: "TWIST",
                      unit: "mm/M"),
                  Dials2(
                    alert: tempAlert,
                      angle: snapshot.data == null ? 0 : snapshot.data!.temp!.toInt(),
                      numbers: [
                        " -5",
                        "15",
                        "25",
                        " 35",
                        "   45",
                        " 55",
                        "65",
                        " 75",
                        " 85",
                        "95"
                      ],
                      name: "TEMP",
                      unit: "°C"),
                  Dials2(
                      angle: calculateSpeedPerHour(snapshot.data?.speed?.toDouble()??0).toInt(),
                      numbers: [
                        "  0",
                        "10",
                        "20",
                        " 30",
                        "   40",
                        " 50",
                        "60",
                        " 70",
                        " 80",
                        " 90"
                      ],
                      name: "SPEED",
                      unit: "KM/H"),
                ],
              ),
            ],
          ),
        );
      });
}

class ClockPainter extends CustomPainter {
  int angle;
  List<String> numbers;
  ClockPainter(
      {this.angle = 0,
      this.numbers = const [
        "  -15",
        "-10",
        "-5",
        "   0",
        "    5",
        " 10",
        "15"
      ]});

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    double radius = min(centerX + 38, centerY + 38);
    double OuterRadius = radius - 20;
    double InnerRatius = radius - 32;

    Paint DashPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 271; i += 45) {
      double x1 = centerX - OuterRadius * cos(i * pi / 180);
      double y1 = centerX - OuterRadius * sin(i * pi / 180);

      double x2 = centerX - InnerRatius * cos(i * pi / 180);
      double y2 = centerX - InnerRatius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), DashPaint);
    }

    Paint InnerDashPaint = Paint()
      ..color = AppColors.primaryText
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 270; i += 9) {
      double x1 = centerX - OuterRadius * .95 * cos(i * pi / 180);
      double y1 = centerX - OuterRadius * .95 * sin(i * pi / 180);

      double x2 = centerX - InnerRatius * cos(i * pi / 180);
      double y2 = centerX - InnerRatius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), InnerDashPaint);
    }

    final double angleStep = 360 / 8.2;

    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < numbers.length; i++) {
      final double angle = 3.195 + i * angleStep * pi / 180;
      final double x = (centerX + 3) + radius * cos(angle);
      final double y = (centerY - 4) + radius * sin(angle);

      final double textX = x - 10; // Adjust text position
      final double textY = y - 10; // Adjust text position

      textPainter.text = TextSpan(
        text: numbers[i],
        style: TextStyle(fontSize: 16.0, color: AppColors.primaryText),
      );

      textPainter.layout();

      // Wrap TextPainter with Transform.rotate to apply rotation
      canvas.save();
      canvas.translate(textX, textY);
      canvas.rotate(.75); // Use the angle to rotate the text
      textPainter.paint(canvas, Offset(0, 0));
      canvas.restore();
    }

    double rotate = 15 + angle.toDouble();

    Paint secLinePaint = Paint()
      ..color = AppColors.primaryElement
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    Offset secStartOffset = Offset(
      centerX - 20 * cos(rotate * 9 * pi / 180),
      centerY - 20 * sin(rotate * 9 * pi / 180),
    );

    Offset secEndOffset = Offset(
      centerX - (OuterRadius - 34) * cos(rotate * 9 * pi / 180),
      centerY - (OuterRadius - 34) * sin(rotate * 9 * pi / 180),
    );

    Paint centerCireclePaint = Paint()..color = Color(0xFFE81466);

    canvas.drawLine(secStartOffset, secEndOffset, secLinePaint);
    canvas.drawCircle(center, 12, centerCireclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ClockPainter2 extends CustomPainter {
  int angle;
  List<String> numbers;
  ClockPainter2(
      {this.angle = 0,
      this.numbers = const [
        "  -15",
        "-10",
        "-5",
        "  0",
        "    5",
        " 10",
        "15"
      ]});

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    double radius = min(centerX + 38, centerY + 38);
    double OuterRadius = radius - 20;
    double InnerRatius = radius - 32;

    Paint DashPaint = Paint()
      ..color = AppColors.primaryText
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 271; i += 30) {
      double x1 = centerX - OuterRadius * cos(i * pi / 180);
      double y1 = centerX - OuterRadius * sin(i * pi / 180);

      double x2 = centerX - InnerRatius * cos(i * pi / 180);
      double y2 = centerX - InnerRatius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), DashPaint);
    }

    Paint InnerDashPaint = Paint()
      ..color = AppColors.primaryText
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 270; i += 3) {
      double x1 = centerX - OuterRadius * .95 * cos(i * pi / 180);
      double y1 = centerX - OuterRadius * .95 * sin(i * pi / 180);

      double x2 = centerX - InnerRatius * cos(i * pi / 180);
      double y2 = centerX - InnerRatius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), InnerDashPaint);
    }

    final double angleStep = 360 / 12;

    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < numbers.length; i++) {
      final double angle = 3.115 + i * angleStep * pi / 180;
      final double x = (centerX + 3) + radius * cos(angle);
      final double y = (centerY - 4) + radius * sin(angle);

      final double textX = x - 10; // Adjust text position
      final double textY = y - 10; // Adjust text position

      textPainter.text = TextSpan(
        text: numbers[i],
        style: TextStyle(fontSize: 16.0, color: AppColors.primaryText),
      );

      textPainter.layout();

      // Wrap TextPainter with Transform.rotate to apply rotation
      canvas.save();
      canvas.translate(textX, textY);
      canvas.rotate(.75); // Use the angle to rotate the text
      textPainter.paint(canvas, Offset(0, 0));
      canvas.restore();
    }

    double rotate = angle.toDouble();

    Paint secLinePaint = Paint()
      ..color = AppColors.primaryElement
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    Offset secStartOffset = Offset(
      centerX - 20 * cos(rotate * 3 * pi / 180),
      centerY - 20 * sin(rotate * 3 * pi / 180),
    );

    Offset secEndOffset = Offset(
      centerX - (OuterRadius - 34) * cos(rotate * 3 * pi / 180),
      centerY - (OuterRadius - 34) * sin(rotate * 3 * pi / 180),
    );

    Paint centerCireclePaint = Paint()..color = Color(0xFFE81466);

    canvas.drawLine(secStartOffset, secEndOffset, secLinePaint);
    canvas.drawCircle(center, 12, centerCireclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class MyFooter extends StatefulWidget {
  final RecordingController recordingController;
  final HomeController homeController;
  final HomeStates homeState;

  const MyFooter({super.key,required this.homeState,required this.recordingController,required this.homeController});

  @override
  State<MyFooter> createState() => _MyFooterState();
}

class _MyFooterState extends State<MyFooter> {


  @override
  Widget build(BuildContext context) {
    double  actual_distance = 0;


    double distance_to_insert = 0;

    List<RecordingDataEntity> dataToInsert = <RecordingDataEntity>[];

    double foot = 30.48;
    double meter = 100;

    double previous_distance = 0;

    double previous_level = 0 ;

    double diffrence_distance = Global.storageService.getDistance();
    String unit = Global.storageService.getUnit();
    return Container(
      margin: EdgeInsets.only(left: 6, right: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/rki_logo.png",
            height: 56,
            width: 340,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ZONE : ${Global.storageService.getZone()}",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "DIV : ${Global.storageService.getDiv()}",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SECTION : ${Global.storageService.getSec()}",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "OPERATOR : ${Global.storageService.getOperatorName()}",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          SizedBox(
            child: IconButton(
                icon: Icon(Icons.share_location_outlined),
                onPressed: () {
                  showInputPopup(context, onSave: (value) async {
                    DialogBarForInfoAndAlert(context,
                        title: "Data Saved",
                        message: "RDPS Details have Saved");
                  }, name: 'RDPS');
                }),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                stream: widget.recordingController.stream,
                builder: (context, snapshot) {


                  RecordingDataEntity _recording_data =
                  RecordingDataEntity();

                  if (snapshot.data != null) {

                    if (snapshot.data?.speed != null) {

                      if(snapshot.data!.speed!>=actual_distance){

                        actual_distance = actual_distance+15.24;



                        _recording_data.gauge = snapshot.data?.gauge?.toString();
                        _recording_data.level = snapshot.data?.level?.toString();
                        _recording_data.gradient = snapshot.data?.gradient?.toString();
                        _recording_data.temp = snapshot.data?.temp?.toString();


                        dataToInsert.add(_recording_data);

                        if(snapshot.data!.speed!>=distance_to_insert){



                          RecordingDataEntity data = widget.homeController.calculateAverage(dataToInsert);

                          double twist = widget.homeController.calculateTwist(previous_level: previous_level,level:double.parse(data.level??"0"));

                          double rd  =  widget.homeController.calculateRelativeDistance((snapshot.data?.speed??0));
                          data.actual_distance = (snapshot.data?.speed??0).toString();
                          data.relative_distance =rd.toString();
                          data.twist = twist.toStringAsFixed(2);
                          data.recording_name = "";
                          data.longitude = snapshot.data?.longitude.toString();
                          data.latitude = snapshot.data?.latitude.toString();

                          widget.homeController.insertData(data);

                          context.read<HomeBloc>().add(TwistEvent(twist));
                          print("------------------------------------tiwst have calcualted: $twist");

                          if(unit=="Feet"){
                            distance_to_insert = distance_to_insert +diffrence_distance*foot;
                          }else{
                            distance_to_insert = distance_to_insert +diffrence_distance*meter;
                          }

                          previous_level = double.parse(data.level??"0");
                          previous_distance = double.parse(data.distance??"0");
                          dataToInsert.clear();
                        }

                      }
                    }
                  }


                  return Text('');
                },
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  if (widget.recordingController.streamPaused) {

                    showRecordingStartPopup(context, () async {
                      if(widget.homeController.toResume()){
                        context.read<HomeBloc>().add(CalibartionForDistanceEvent(context.read<HomeBloc>().state.absolute??0));
                        context.read<HomeBloc>().add(AbsoluteDistance(0));
                        print("----------------------------------${context.read<HomeBloc>().state.calibrationForDistance}--------------------------------");
                        await   widget.homeController.getRecordingName();

                        widget.recordingController.toggleStream();

                        setState(() {
                            print("state has changed");
                        });

                        print("using conetext ------------------- : ${context.read<HomeBloc>().state.calibrationForDistance}");



                      }else if(widget.homeController.toResume()==false){
                        context.read<HomeBloc>().add(CalibartionForDistanceEvent(context.read<HomeBloc>().state.absolute??0));
                        context.read<HomeBloc>().add(AbsoluteDistance(0));
                        print("----------------------------------${context.read<HomeBloc>().state.calibrationForDistance}");
                        setState(() {
                          print("state has changed");
                        });


                        print("using conetext ------------------- : ${context.read<HomeBloc>().state.calibrationForDistance}");


                        widget.homeController.SaveRecording();
                        widget.recordingController.toggleStream();

                      }


                    });

                  } else {
                    widget.recordingController.toggleStream();

                    setState(() {
                      print("state has changed");
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: widget.recordingController.streamPaused
                          ? AppColors.primaryElement.withOpacity(.5)
                          : AppColors.primaryElement,
                      borderRadius: BorderRadius.circular(4)),
                  padding:
                  EdgeInsets.symmetric(horizontal: 28, vertical: 3),
                  child: Text(
                    widget.recordingController.streamPaused ? 'START' : 'STOP',
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.primaryElementText),
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}





Widget rightHome(HomeController homeController) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Container(
        // color: Colors.red,
        height: 200,
        width: 200,
        child: Center(
          child: Text("Live Video Recording"),
        ),
      ),
      Container(
        width: 200,
        child: Column(
          children: [
            Text(
              "GPS CORDINATES",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Lattitude",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Longitude",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            StreamBuilder(
                stream: homeController.getLocationCordinatesLive(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Container(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator()));
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            color: AppColors.primaryElement,
                            width: 88,
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Center(
                                child: Text(
                              snapshot.data?["lat"] ?? "...",
                              style: TextStyle(
                                  color: AppColors.primaryElementText,
                                  fontWeight: FontWeight.bold),
                            ))),
                        Container(
                            color: AppColors.primaryElement,
                            width: 88,
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Center(
                                child: Text(snapshot.data?["long"]?? "...",
                                    style: TextStyle(
                                        color: AppColors.primaryElementText,
                                        fontWeight: FontWeight.bold)))),
                      ],
                    );
                  }
                }),
            SizedBox(
              height: 48,
            ),
            Text("DISTANCE",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Absolute(km)", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Relative(km)", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 8,
            ),


            StreamBuilder(stream:homeController.getDistances() , builder: (context,snapsot){
              if(snapsot.hasData){
                return  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        color: AppColors.primaryElement,
                        width: 88,
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Center(
                            child: Text("${(snapsot.data?["abs"]/100000).toStringAsFixed(3)}",
                                style: TextStyle(
                                    color: AppColors.primaryElementText,
                                    fontWeight: FontWeight.bold)))),
                    Container(
                        color: AppColors.primaryElement,
                        width: 88,
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Center(
                            child: Text("${(snapsot.data?["rel"]/100000).toStringAsFixed(3)}",
                                style: TextStyle(
                                    color: AppColors.primaryElementText,
                                    fontWeight: FontWeight.bold)))),
                  ],
                );
              }
              return  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      color: AppColors.primaryElement,
                      width: 88,
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Center(
                          child: Text("NA",
                              style: TextStyle(
                                  color: AppColors.primaryElementText,
                                  fontWeight: FontWeight.bold)))),
                  Container(
                      color: AppColors.primaryElement,
                      width: 88,
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Center(
                          child: Text("NA",
                              style: TextStyle(
                                  color: AppColors.primaryElementText,
                                  fontWeight: FontWeight.bold)))),
                ],
              );
            }),


          ],
        ),
      ),
    ],
  );
}

Widget Winndowbar() {
  return WindowTitleBarBox(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: MoveWindow()),
        CloseWindowButton(
          colors: WindowButtonColors(
              mouseOver: Colors.transparent,
              mouseDown: Colors.transparent,
              iconNormal: AppColors.primaryText,
              iconMouseOver: AppColors.primaryText),
        ),
      ],
    ),
  );
}

class RecordingPopupSetting extends StatefulWidget {
  final Function() save;

  RecordingPopupSetting(this.save);

  @override
  State<RecordingPopupSetting> createState() => _RecordingPopupState();
}

class _RecordingPopupState extends State<RecordingPopupSetting> {
  @override
  void didChangeDependencies() {
    // TODO: implement
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool toResume = false;
    RecordingSettingController recordingSettingController =
        RecordingSettingController(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0), // Set border radius here
      ),
      backgroundColor: AppColors.primaryElementText,
      content: Container(
        width: 488,
        height: 60,
        // padding: EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            primaryButton(
              btnName: "NEW",
              onPress: () async {
                Navigator.of(context).pop();

                context.read<HomeBloc>().add(ToResumeEvent(false));
                recordingSettingController.showRecordingPopup(context,await widget.save);
              },
            ),
            primaryButton(
              btnName: "RESUME",
              onPress: () async {
                print("resume from root resume is working : ---------------------------");
                Navigator.of(context).pop();

                context.read<HomeBloc>().add(ToResumeEvent(true));
                 showRecordingResumePopup(context,await widget.save);
              },
            ),
            primaryButton(
              btnName: "CANCEL",
              onPress: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

void showRecordingStartPopup(BuildContext context, void Function() save) {
  showDialog(
    barrierColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return RecordingPopupSetting(save);
    },
  );
}

class RecordingPopupResume extends StatefulWidget {
  final Function() save;

  RecordingPopupResume(this.save);

  @override
  State<RecordingPopupResume> createState() => _RecordingPopupResumeState();
}

class _RecordingPopupResumeState extends State<RecordingPopupResume> {
  @override
  void didChangeDependencies() {
    // TODO: implement
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool toResume = false;
    RecordingSettingController recordingSettingController =
        RecordingSettingController(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0), // Set border radius here
      ),
      backgroundColor: Colors.white.withOpacity(0.0),
      content: Container(
        height: 200,
        width: 600,
        child: _recodingResume(widget.save),
      ),
    );
  }
}

void showRecordingResumePopup(BuildContext context, void Function() save) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return RecordingPopupResume(save);
    },
  );
}

class _recodingResume extends StatefulWidget {

  final void Function() save;

  const _recodingResume(this.save, {super.key});

  @override
  State<_recodingResume> createState() => _recordingResumerState();
}

class _recordingResumerState extends State<_recodingResume> {
  bool isOpen = false;
  late RecordingSettingController recordingController;
  late RecordingController rc;
  @override
  void didChangeDependencies() {
    recordingController = RecordingSettingController(context);
    rc = RecordingController(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.primaryElementText.withOpacity(0.8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isOpen = !isOpen;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                          color: AppColors.primaryElementText,
                          borderRadius: BorderRadius.circular(4)),
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reUsableText(
                            name: context
                                    .read<HomeBloc>()
                                    .state
                                    .selectedRecording ??
                                "Select Recording",
                          ),
                          Icon(isOpen
                              ? Icons.keyboard_arrow_up_outlined
                              : Icons.keyboard_arrow_down_outlined)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: PrimaryButton(

                      onPress: (){

                        print("pressing save button : -------------------------------------");
                        widget.save();
                        Navigator.of(context).pop();
                      },
                      btnName: "Resume",
                    ),
                  )
                ],
              ),
            ),
          ),
          isOpen
              ? FutureBuilder(future: recordingController.getAllRecordings(), builder: (context,snapshot){
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 13),
                  width: 400,
                  height: 100,
                  child: ListView.builder(
                      itemCount: snapshot.data?.length??0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              isOpen = !isOpen;
                              context
                                  .read<HomeBloc>()
                                  .add(SelectRecording(snapshot.data![index].name??""));
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 2),
                            decoration: BoxDecoration(
                                color: AppColors.primaryElementText),
                            child: reUsableText(name: snapshot.data![index].name??""),
                          ),
                        );
                      }),
                );
          })
              : Container()
        ],
      ),
    );
  }
}
