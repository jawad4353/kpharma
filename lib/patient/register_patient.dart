


import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpharma/patient/patienthome.dart';
import 'package:kpharma/patient/patientlogin.dart';

import '../Database/database.dart';
import '../VerifyOTP.dart';
import '../main.dart';
import '../shared_pref_route.dart';
import '../sharedpref_validations.dart';

class Register_patient extends StatefulWidget{
  @override
  State<Register_patient> createState() => _Register_patientState();
}


class _Register_patientState extends State<Register_patient> {
  TextEditingController email=new TextEditingController();
  TextEditingController password=new TextEditingController();
  TextEditingController phone=new TextEditingController();
  TextEditingController name=new TextEditingController();
  TextEditingController cnic=new TextEditingController();
  bool hide_password=true;
  var Name_error,Name_error_color=  Color(0XFF0B8FAC),Email_error,Email_error_color=Color(0XFF0B8FAC),
  Password_error,Password_error_color=Color(0XFF0B8FAC),Cnic_error,Cnic_error_color=Color(0XFF0B8FAC),
  Phone_error,Phone_error_color=Color(0XFF0B8FAC),image_patient,image_cnic,Patient_data={},countrycode='+92';
  final picker = ImagePicker();
  var imagePicker=ImagePicker();


  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return  Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(height: size.height,decoration: BoxDecoration(
                  color: Colors.white
              ),),

              Positioned(
                top: -60,
                left: -100,
                child: Transform.rotate(
                    angle: 1.5,
                    child: SvgPicture.asset('images/triangle.svg',height: size.height*1.1,color:  myPrimaryColor,)),
              ),
              Positioned(
                top: size.height*0.05,
                right: 30,
                child: Text('Register',style: TextStyle(fontSize: 45,color:  myPrimaryColor,
                    fontWeight: FontWeight.bold,fontFamily: "jd"),),
              ),

              Positioned(
                top: size.height*0.19,
                child: Container(
                  width: size.width*0.72,
                  height: size.height*0.5,
                  child: ListView(
                    children: [
                      TextField(
                        controller: name,
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                        cursorHeight: 24,
                        cursorWidth: 3,
                        onChanged: (a){
                          var result=Name_Validation(a);
                           setState(() {
                             Name_error_color=result[1];
                             Name_error=result[0];
                           });
                        },
                        inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]')),],

                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.person,color:  myPrimaryColor ,),
                          hintText: 'Name',
                            errorText: Name_error,
                            errorStyle: TextStyle(color: Name_error_color,fontWeight: FontWeight.w500),
                          hintStyle: TextStyle(fontSize: 16),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 3,color:Name_error_color)
                            ) ,
                          enabledBorder:OutlineInputBorder(
                              borderSide: BorderSide(color:  myPrimaryColor)
                          ) ,
                          focusedErrorBorder:  OutlineInputBorder(
                              borderSide: BorderSide(width: 3,color: myPrimaryColor)
                          )

                        ),

                      ),
                      TextField(
                        controller: email,
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                        cursorHeight: 24,
                        cursorWidth: 3,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.-.@-@_-_]')),],
                      onChanged: (a){
                        var result=Email_Validation(a);
                        setState(() {
                          Email_error_color=result[1];
                          Email_error=result[0];
                        });
                      },
                        decoration: InputDecoration(
                            errorText: Email_error,
                            errorStyle: TextStyle(color:Email_error_color,fontWeight: FontWeight.w500),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.mail,color:  myPrimaryColor ,),
                          hintText: 'Email',
                          hintStyle: TextStyle(fontSize: 16),
                          focusedBorder: OutlineInputBorder(

                              borderSide: BorderSide(width: 3,color: myPrimaryColor)
                          ) ,
                          enabledBorder:OutlineInputBorder(

                              borderSide: BorderSide(color:  myPrimaryColor)
                          ) ,
                            focusedErrorBorder:  OutlineInputBorder(
                                borderSide: BorderSide(width: 3,color: myPrimaryColor)
                            )
                        ),

                      ),

                      TextField(
                       controller: cnic,
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                        cursorHeight: 24,
                        cursorWidth: 3,
                        onChanged: (a){
                          var result=CNIC_Validate(a);
                          setState(() {
                            Cnic_error_color=result[1];
                            Cnic_error=result[0];
                          });
                        },
                        inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.keyboard_sharp,color:  myPrimaryColor ,),
                          hintText: 'CNIC',
                            errorText: Cnic_error,
                            errorStyle: TextStyle(color:Cnic_error_color,fontWeight: FontWeight.w500),
                          hintStyle: TextStyle(fontSize: 16),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:  BorderRadius.only(topRight: Radius.circular(1),bottomRight:Radius.circular(1),),
                              borderSide: BorderSide(width: 3,color:  myPrimaryColor)
                          ) ,
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(1),bottomRight:Radius.circular(1),),
                              borderSide: BorderSide(color:  myPrimaryColor)
                          ) ,
                            focusedErrorBorder:  OutlineInputBorder(
                                borderSide: BorderSide(width: 3,color: myPrimaryColor)
                            )


                        ),

                      ),
                      TextField(
                       controller: phone,
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                        cursorHeight: 24,
                        cursorWidth: 3,
                        onChanged: (a){
                          var result=phone_Validate(a);

                          setState(() {
                            Phone_error=result[0];
                            Phone_error_color=result[1];
                          });
                        },
                        inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Phone',
                          prefixIcon: TextButton(onPressed: (){
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              countryListTheme: CountryListThemeData(
                                  inputDecoration: InputDecoration(
                                    hintText: 'Search',
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedErrorBorder:UnderlineInputBorder(borderSide: BorderSide(color: myPrimaryColor))  ,
                                    focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color:  myPrimaryColor)) ,
                                    enabledBorder:UnderlineInputBorder(borderSide: BorderSide(color: myPrimaryColor)) ,
                                    errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: myPrimaryColor)),
                                    border:  UnderlineInputBorder(borderSide: BorderSide(color: myPrimaryColor)),
                                  )
                              ),// optional. Shows phone code before the country name.
                              onSelect: (Country country) {
                                setState(() {
                                  countrycode='+'+country.phoneCode;
                                });
                              },
                            );
                          },child: Text(countrycode,style: TextStyle(fontSize: 17),),),
                          errorText: Phone_error,
                          errorStyle: TextStyle(color:Phone_error_color,fontWeight: FontWeight.w500),
                          hintStyle: TextStyle(fontSize: 16),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:  BorderRadius.only(topRight: Radius.circular(1),bottomRight:Radius.circular(1),),
                              borderSide: BorderSide(width: 3,color:  myPrimaryColor)
                          ) ,
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(1),bottomRight:Radius.circular(1),),
                              borderSide: BorderSide(color:  myPrimaryColor)
                          ) ,
                            focusedErrorBorder:  OutlineInputBorder(
                                borderSide: BorderSide(width: 3,color: myPrimaryColor)
                            )
                        ),
                      ),

                      TextField(
                        controller: password,
                        obscureText:hide_password ,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                        cursorHeight: 24,
                        cursorWidth: 3,
                        onChanged: (a){
                          var result=Password_Validation(a);
                          setState(() {
                            Password_error=result[0];
                            Password_error_color=result[1];
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                            errorText: Password_error,
                            errorStyle: TextStyle(color:Password_error_color,fontWeight: FontWeight.w500),
                          fillColor: Colors.white,
                          suffixIcon:  IconButton(onPressed: (){
                            setState(() {
                              hide_password=!hide_password;
                            });
                          },icon: Icon(Icons.remove_red_eye,color:  myPrimaryColor,size: 28,),),
                          prefixIcon: Icon(Icons.vpn_key_rounded,color:  myPrimaryColor,),
                          hintStyle: TextStyle(fontSize: 17),
                          hintText: 'Password',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:  myPrimaryColor,width: 3)
                          ) ,
                          enabledBorder:OutlineInputBorder(

                              borderSide: BorderSide(color:   myPrimaryColor,)
                          ) ,
                            focusedErrorBorder:  OutlineInputBorder(
                                borderSide: BorderSide(width: 3,color: myPrimaryColor)
                            )

                        ),
                      ),
                      SizedBox(height: 6,),
                      GestureDetector(
                        onTap:(){pickImage('profile_photo');} ,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,width: 3),
                            borderRadius: BorderRadius.circular(10),
                            image: image_patient == null
                                ? null
                                : DecorationImage(
                              image: FileImage(image_patient),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: image_patient == null
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.party_mode_rounded,color: Colors.white,),
                              Text('Your Picture',style: TextStyle(color: Colors.white),)],)
                              : null,
                        ),
                      ),
                      SizedBox(height: 6,),
                      GestureDetector(
                        onTap:(){pickImage( 'cnic_photo');} ,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,width: 3),
                            borderRadius: BorderRadius.circular(10),
                            image: image_cnic == null
                                ? null
                                : DecorationImage(
                              image: FileImage(image_cnic),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: image_cnic == null
                              ?  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Icon(Icons.party_mode_rounded,color: Colors.white,),
                                Text('Cnic Front Picture',style: TextStyle(color: Colors.white),)],)
                              : null,
                        ),
                      ),
                    ],),
                ),
              ),

              Positioned(
                top: size.height*0.32,
                right: 10,
                child: ElevatedButton(style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                )
                  ,child: Icon(Icons.arrow_forward,size: 45,color:  myPrimaryColor,),onPressed: () async {
                 var OTP,result;
                  EasyLoading.show(status: 'Processing');
                  if(name.text.isEmpty){
                    EasyLoading.showInfo('Name required');
                    return;
                  }
                  var valid_name=Name_Validation(name.text);
                  if(valid_name[0]!=null){
                    EasyLoading.showInfo('${valid_name[0]}');
                    return;
                  }
                  if(email.text.isEmpty){
                    EasyLoading.showInfo('Email required');
                    return;
                  }
                  var valid_email=Email_Validation(email.text);
                  if(valid_email[0]!=null){
                    EasyLoading.showInfo('${valid_email[0]}');
                    return;
                  }
                  if(cnic.text.isEmpty){
                    EasyLoading.showInfo('CNIC required');
                    return;
                  }
                  var valid_cnic=CNIC_Validate(cnic.text);
                  if(valid_cnic[0]!=null){
                    EasyLoading.showInfo('${valid_cnic[0]}');
                    return;
                  }
                  if(phone.text.isEmpty){
                    EasyLoading.showInfo('Phone required');
                    return;
                  }
                  var valid_phone=phone_Validate(phone.text);
                  if(valid_phone[0]!=null){
                    EasyLoading.showInfo('${valid_phone[0]}');
                    return;
                  }
                  if(password.text.isEmpty){
                    EasyLoading.showInfo('Password required');
                    return;
                  }
                  var valid_password=Password_Validation(password.text);
                  if(valid_password[0]!=null){
                    EasyLoading.showInfo('${valid_password[0]}');
                    return;
                  }
                  if(image_patient==null){
                    EasyLoading.showInfo('Upload Your Picture');
                    return;
                  }
                  if(image_cnic==null){
                    EasyLoading.showInfo('Upload CNIC Picture');
                    return;
                  }
                var duplicate_result=await new database().Check_duplicacy_patient(cnic: cnic.text,phone:phone.text ,email: email.text);
                  if(duplicate_result){return;}
                 FirebaseStorage _storage=FirebaseStorage.instance;
                 var storageref_cnic=_storage.ref("patient_cnic/${cnic.text}");
                 var storageref_profile=_storage.ref("patient_profile/${cnic.text}");
                 var a=new File(image_cnic!.path);
                 var b=new File(image_patient!.path);
                 UploadTask task,task1;
                 try{
                   task=storageref_cnic.putFile(a as File);
                   task1=storageref_profile.putFile(b as File);
                 }
                 catch(e){
                   EasyLoading.showError('Images Not uploaded .Try again !');
                   return;
                 }
                 TaskSnapshot storageTaskSnapshot = await task.whenComplete(() => null);
                 TaskSnapshot storageTaskSnapshot1 = await task1.whenComplete(() => null);
                 String  Url_cnic_photo= await storageTaskSnapshot.ref.getDownloadURL();
                 String  Url_profile_photo= await storageTaskSnapshot1.ref.getDownloadURL();

                 EasyLoading.show(status: 'Sending OTP Code ');
                 OTP=Generate_OTP();
                 Patient_data['name']='${name.text}';
                 Patient_data['email']='${email.text}';
                 Patient_data['cnic']='${cnic.text}';
                 Patient_data['phone']='${phone.text}';
                 Patient_data['password']='${password.text}';
                 Patient_data['profile_photo']=Url_profile_photo;
                 Patient_data['cnic_photo']=Url_cnic_photo;
                 Patient_data['otp']='${OTP}';
                 Patient_data['countrycode']=countrycode;
                  result=await sendMail(name.text, OTP, email.text,'');

                 if(result){
                   Navigator.push(context, Myroute(Verify_OTP(type: 'register_patient',Data:Patient_data ,)));
                   EasyLoading.dismiss();
                 }
                 else{
                   EasyLoading.showError('Error Sending Email');
                   return;
                 }



                  },),
              ),

              Positioned(
                top: size.height*0.69,
                left:10 ,
                child:   TextButton(onPressed: (){
                  Navigator.pushReplacement(context, Myroute(patient_login()));
                }, child: Text('Already Registered ?',style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Myjd'))),
              ),

            ],
          )
        ],
      ),


    );
  }


    pickImage(type)  async {
    if(type=='profile_photo'){
      var s = await imagePicker.pickImage(source: ImageSource.gallery);
      if(s==null){
        EasyLoading.showInfo('No Picture Selected');
      }
      if(s!=null){
        final bytes = await s!.readAsBytes();
        final file = File(s.path);
        await file.writeAsBytes(bytes);
        setState(() {
          image_patient=file;
        });
      }
    }

    if(type=='cnic_photo'){
      var s = await imagePicker.pickImage(source: ImageSource.gallery);
      if(s==null){
        EasyLoading.showInfo('No Picture Selected');
      }
      if(s!=null){
        final bytes = await s!.readAsBytes();
        final file = File(s.path);
        await file.writeAsBytes(bytes);
        setState(() {
          image_cnic=file;
        });
      }
    }

  }

}