import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tram_win_10/home/settings/tolerance/tolrance_controller.dart';
import 'package:tram_win_10/home/settings/tolerance/widgets/tolerance_widget.dart';


import '../../../common/controller/global_controller.dart';
import '../../../common/entities/tolerance.dart';
import '../../../common/values/constants.dart';
import '../../../global.dart';
import '../widgets/setting_widgets.dart';
import 'bloc/tolerabce_events.dart';
import 'bloc/tolerance_bloc.dart';
import 'bloc/tolerance_states.dart';

class TolerancePage extends StatefulWidget {
  const TolerancePage({super.key});

  @override
  State<TolerancePage> createState() => _TolerancePageState();
}

class _TolerancePageState extends State<TolerancePage> {

  late ToleranceController _toleranceController;


  bool hasRefreshed = false;

  @override
  void initState() {
    super.initState();
    // Call the refresh function after 10 seconds
    Future.delayed(Duration(microseconds: 100), () {
      if (!hasRefreshed) {
        _refreshPage();
      }
    });
  }

  void _refreshPage() {
    // Perform your refresh logic here
    // For example, you can use setState to trigger a rebuild
    setState(() {

      hasRefreshed = true; // Set to true to ensure it only refreshes once
    });
  }


  @override
  void didChangeDependencies() {
     _toleranceController = ToleranceController(context: context);
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ToleranceBloc,ToleranceStates>(builder: (context,state){
      return SettingPageScreens(
          title: "Tolerance",
          child: Container(
            margin: EdgeInsets.only(top: 8, left: 12, right: 12),
            child: Column(
              children: [
                ToleranceHeaderTile(),
                ToleranceTile(
                    name: "Gauge",
                    valueMin: context.read<ToleranceBloc>().state.GaugeMin.toString(),
                    valueMax: context.read<ToleranceBloc>().state.GaugeMax.toString(),

                    onChangeMax: (value) {
                      context.read<ToleranceBloc>().add(
                          GuageMaxEvent(double.parse(value == "" ? "0" : value)));
                    },



                    onChangeMin: (value) {
                      context.read<ToleranceBloc>().add(
                          GuageMinEvent(double.parse(value == "" ? "0" : value)));
                    },

                    decreaseMax: (){
                      setState(() {
                        var value = _toleranceController.decrease(value: state.GaugeMax!);
                        context.read<ToleranceBloc>().add(GuageMaxEvent(value));
                      });
                    },
                    increseMax: (){
                      setState(() {
                        var value = _toleranceController.increase(value: state.GaugeMax!);
                        context.read<ToleranceBloc>().add(GuageMaxEvent(value));
                      });
                    },
                    decreaseMin: (){
                      setState(() {
                        setState(() {
                          var value = _toleranceController.decrease(value: state.GaugeMin!);
                          context.read<ToleranceBloc>().add(GuageMinEvent(value));
                        });
                      });
                    },
                    increseMin: (){
                      setState(() {
                        var value = _toleranceController.increase(value: state.GaugeMin!);
                        context.read<ToleranceBloc>().add(GuageMinEvent(value));
                      });
                    }
                ),
                ToleranceTile(
                    name: "Level",
                    valueMin: context.read<ToleranceBloc>().state.LevelMin.toString(),
                    valueMax:  context.read<ToleranceBloc>().state.LevelMax.toString(),
                    onChangeMax: (value) {
                      context.read<ToleranceBloc>().add(
                          LevelMaxEvent(double.parse(value == "" ? "0" : value)));
                    },
                    onChangeMin: (value) {
                      context.read<ToleranceBloc>().add(
                          LevelMinEvent(double.parse(value == "" ? "0" : value)));
                    },
                    decreaseMax: (){
                      setState(() {
                        var value = _toleranceController.decrease(value: state.LevelMax!);
                        context.read<ToleranceBloc>().add(LevelMaxEvent(value));
                      });
                    },
                    increseMax: (){
                      setState(() {
                        var value = _toleranceController.increase(value: state.LevelMax!);
                        context.read<ToleranceBloc>().add(LevelMaxEvent(value));
                      });
                    },
                    decreaseMin: (){
                      setState(() {
                        var value = _toleranceController.decrease(value: state.LevelMin!);
                        context.read<ToleranceBloc>().add(LevelMinEvent(value));
                      });
                    },
                    increseMin: (){
                      setState(() {
                        var value = _toleranceController.increase(value: state.LevelMin!);
                        context.read<ToleranceBloc>().add(LevelMinEvent(value));
                      });
                    }),
                ToleranceTile(
                    name: "Gradient",
                    valueMin: context.read<ToleranceBloc>().state.ElevationMin.toString(),
                    valueMax: context.read<ToleranceBloc>().state.ElevationMax.toString(),
                    onChangeMax: (value) {
                      context.read<ToleranceBloc>().add(ElevationMaxEvent(
                          double.parse(value == "" ? "0" : value)));
                    },
                    onChangeMin: (value) {
                      context.read<ToleranceBloc>().add(ElevationMinEvent(
                          double.parse(value == "" ? "0" : value)));
                    },
                    decreaseMax: (){
                      setState(() {
                        var value = _toleranceController.decrease(value: state.ElevationMax!);
                        context.read<ToleranceBloc>().add(ElevationMaxEvent(value));
                      });
                    },
                    increseMax: (){
                      setState(() {
                        var value = _toleranceController.increase(value: state.ElevationMax!);
                        context.read<ToleranceBloc>().add(ElevationMaxEvent(value));
                      });
                    },
                    decreaseMin: (){
                      setState(() {
                        var value = _toleranceController.decrease(value: state.ElevationMin!);
                        context.read<ToleranceBloc>().add(ElevationMinEvent(value));
                      });
                    },
                    increseMin: (){
                      setState(() {
                        var value = _toleranceController.increase(value: state.ElevationMin!);
                        context.read<ToleranceBloc>().add(ElevationMinEvent(value));
                      });
                    }),
                ToleranceTile(
                    name: "Twist",
                    valueMin: context.read<ToleranceBloc>().state.TwistMin.toString(),
                    valueMax: context.read<ToleranceBloc>().state.TwistMax.toString(),
                    onChangeMax: (value) {
                      context.read<ToleranceBloc>().add(
                          TwistMaxEvent(double.parse(value == "" ? "0" : value)));
                    },
                    onChangeMin: (value) {
                      context.read<ToleranceBloc>().add(
                          TwistMinEvent(double.parse(value == "" ? "0" : value)));
                    },
                    decreaseMax: (){
                      setState(() {
                        var value = _toleranceController.decrease(value: state.TwistMax!);
                        context.read<ToleranceBloc>().add(TwistMaxEvent(value));
                      });
                    },
                    increseMax: (){
                      setState(() {
                        var value = _toleranceController.increase(value: state.TwistMax!);
                        context.read<ToleranceBloc>().add(TwistMaxEvent(value));
                      });
                    },
                    decreaseMin: (){
                      setState(() {
                        var value = _toleranceController.decrease(value: state.TwistMin!);
                        context.read<ToleranceBloc>().add(TwistMinEvent(value));
                      });
                    },
                    increseMin: (){
                      setState(() {
                        var value = _toleranceController.increase(value: state.TwistMin!);
                        context.read<ToleranceBloc>().add(TwistMinEvent(value));
                      });
                    }),
                ToleranceTile(
                    name: "Teprature",
                    valueMin: context.read<ToleranceBloc>().state.TempMin.toString(),
                    valueMax: context.read<ToleranceBloc>().state.TempMax.toString(),
                    onChangeMax: (value) {
                      context.read<ToleranceBloc>().add(
                          TempMaxEvent(double.parse(value == "" ? "0" : value)));
                    },
                    onChangeMin: (value) {
                      context.read<ToleranceBloc>().add(
                          TempMinEvent(double.parse(value == "" ? "0" : value)));
                    },
                    decreaseMax: (){
                      setState(() {
                        var value = _toleranceController.decrease(value: state.TempMax!);
                        context.read<ToleranceBloc>().add(TempMaxEvent(value));
                      });
                    },
                    increseMax: (){
                      setState(() {
                        var value = _toleranceController.increase(value: state.TempMax!);
                        context.read<ToleranceBloc>().add(TempMaxEvent(value));
                      });
                    },
                    decreaseMin: (){
                      setState(() {
                        var value = _toleranceController.decrease(value: state.TempMin!);
                        context.read<ToleranceBloc>().add(TempMinEvent(value));
                      });
                    },
                    increseMin: (){
                      setState(() {
                        var value = _toleranceController.increase(value: state.TempMin!);
                        context.read<ToleranceBloc>().add(TempMinEvent(value));
                      });
                    }),
                SizedBox(
                  height: 28,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: primaryButton(
                          btnName: "Save",
                          onPress: () async {
                            ToleranceEntity _tolerance = ToleranceEntity();

                            _tolerance.gaugeMax = context.read<ToleranceBloc>().state.GaugeMax;
                            _tolerance.levelMax = context.read<ToleranceBloc>().state.LevelMax;
                            _tolerance.twistMax = context.read<ToleranceBloc>().state.TwistMax;
                            _tolerance.elevationMax = context.read<ToleranceBloc>().state.ElevationMax;
                            _tolerance.temperatureMax = context.read<ToleranceBloc>().state.TempMax;

                            _tolerance.gaugeMin = context.read<ToleranceBloc>().state.GaugeMin;
                            _tolerance.levelMin = context.read<ToleranceBloc>().state.LevelMin;
                            _tolerance.twistMin = context.read<ToleranceBloc>().state.TwistMin;
                            _tolerance.elevationMin = context.read<ToleranceBloc>().state.ElevationMin;
                            _tolerance.temperatureMin = context.read<ToleranceBloc>().state.TempMin;

                            var JsoneData = _tolerance.toJson();

                            String  data = jsonEncode(JsoneData);

                            await Global.storageService.setString(key: AppConstants.TOLERANCE, value: data);

                            DialogBarForInfoAndAlert(context, title:"Data Saved", message: "Tolerance details have been saved");

                          }),
                    ),
                  ],
                )
              ],
            ),
          ));
    });
  }
}
