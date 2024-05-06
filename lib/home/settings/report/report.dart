import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tram_win_10/home/settings/report/bloc/report_bloc.dart';
import 'package:tram_win_10/home/settings/report/genrate_report.dart';
import 'package:tram_win_10/home/settings/report/report_controller.dart';
import 'package:tram_win_10/home/settings/report/widgets/recording_widgets.dart';


import '../../../common/colors/colors.dart';
import '../../../common/entities/data_entity.dart';
import '../../../global.dart';
import '../widgets/setting_widgets.dart';

class Recodrings extends StatefulWidget {
  const Recodrings({super.key});

  @override
  State<Recodrings> createState() => _RecodringsState();
}

class _RecodringsState extends State<Recodrings> {
  late RecordingSettingController _recordingController;

  List<int> OpenIndexes = [];

  List<String> selectedRecordingNames = [];
  bool isMultipleSelected = false;

  @override
  void didChangeDependencies() {
    _recordingController = RecordingSettingController(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SettingPageScreens(
        title: "Report",
        child: Column(
          children: [
            Container(
              child: RecordingHeaderTile(
                  fileName: "File name",
                  zone: "Zone",
                  section: "Section",
                  timeStamp: "Date & Time",
                  context: context),
            ),
            FutureBuilder<List<RecordingEntity>>(
                future: _recordingController.getAllRecordings(),
                builder: (context, snapsot) {
                  if (snapsot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    return Container(
                      margin: EdgeInsets.only(top: 12),
                      height: 236,
                      child: CustomScrollView(
                        slivers: [
                          SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  childCount: snapsot.data == null
                                      ? 0
                                      : snapsot.data?.length,
                                  (context, index){
                                   DateTime dateAndTime = DateTime.parse( snapsot
                                       .data?[index].date_time ??
                                       DateTime.now().toString());
                                    return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (OpenIndexes.contains(snapsot.data![index].id)) {
                                              OpenIndexes.remove(snapsot.data![index].id);
                                              selectedRecordingNames.remove(snapsot.data![index].name);
                                            } else {
                                              OpenIndexes.add(snapsot.data![index].id??0);
                                              selectedRecordingNames.add(snapsot.data![index].name??"");
                                            }

                                            print(OpenIndexes);
                                            print(selectedRecordingNames);

                                            _recordingController.getRecordingData(
                                                name: snapsot.data?[index].name ??
                                                    "");
                                          });
                                        },
                                        child: RecordingTile(
                                            isSelected:
                                            OpenIndexes.contains(snapsot.data![index].id)
                                                ? true
                                                : false,
                                            fileName:
                                            snapsot.data?[index].name ??
                                                "Na",
                                            zone: snapsot.data?[index].zone ??
                                                "Na",
                                            section: snapsot
                                                .data?[index].division ??
                                                "Na",
                                            timeStamp: "${dateAndTime.year}-${dateAndTime.month}-${dateAndTime.day} ${dateAndTime.hour}:${dateAndTime.minute}:${dateAndTime.second}"));
                                  })),
                        ],
                      ),
                    );
                  }
                }),
            Container(
              margin: EdgeInsets.only(top: 12),
              height: 3,
              color: AppColors.primaryElement,

            ),
            Container(
              height: 72,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isMultipleSelected?reUsableText(name: "Please Select one recording to genrate report",color: AppColors.primaryElement,fontSize: 16,fontWeight: FontWeight.bold):Container(),
                  SizedBox(width: 8,),
                  primaryButton(btnName: "Delete",onPress: () async {

                    await Global.dataBaseService.deleteRecordings(OpenIndexes);
                    OpenIndexes=[];

                    setState(()  {

                    });

                  }),
                  SizedBox(width: 8,),
                  primaryButton(btnName: "Report",onPress: (){
                    GenrateReport genrateReport = GenrateReport();
                    print(selectedRecordingNames.length);
                    if(selectedRecordingNames.length==1){
                      genrateReport.SavePdf(selectedRecordingNames.first);
                      isMultipleSelected = false;
                    }else{
                      isMultipleSelected = true;
                    }
                    setState(() {

                    });
                  })
                ],
              ),
            )
          ],
        ));
  }
}
