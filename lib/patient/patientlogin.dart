

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kpharma/patient/patienthome.dart';
import 'package:kpharma/patient/register_patient.dart';
import '../Database/database.dart';
import '../main.dart';
import '../sharedpref_validations.dart';
import '../VerifyOTP.dart';
import '../forgotpassword.dart';
import '../shared_pref_route.dart';



class patient_login extends StatefulWidget{
  @override
  State<patient_login> createState() => _patient_loginState();
}



class _patient_loginState extends State<patient_login> {

  TextEditingController password=new TextEditingController();
  TextEditingController cnic=new TextEditingController();
  var Cnic_text,Cnic_color,Password_text,Password_color;
  bool hide_password=true;

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
                top: -50,
                left: -100,
                child: Transform.rotate(
                    angle: 1.5,
                    child: SvgPicture.asset('images/triangle.svg',height: size.height*0.83,color: Colors.white,)),
              ),
              Positioned(
                top: size.height*0.05,
                right: 30,
                child: Text('Login',style: TextStyle(fontSize: 45,color: Colors.white,
                    fontWeight: FontWeight.bold,fontFamily: "jd"),),
              ),

              Positioned(
                top: size.height*0.2,
                child: Container(
                  width: size.width*0.7,
                  height: size.height*0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      TextField(
                        controller: cnic,
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                        cursorHeight: 24,
                        cursorWidth: 3,
                        keyboardType: TextInputType.number,
                        inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],

                        decoration: InputDecoration(
                          errorText: Cnic_text,
                          prefixIcon: Icon(Icons.person,color: myPrimaryColor ,),
                          hintText: 'CNIC',
                          hintStyle: TextStyle(fontSize: 16),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(70)),
                              borderSide: BorderSide(width: 3,color: myPrimaryColor)
                          ) ,
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(70)),
                              borderSide: BorderSide(color: myPrimaryColor)
                          ) ,
                        ),
                      ),


                      TextField(
                        controller: password,
                        obscureText:hide_password ,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                        cursorHeight: 24,
                        cursorWidth: 3,
                        decoration: InputDecoration(
                          suffixIcon:  IconButton(onPressed: (){
                            setState(() {
                              hide_password=!hide_password;
                            });
                          },icon: Icon(Icons.remove_red_eye,color: myPrimaryColor,size: 28,),),
                          prefixIcon: Icon(Icons.vpn_key_rounded,color: myPrimaryColor,),
                          hintStyle: TextStyle(fontSize: 17),
                          hintText: 'Password',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(70)),
                              borderSide: BorderSide(color: myPrimaryColor,width: 3)
                          ) ,
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(70)),
                              borderSide: BorderSide(color:  myPrimaryColor,)
                          ) ,
                        ),
                      ),
                      Text('\n'),

                      Row(
                        children: [
                          TextButton(onPressed: (){
                            Navigator.push(context, Myroute(ForgotPassword(type: 'patients',)));
                          }, child: Text('Forgot Password ?',style: TextStyle(color: Colors.black87,fontSize: 16,fontFamily: 'Myjd'))),
                          ElevatedButton(onPressed: (){
                            Navigator.push(context, Myroute(Register_patient()));
                          }, style: ElevatedButton.styleFrom(
                              backgroundColor:  myPrimaryColor
                          ),child: Text('Register',style: TextStyle(fontSize: 16,fontFamily: 'Myjd'),))
                        ],
                      )
                    ],),
                ),
              ),



              Positioned(
                top: size.height*0.29,
                left: size.width*0.75,
                child: ElevatedButton(style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFF0B8FAC),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                )
                  ,child: Icon(Icons.arrow_forward,size: 45,color: Colors.white,),onPressed: () async {
                  EasyLoading.show(status: 'Processing');
                    if(cnic.text.isEmpty){
                      EasyLoading.showInfo('CNIC required');
                      return;
                    }
                    var valid_cnic=CNIC_Validate(cnic.text);
                    if(valid_cnic[0]!=null){
                      EasyLoading.showInfo('${valid_cnic[0]}');
                      return;
                    }
                    if(password.text.isEmpty){
                      EasyLoading.showInfo('Password required');
                      return;
                    }

                    var should_login=await new database().Login_patient(cnic: cnic.text,password: password.text);
                  if(should_login){
                    Set_Shared_Preference(cnic: cnic.text,password: password.text,user_type: 'patient');
                    Navigator.push(context, Myroute(Patient_home()));
                  }


                  },),
              ),

              Positioned(
                bottom: size.height*0.14,
                left:size.width*0.32,
                right:size.width*0.32 ,
                child: Image.asset('images/logo.png',height: size.height*0.17,),
              ),
            ],
          )
        ],
      ),
    );
  }
}