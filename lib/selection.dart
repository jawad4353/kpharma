



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kpharma/patient/patientlogin.dart';
import 'package:kpharma/shared_pref_route.dart';
import 'package:kpharma/sharedpref_validations.dart';
import 'package:lottie/lottie.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:proste_bezier_curve/utils/type/index.dart';

import 'doctor/doctor_home.dart';
import 'doctor/doctor_login.dart';
import 'main.dart';

class Selection extends StatefulWidget{
  @override
  State<Selection> createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {

  var selected;
  @override
  Widget build(BuildContext context) {
    Customize_Easyloading();
    var size=MediaQuery.of(context).size;
   return Scaffold(
     backgroundColor:  myPrimaryColor,
    body: ListView(children: [
      Stack(children: [
        Container(
            color:Colors.white,child: Image.asset('images/loginpattern.png')),
        ClipPath(
          clipper: ProsteBezierCurve(
            position: ClipPosition.bottom,
            list: [
              BezierCurveSection(
                start: Offset(0, size.height*0.4),
                top: Offset(size.width/ 2, size.height*0.47),
                end: Offset(size.width, size.height*0.4),
              ),
            ],
          ),
          child: Container(
            height: size.height*0.5,
            color: Colors.white,
            child:  Image.asset('images/selection.png',height: size.height*0.4,),
          ),
        ),
      ],),


      SizedBox(height: 5,),
      Center(child: Text('Which one are you ?',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),)),
      Padding(
        padding:  EdgeInsets.only(right: size.width*0.1,left: size.width*0.1),
        child: Center(child: Text('Choose either you are a Doctor or a Patient .So that we will move further to the next screens',style: TextStyle(fontSize: 16,color: Colors.white),)),
      ),
      SizedBox(height: 5,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Transform.scale(
          scale: 1.2,
          child: Radio(
              value:selected ,
              fillColor: MaterialStateProperty.resolveWith((states) => Colors.white),
              activeColor:selected==1?  Colors.white :  myPrimaryColor,
              groupValue: 1,
              onChanged: (a){
                setState(() {
                  selected=1;
                });
              }),
        ),
        Text('Doctor',style: TextStyle(fontSize:selected==1? 19:17,color:Colors.white,fontWeight: FontWeight.w500)),

        SizedBox(width: 30,),
        Transform.scale(
          scale: 1.2,
          child: Radio(
              value:selected ,
              fillColor: MaterialStateProperty.resolveWith((states) => Colors.white),
              activeColor:selected==2?  Colors.white :  myPrimaryColor,
              groupValue: 2,
              onChanged: (a){
                setState(() {
                  selected=2;
                });
              }),
        ),
        Text('Patient',style: TextStyle(fontSize:selected==2? 19:17,color:Colors.white,fontWeight: FontWeight.w500))
      ],),


         Padding(
           padding:  EdgeInsets.only(top: 20,left: size.width*0.12,right: size.width*0.12),
           child: ElevatedButton(
               style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
               onPressed: (){
             selected==2 ?  Navigator.pushReplacement(context, Myroute(patient_login())): Navigator.pushReplacement(context, Myroute( doctor_login()));

           }, child: Text("'Let's Start",style: TextStyle(color: myPrimaryColor),)),
         )


    ],),
   );
  }
}






