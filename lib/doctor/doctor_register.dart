


import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpharma/doctor/doctor_login.dart';

import '../Database/database.dart';
import '../VerifyOTP.dart';
import '../main.dart';
import '../shared_pref_route.dart';
import '../sharedpref_validations.dart';

class Doctor_register extends StatefulWidget {
  @override
  State<Doctor_register> createState() => _Doctor_registerState();
}

class _Doctor_registerState extends State<Doctor_register> {
  TextEditingController email=new TextEditingController();

  TextEditingController password=new TextEditingController();

  TextEditingController phone=new TextEditingController();

  TextEditingController name=new TextEditingController();

  TextEditingController cnic=new TextEditingController();
  TextEditingController license=new TextEditingController();

  bool hide_password=true;
  var mycolor=Colors.white;

  var Name_error,Email_error,
      Password_error,Cnic_error,
      Phone_error,license_error,Country_code='+92',image_doctor,image_license,Doctor_data={},OTP;

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
                            errorStyle: TextStyle(color: mycolor,fontWeight: FontWeight.w500),
                            hintStyle: TextStyle(fontSize: 16),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 3,color:myPrimaryColor)
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
                        controller: license,
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                        cursorHeight: 24,
                        cursorWidth: 3,
                        keyboardType: TextInputType.number,
                        inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                        onChanged: (a){
                          var result= License_Validate(a);
                          setState(() {
                            license_error=result[0];
                          });
                        },
                        decoration: InputDecoration(
                          errorText: license_error,
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.card_membership,color: myPrimaryColor ,),
                          errorStyle: TextStyle(color: mycolor),
                          hintText: 'License no',
                          hintStyle: TextStyle(fontSize: 16),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 3,color:mycolor)
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
                            Email_error=result[0];
                          });
                        },
                        decoration: InputDecoration(
                            errorText: Email_error,
                            errorStyle: TextStyle(color:mycolor,fontWeight: FontWeight.w500),
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
                            errorStyle: TextStyle(color:mycolor,fontWeight: FontWeight.w500),
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

                          });
                        },
                        inputFormatters: [  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: TextButton(child: Text(Country_code,style: TextStyle(fontSize: 17),),onPressed: (){
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
                                    Country_code='+'+country.phoneCode;
                                  });
                                },
                              );
                            },),
                            hintText: 'Phone',
                            errorText: Phone_error,
                            errorStyle: TextStyle(color:mycolor,fontWeight: FontWeight.w500),
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
                          });
                        },
                        decoration: InputDecoration(
                            filled: true,
                            errorText: Password_error,
                            errorStyle: TextStyle(color:mycolor,fontWeight: FontWeight.w500),
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

                    SizedBox(height: 7,),
                      GestureDetector(
                        onTap:  (){
                          pickImage('profile_photo');
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,width: 3),
                            borderRadius: BorderRadius.circular(10),
                            image: image_doctor == null
                                ? null
                                : DecorationImage(
                              image: FileImage(image_doctor),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: image_doctor == null
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.party_mode_rounded,color: Colors.white,),
                              Text('Your Picture',style: TextStyle(color: Colors.white),)],)
                              : null,
                        ),
                      ),
                      SizedBox(height: 7,),
                      GestureDetector(
                        onTap:  (){
                          pickImage('license_photo');
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,width: 3),
                            borderRadius: BorderRadius.circular(10),
                            image: image_license == null
                                ? null
                                : DecorationImage(
                              image: FileImage(image_license),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: image_license == null
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.party_mode_rounded,color: Colors.white,),
                              Text('License Front Picture',style: TextStyle(color: Colors.white),)],)
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
                    var result;
                    EasyLoading.show(status: 'Processing');
                    if(name.text.isEmpty){
                      EasyLoading.showInfo('Name Required !');
                      return;
                    }
                    var valid_name=Name_Validation(name.text);
                    if(valid_name[0]!=null){
                      EasyLoading.showInfo('${valid_name[0]}');
                      return;
                    }
                    if(license.text.isEmpty){
                      EasyLoading.showInfo('License number required');
                      return;
                    }
                    if(license.text.length!=8){
                      EasyLoading.showInfo('Enter 8 digit license');
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
                    if(image_doctor==null){
                      EasyLoading.showInfo('Upload Your Picture');
                      return;
                    }
                    if(image_license==null){
                      EasyLoading.showInfo('Upload License Front Picture');
                      return;
                    }
                    var duplicate_result=await new database().Check_duplicacy_doctor(license: license.text,cnic: cnic.text,phone:phone.text ,email: email.text);
                    if(duplicate_result){return;}
                    FirebaseStorage _storage=FirebaseStorage.instance;
                    var storageref_license=_storage.ref("doctor_license/${cnic.text}");
                    var storageref_profile=_storage.ref("doctor_profile/${cnic.text}");
                    var a=new File(image_license!.path);
                    var b=new File(image_doctor!.path);
                    UploadTask task,task1;
                    try{
                      task=storageref_license.putFile(a as File);
                      task1=storageref_profile.putFile(b as File);
                    }
                    catch(e){
                      EasyLoading.showError('Images Not uploaded .Try again !');
                      return;
                    }
                    TaskSnapshot storageTaskSnapshot = await task.whenComplete(() => null);
                    TaskSnapshot storageTaskSnapshot1 = await task1.whenComplete(() => null);
                    String  Url_license_photo= await storageTaskSnapshot.ref.getDownloadURL();
                    String  Url_profile_photo= await storageTaskSnapshot1.ref.getDownloadURL();
                    EasyLoading.show(status: 'Sending OTP Code ');
                    OTP=Generate_OTP();
                    Doctor_data['name']='${name.text}';
                    Doctor_data['email']='${email.text}';
                    Doctor_data['cnic']='${cnic.text}';
                    Doctor_data['phone']='${phone.text}';
                    Doctor_data['license']='${license.text}';
                    Doctor_data['password']='${password.text}';
                    Doctor_data['profile_photo']=Url_profile_photo;
                    Doctor_data['license_photo']=Url_license_photo;
                    Doctor_data['otp']='${OTP}';
                    Doctor_data['countrycode']=Country_code;
                    result=await sendMail(name.text, OTP, email.text,'');
                    if(result){
                      Navigator.push(context, Myroute(Verify_OTP(type: 'register_doctor',Data:Doctor_data ,)));
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
                  Navigator.pushReplacement(context, Myroute(doctor_login()));
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
          image_doctor=file;
        });
      }
    }

    if(type=='license_photo'){
      var s = await imagePicker.pickImage(source: ImageSource.gallery);
      if(s==null){
        EasyLoading.showInfo('No Picture Selected');
      }
      if(s!=null){
        final bytes = await s!.readAsBytes();
        final file = File(s.path);
        await file.writeAsBytes(bytes);
        setState(() {
          image_license=file;
        });
      }
    }

  }
}