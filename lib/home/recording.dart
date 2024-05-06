import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../common/entities/data_entity.dart';
import 'bloc/home_bloc.dart';

class RecordingController {
  late StreamController<DataEntity> _streamController;
  late Stream<DataEntity> _stream;
  late bool streamPaused = true;
  BuildContext context;

  RecordingController(this.context) {
    _streamController = StreamController<DataEntity>();
    _stream = _streamController.stream;

    // Initially, start emitting data to the stream.
    _startStream();
  }

  Stream<DataEntity> get stream => _stream;

  void _startStream() {
    // Simulated data emitting every 1 second.
    Timer.periodic(Duration(milliseconds:20), (timer) {
      if (!streamPaused) {
        _streamController.add(context.read<HomeBloc>().state.dataEntity??DataEntity());
      }
    });
  }

  void toggleStream() {
    print("toggle strea is called..................................");
    streamPaused = !streamPaused;
  }

  void dispose() {
    _streamController.close();
  }
}
