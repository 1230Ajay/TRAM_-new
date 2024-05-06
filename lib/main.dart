


import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';

import 'common/routes/routes.dart';
import 'global.dart';

void main() async {
  // Ensure that the application runs in desktop mode
  if (isDesktop()) {
    // Set the minimum window size
    Global.init();
    WidgetsFlutterBinding.ensureInitialized();
    var initialSize = Size(1280, 860);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.maxSize = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.maximize();
    appWindow.show();


    runApp(const MyApp());
  } else {
    print("This application only supports desktop platforms.");
  }
}

bool isDesktop() {
  return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers:AppPages.allBlocProviders(context), child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      onGenerateRoute: AppPages.GenrRatePageRoute,
      debugShowCheckedModeBanner: false,
    ));
  }
}
