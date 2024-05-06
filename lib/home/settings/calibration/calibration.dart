import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tram_win_10/home/settings/calibration/widgets/calibration_widget.dart';


import '../../../common/colors/colors.dart';
import '../../../common/controller/global_controller.dart';
import '../../../common/entities/calibration.dart';
import '../../../common/values/constants.dart';
import '../../../global.dart';
import '../widgets/setting_widgets.dart';
import 'bloc/calibration_bloc.dart';
import 'bloc/calibration_events.dart';
import 'bloc/calibration_states.dart';
import 'calibration_controller.dart';

class CalibrationPage extends StatefulWidget {
  const CalibrationPage({super.key});

  @override
  State<CalibrationPage> createState() => _CalibrationPageState();
}

class _CalibrationPageState extends State<CalibrationPage> {
  late CalibrationController _calibrationController;

  @override
  void didChangeDependencies() {
    _calibrationController = CalibrationController(context: (context));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalibrationBloc, CalibrationStates>(
        builder: (context, state) {
      return SettingPageScreens(
          title: "Calibration",
          child: Container(
            margin: EdgeInsets.only(left: 12, right: 12),
            child: Column(
              children: [
                CalibrationTile(
                    name: "Gauge",
                    valueText:
                        context.read<CalibrationBloc>().state.gauge.toString(),
                    onChange: (value) {
                      context.read<CalibrationBloc>().add(TriggerGaugeEvent(
                          double.parse(value == "" ? "0" : value)));
                    },
                    decrease: () {
                      setState(() {
                        double value = _calibrationController.decrease(
                            value: state.gauge!);
                        context
                            .read<CalibrationBloc>()
                            .add(TriggerGaugeEvent(value));
                      });
                    },increse: (){
                  setState(() {
                    double value = _calibrationController.increase(
                        value: state.gauge!);
                    context
                        .read<CalibrationBloc>()
                        .add(TriggerGaugeEvent(value));
                  });
                }),
                CalibrationTile(
                    name: "Level",
                    valueText: state.level.toString(),
                    onChange: (value) {
                      context.read<CalibrationBloc>().add(TriggerLevelEvent(
                          double.parse(value == "" ? "0" : value)));
                    },
                    decrease: () {
                      setState(() {
                        double value = _calibrationController.decrease(
                            value: state.level!);
                        context
                            .read<CalibrationBloc>()
                            .add(TriggerLevelEvent(value));
                      });
                    },
                    increse: () {
                      setState(() {
                        double value = _calibrationController.increase(
                            value: state.level!);
                        context
                            .read<CalibrationBloc>()
                            .add(TriggerLevelEvent(value));
                      });
                    }),
                CalibrationTile(
                    name: "Gradient",
                    valueText: state.gradient.toString(),
                    onChange: (value) {
                      context.read<CalibrationBloc>().add(TriggerGradientEvent(
                          double.parse(value == "" ? "0" : value)));
                    },
                    decrease: () {
                      setState(
                        () {
                          double value = _calibrationController.decrease(
                              value: state.gradient!);
                          context
                              .read<CalibrationBloc>()
                              .add(TriggerGradientEvent(value));
                        },
                      );
                    },
                    increse: () {
                      setState(
                        () {
                          double value = _calibrationController.increase(
                              value: state.gradient!);
                          context
                              .read<CalibrationBloc>()
                              .add(TriggerGradientEvent(value));
                        },
                      );
                    }),
                CalibrationTile(
                    name: "Twist",
                    valueText: state.twist.toString(),
                    onChange: (value) {
                      print(value);
                      context.read<CalibrationBloc>().add(TriggerTwistEvent(
                          double.parse(value == "" ? "0" : value)));
                    },
                    decrease: () {
                      setState(() {
                        double value = _calibrationController.decrease(
                            value: state.twist!);
                        context
                            .read<CalibrationBloc>()
                            .add(TriggerTwistEvent(value));
                      });
                    },
                    increse: () {
                      setState(() {
                        double value = _calibrationController.increase(
                            value: state.twist!);
                        context
                            .read<CalibrationBloc>()
                            .add(TriggerTwistEvent(value));
                      });
                    }),
                CalibrationTile(
                    name: "Alignment",
                    valueText: state.alignment.toString(),
                    onChange: (value) {
                      context.read<CalibrationBloc>().add(TriggerAlignmentEvent(
                          double.parse(value == "" ? "0" : value)));
                    },
                    decrease: () {
                      setState(() {
                        double value = _calibrationController.decrease(
                            value: state.alignment!);
                        context
                            .read<CalibrationBloc>()
                            .add(TriggerAlignmentEvent(value));
                      });
                    },
                    increse: () {
                      setState(() {
                        double value = _calibrationController.increase(
                            value: state.alignment!);
                        context
                            .read<CalibrationBloc>()
                            .add(TriggerAlignmentEvent(value));
                      });
                    }),
                CalibrationTile(
                    name: "Tempreture",
                    valueText: state.temp.toString(),
                    onChange: (value) {
                      context.read<CalibrationBloc>().add(TriggerTempEvent(
                          double.parse(value == "" ? "0" : value)));
                    },
                    decrease: () {
                      setState(() {
                        double value =
                            _calibrationController.decrease(value: state.temp!);
                        context
                            .read<CalibrationBloc>()
                            .add(TriggerTempEvent(value));
                      });
                    },
                    increse: () {
                      setState(() {
                        double value =
                            _calibrationController.increase(value: state.temp!);
                        context
                            .read<CalibrationBloc>()
                            .add(TriggerTempEvent(value));
                      });
                    }),
                SizedBox(
                  height: 28,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 18),
                            width: 64,
                            height: 32,
                            color: AppColors.primaryElement,
                            child: TextFormField(
                              style: TextStyle(color: AppColors.primaryElementText,fontWeight: FontWeight.bold,fontSize: 18),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              onChanged: (value){
                                context.read<CalibrationBloc>().add(TrigerDistanceEvent(value));
                                Global.storageService.setDistance(double.parse(value));
                              },
                              keyboardType:TextInputType.number,
                             decoration: InputDecoration(
                               hintText:"${context.read<CalibrationBloc>().state.distance}",
                               hintStyle: TextStyle(color: AppColors.primaryElementText),
                               border: InputBorder.none
                             ),
                            )
                        ),

                        SizedBox(width: 10,),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    Global.storageService.setUnit("Meter");
                                    context.read<CalibrationBloc>().add(TriggerUnitEvent("Meter"));
                                  });
                                },
                                icon: Container(
                                  child: Row(
                                    children: [Icon(context.read<CalibrationBloc>().state.unit=="Meter"?Icons.radio_button_checked:Icons.radio_button_off_outlined),reUsableText(name: " Meter")],
                                  ),
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    Global.storageService.setUnit("Feet");
                                    context.read<CalibrationBloc>().add(TriggerUnitEvent("Feet"));
                                  });
                                },
                                icon: Container(
                                  child: Row(
                                    children: [Icon(context.read<CalibrationBloc>().state.unit!="Meter"?Icons.radio_button_checked:Icons.radio_button_off_outlined),reUsableText(name: " Feet")],
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                    Container(
                      child: primaryButton(
                          btnName: "Save",
                          onPress: () async {
                            CalibrationEntity _caliBrationEnity =
                                CalibrationEntity();
                            _caliBrationEnity.gauge = state.gauge;
                            _caliBrationEnity.level = state.level;
                            _caliBrationEnity.gradient = state.gradient;
                            _caliBrationEnity.twist = state.twist;
                            _caliBrationEnity.temp = state.temp;
                            _caliBrationEnity.alignment = state.alignment;

                            var data = jsonEncode(_caliBrationEnity.toJson());

                            Global.storageService.setString(
                                key: AppConstants.CALIBRATION, value: data);
                           await DialogBarForInfoAndAlert(context,message: "Calibration is successfully saved",title: "Data Saved");
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
