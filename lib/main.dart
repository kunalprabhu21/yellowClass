import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/HomeScreen.dart';
import 'package:flutterapp/screens/LoginScreen.dart';
import 'package:provider/provider.dart';

import 'notifiers/CameraControl.dart';
import 'notifiers/VideoPlayerControl.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [

      ChangeNotifierProvider<VideoPlayerControl>(
        create: (BuildContext context) => VideoPlayerControl(),
      ),
      ChangeNotifierProvider<CameraControl>(
        create: (BuildContext context) => CameraControl(),
      ),
    ],
    child:  MyApp(),
  )
     );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}


