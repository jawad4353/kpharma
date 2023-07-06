






import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kpharma/patient/patientlogin.dart';
import 'package:kpharma/patient/register_patient.dart';
import 'package:kpharma/shared_pref_route.dart';
import 'Database/database.dart';
import 'doctor/doctor_login.dart';
import 'main.dart';

class Verify_OTP extends StatefulWidget
{
  var type,Data;
  Verify_OTP({required this.type,required this.Data});
  @override
  State<Verify_OTP> createState() => _Verify_OTPState();
}

class _Verify_OTPState extends State<Verify_OTP> {
  TextEditingController OTP_controller=new TextEditingController();
  @override
  Widget build(BuildContext context) {

    var size=MediaQuery.of(context).size;
    return  Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(height: size.height,decoration: BoxDecoration(
                  color: myPrimaryColor
              ),),

              Positioned(
                top: 0,
                left: -100,
                child: Transform.rotate(
                    angle: 1.5,
                    child: SvgPicture.asset('images/triangle.svg',height: size.height*0.83,color: Colors.white,)),
              ),
              Positioned(
                top: size.height*0.05,
                right: 30,
                child: Text('Verify',style: TextStyle(fontSize: 45,color: Colors.white,
                    fontWeight: FontWeight.bold,fontFamily: "jd"),),
              ),

              Positioned(
                top: size.height*0.2,
                child: Container(
                  width: size.width*0.73,
                  height: size.height*0.3,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                        cursorHeight: 24,
                        controller: OTP_controller,
                        cursorWidth: 3,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail,color:Color(0XFF0B8FAC),),
                          hintStyle: TextStyle(fontSize: 17),
                          hintText: 'Enter Email code',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),topRight:Radius.circular(10) ),
                              borderSide: BorderSide(color:Color(0XFF0B8FAC),width: 3)
                          ) ,
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),topRight: Radius.circular(10)),
                              borderSide: BorderSide(color: Color(0XFF0B8FAC),)
                          ) ,
                        ),
                      ),

                      Container(
                        width: size.width*0.7,
                        child: ElevatedButton(onPressed: () async {
                          if(OTP_controller.text.isEmpty){
                            EasyLoading.showInfo('Enter Email Code');
                            return;
                          }
                          if(OTP_controller.text!=widget.Data['otp']){
                            EasyLoading.showInfo('Entered Code is Wrong');
                            return;
                          }
                          if(widget.type=='register_patient'){
                            await new database().Register_Patient(widget.Data);
                            Navigator.pushReplacement(context, Myroute(patient_login()));
                          }
                          if(widget.type=='register_doctor'){
                            await new database().Register_doctor(widget.Data);
                            Navigator.pushReplacement(context, Myroute(doctor_login()));
                          }

                        }, child: Text('Verify',style: TextStyle(fontSize: 16,fontFamily: 'Myjd'))),
                      ),


                    ],),
                ),
              ),
              Positioned(
                bottom: size.height*0.14,
                left:size.width*0.36,
                child: Image.asset('images/logo.png',height: size.height*0.15,),
              ),


            ],
          )
        ],
      ),


    );
  }
}