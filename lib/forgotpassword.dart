


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kpharma/doctor/doctor_login.dart';
import 'package:kpharma/main.dart';
import 'package:kpharma/patient/patientlogin.dart';
import 'package:kpharma/shared_pref_route.dart';
import 'package:kpharma/sharedpref_validations.dart';




class ForgotPassword extends StatefulWidget{
  var type;
  ForgotPassword({required this.type});
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email=new TextEditingController();
  TextEditingController password=new TextEditingController();
  TextEditingController otp_controller=new TextEditingController();

  bool hide_password=true,is_OTP_sent=false;

  var OTP,result,password_error='',password_error_color=myPrimaryColor,cnic;

  @override
  Widget build(BuildContext context) {

    var size=MediaQuery.of(context).size;
    return  Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(height: size.height,decoration: BoxDecoration(
                  color:  Color(0XFF0B8FAC)
              ),),

              Positioned(
                top: 10,
                left: -100,
                child: Transform.rotate(
                    angle: 1.5,
                    child: SvgPicture.asset('images/triangle.svg',height: size.height*0.8,color: Colors.white,)),
              ),
              Positioned(
                top: size.height*0.01,
                right: 20,
                child: Text('Reset\nPassword',style: TextStyle(fontSize: size.width*0.1,color: Colors.white,
                    fontWeight: FontWeight.bold,fontFamily: "jd"),),
              ),

              Positioned(
                top: size.height*0.25,
                child: Container(
                  width: size.width*0.72,
                  height: size.height*0.3,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(!is_OTP_sent)
                      Container(
                        height: 60,
                        child: TextField(
                          controller: email,
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                          cursorWidth: 3,
                          decoration: InputDecoration(
                            suffix: ElevatedButton(onPressed: () async {
                              EasyLoading.show(status: 'Checking Email');
                              if(email.text.isEmpty){
                                EasyLoading.showInfo('Email required !');
                                return;
                              }
                             var email_valid= Email_Validation(email.text);
                             if(email_valid[1]==Color(0xffffffff)){
                               EasyLoading.showInfo(email_valid[0]);
                               return;
                             }

                             var data= await FirebaseFirestore.instance.collection(widget.type).where('email',isEqualTo: email.text).get();
                             if(data.docs.isEmpty){
                               EasyLoading.showError('Email not registered !');
                               return;
                             }
                             try{
                               EasyLoading.show(status: 'Sending Code');
                               OTP=Generate_OTP();
                               cnic=data.docs.first.data()['cnic'];
                               result=await sendMail(data.docs.first.data()['name'],OTP , email.text,'Hello ${data.docs.first.data()['name']} we have recieved a request to reset your password');
                               if(result){
                                 setState(() {
                                   is_OTP_sent=result;
                                 });
                               }
                               EasyLoading.dismiss();
                             }
                             catch(e)
                             {
                               EasyLoading.showError('Error Sending Code to ${email.text}');
                               return;
                             }

                            },child: Text('Get Code'),),
                            prefixIcon: Icon(Icons.mail,color: Color(0XFF0B8FAC),),
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Enter Email',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                                borderSide: BorderSide(color: Color(0XFF0B8FAC),width: 3)
                            ) ,
                            enabledBorder:OutlineInputBorder(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                                borderSide: BorderSide(color:  Color(0XFF0B8FAC),)
                            ) ,
                          ),
                        ),
                      ),
                      if(is_OTP_sent)
                      TextField(
                        controller: otp_controller,
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                        cursorHeight: 24,
                        cursorWidth: 3,
                        decoration: InputDecoration(

                          prefixIcon: Icon(Icons.mail,color: Color(0XFF0B8FAC),),
                          hintStyle: TextStyle(fontSize: 17),
                          hintText: 'Enter Email code',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(70)),
                              borderSide: BorderSide(color: Color(0XFF0B8FAC),width: 3)
                          ) ,
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(70)),
                              borderSide: BorderSide(color:  Color(0XFF0B8FAC),)
                          ) ,
                        ),
                      ),
                      if(is_OTP_sent)
                      TextField(
                        controller: password,
                        obscureText:hide_password ,
                        onChanged: (a){
                           var result=Password_Validation(a);
                           setState(() {
                             if(result[1]!=Colors.white){
                               password_error='';
                             }
                             else{
                               password_error=result[0];
                             }

                           });

                        },
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                        cursorHeight: 24,
                        cursorWidth: 3,
                        decoration: InputDecoration(
                          suffixIcon:  IconButton(onPressed: (){
                            setState(() {
                              hide_password=!hide_password;
                            });
                          },icon: Icon(Icons.remove_red_eye,color: Color(0XFF0B8FAC),size: 28,),),
                          prefixIcon: Icon(Icons.vpn_key_rounded,color: Color(0XFF0B8FAC),),
                          hintStyle: TextStyle(fontSize: 17),
                          errorText: password_error,
                          errorStyle: TextStyle(color: password_error_color),
                          hintText: 'New Password',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(70)),
                              borderSide: BorderSide(color: Color(0XFF0B8FAC),width: 3)
                          ) ,
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(70)),
                              borderSide: BorderSide(color:  Color(0XFF0B8FAC),)
                          ) ,
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(70)),
                              borderSide: BorderSide(color:  Color(0XFF0B8FAC),)
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(70)),
                              borderSide: BorderSide(color:  Color(0XFF0B8FAC),)
                          ),
                        ),
                      ),

                      if(is_OTP_sent)

                        Container(
                      width: size.width*0.65,
                          child: ElevatedButton(onPressed: () async {
                                     EasyLoading.show(status: 'Processing');
                                     if(otp_controller.text.isEmpty){
                                       EasyLoading.showInfo('Enter Email Code');
                                       return;
                                     }
                                     if(password.text.isEmpty){
                                       EasyLoading.showInfo('Password Required');
                                       return;
                                     }
                             var result=Password_Validation(password.text);
                                     if(result[1]==Colors.white){
                                       EasyLoading.showInfo(result[0]);
                                       return;
                                     }
                                     if(otp_controller.text!=OTP){
                                       EasyLoading.showError('Incorrect Code');
                                       return;
                                     }
                                     try{
                                      var updated= await FirebaseFirestore.instance.collection(widget.type).doc(cnic).update({'password':password.text}).
                                      whenComplete(() => Navigate_to_login());

                                     }
                                     catch(e){
                                       EasyLoading.showError('Not Updated');
                                       return;
                                     }




                            }, style: ElevatedButton.styleFrom(
                                backgroundColor:  Color(0XFF0B8FAC)
                            ),child: Text('Reset',style: TextStyle(fontSize: 16,fontFamily: 'Myjd'),)),
                        )


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
  void Navigate_to_login(){
    EasyLoading.showSuccess('Password Updated');
    if(widget.type=='patients'){
      Navigator.pushReplacement(context, Myroute(patient_login()));
    }
    else{
      Navigator.pushReplacement(context, Myroute(doctor_login()));
    }
  }
}





