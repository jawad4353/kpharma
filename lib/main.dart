import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kpharma/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: 'AIzaSyB96cPeN28QzLNqBvDstiOn2_qgaYxgk6M',
        appId: '1:537113645934:android:006fd3e3ac53fd95bb677f',
        messagingSenderId:'537113645934' ,
        projectId:'kpharma-ac94b' ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: [SystemUiOverlay.bottom,SystemUiOverlay.top]);
  runApp(const MyApp());
}

MaterialColor myPrimaryColor = MaterialColor(
  0XFF0B8FAC,
  <int, Color>{
    50: Color(0XFF0B8FAC),
    100: Color(0XFF0B8FAC),
    200: Color(0XFF0B8FAC),
    300: Color(0XFF0B8FAC),
    400: Color(0XFF0B8FAC),
    500: Color(0XFF0B8FAC),
    600: Color(0XFF0B8FAC),
    700: Color(0XFF0B8FAC),
    800: Color(0XFF0B8FAC),
    900: Color(0XFF0B8FAC),
  },
);

//https://github.com/jawad4353/kpharma.git
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'Kpharma',
      theme: ThemeData(
        primarySwatch: myPrimaryColor,

      ),
      home:  Splash(),
    );
  }
}
