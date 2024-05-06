

import '../../common/entities/data_entity.dart';
import '../../common/entities/location.dart';

class HomeStates {
  final bool? isStarted;
  final String? data;

  final int? absolute;
  final double? relative;

  final double? longitude;
  final double? lattitute;
  final DataEntity? dataEntity;
  final String? selectedRecording;
  final String direction;
  final bool? toResume;
  final double? relative_distance_fo_ui;
  final double? twist;

  final String? error;

  final int? calibrationForDistance;

  const HomeStates(
      {this.isStarted = false,
      this.data = "",
      this.dataEntity,
      this.selectedRecording,
      this.relative,
      this.absolute,
      this.longitude ,
      this.lattitute ,
      this.direction = "UP",this.toResume,this.relative_distance_fo_ui,
        this.calibrationForDistance,
        this.error,this.twist
      });

  HomeStates copyWith(
      {bool? isStarted,
      String? data,
      LocationEntity? location,
      DataEntity? dataEntity,
      String? selectedRecodring,
        double? relative,
      int? absolute,
      double? longitude ,
        double? lattitude , String? direction ,bool? toResume,double? relative_distance_fo_ui,
        int? calibrationForDistance,
        String? error,
        double? twist
      }) {


    return HomeStates(
        isStarted: isStarted ?? this.isStarted,
        data: data ?? this.data,
        dataEntity: dataEntity ?? this.dataEntity,
        selectedRecording: selectedRecodring ?? this.selectedRecording,
        relative: relative??this.relative,
        absolute: absolute??this.absolute,
        longitude: longitude??this.longitude,
        lattitute: lattitude ??this.lattitute,
        direction: direction??this.direction,
       toResume: toResume??this.toResume,
      relative_distance_fo_ui: relative_distance_fo_ui??this.relative_distance_fo_ui,
        calibrationForDistance: calibrationForDistance??this.calibrationForDistance,error: error??this.error,twist: twist??this.twist
    );
  }
}
