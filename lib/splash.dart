

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kpharma/doctor/doctor_home.dart';
import 'package:kpharma/patient/patienthome.dart';
import 'package:kpharma/shared_pref_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';
import 'selection.dart';

class Splash extends StatefulWidget{
  @override
  State<Splash> createState() => _SplashState();
}


class _SplashState extends State<Splash> {
var usertype;
  @override
  void initState() {
    Check_person();
    super.initState();
  }
  @override

  Check_person() async {
    SharedPreferences pref =await SharedPreferences.getInstance();
    usertype=await pref.getString('usertype');
    print(usertype);
    if(usertype=='doctor'){
      Timer(Duration(seconds: 1),()=>Navigator.pushReplacement(context, Myroute(doctor_home())));
      return;
    }
    if(usertype=='patient'){
      Timer(Duration(seconds: 1),()=>Navigator.pushReplacement(context, Myroute(Patient_home())));
      return;
    }

    if(usertype==null){
      Timer(Duration(seconds: 2),()=>Navigator.pushReplacement(context,Myroute(Selection())));
    }
  }

  Widget build(BuildContext context) {

    var size=MediaQuery.of(context).size;
    return  Scaffold(
        backgroundColor:  myPrimaryColor,
        body:ListView(
          children: [
            Center(child: Container(
                padding: EdgeInsets.only(top:size.height*0.27 ),
                child: Image.asset('images/logo.png',height: size.width*0.8,))),


          ],),

    );
  }
}







