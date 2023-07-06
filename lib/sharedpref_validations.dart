
import 'dart:convert';

import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'main.dart';


Future<void> Set_Shared_Preference({required user_type,required cnic,required password}) async {
  SharedPreferences pref =await SharedPreferences.getInstance();
 await pref.setString("cnic", "${cnic}");
  await pref.setString("password", "${password}");
  await pref.setString("usertype", user_type);

}

 Get_Shared_Preference() async {
  SharedPreferences pref =await SharedPreferences.getInstance();
  pref.getString("email");
  pref.getString("password");
  return await pref.getString("usertype");
}



Clear_Preferences() async {
  SharedPreferences pref =await SharedPreferences.getInstance();
  pref.clear();
}



 UploadShop_image(foldername,image_name) async {
  FirebaseStorage _storage=FirebaseStorage.instance;
  PickedFile? _image=await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  var storageref=_storage.ref("${foldername}/${image_name}");
  if(_image==null){
    EasyLoading.showError('Choose any image');
    return false;
  }
  var a= new File(_image!.path);
  EasyLoading.show(status: 'Uploading');
  try{
    var task=storageref.putFile(a as File);
    print(task.whenComplete(() => EasyLoading.showSuccess('Uploaded')));
    return true;
  }
  catch(e){
    EasyLoading.showError('Image has not been Uploaded');
  }

}








bool Validate_Email(email){
  String  pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(email);
}

bool Validate_Password(String password){
  String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(password) ;
}




List Email_Validation(a){
  var mylist=[],is_valid_email;
  if(a.isEmpty){
    mylist.add(null);
    mylist.add(Colors.grey);
    return mylist;
  }
  is_valid_email=EmailValidator.validate(a);
  if(!is_valid_email) {
    mylist.add('Invalid Email');
    mylist.add(Colors.white);
    return mylist;
  }

  if(!'${a}'.endsWith('.com')  ) {
    mylist.add('Invalid Email');
    mylist.add(Colors.white);
    return mylist;
  }

  mylist.add(null);
  mylist.add(Color(0XFF0B8FAC));
  return mylist;


}



List Password_Validation(a){
  var mylist=[],is_valid_email;
  if(a.isEmpty){
    mylist.add(null);
    mylist.add(Colors.grey);
    return mylist;
  }

  if(!Validate_Password(a)) {
    mylist.add('Must have length 8,one upper & lowercase,\ndigit,specialchar');
    mylist.add(Colors.white);
    return mylist;
  }
  if(a.length>16){
    mylist.add('Password length should not exceed 15');
    mylist.add(Colors.white);
    return mylist;
  }

  mylist.add(null);
  mylist.add(Color(0XFF0B8FAC));
  return mylist;


}








List Name_Validation(a){
  var mylist=[];
  if(a.isEmpty){
    mylist.add(null);
    mylist.add(  Color(0XFF0B8FAC));
    return mylist;
  }

  if(a.length<3) {
    mylist.add('Name must have three characters');
    mylist.add(Colors.white);
    return mylist;
  }
  if(a.length>21){
    mylist.add('Name length should not exceed 25');
    mylist.add(Colors.white);
    return mylist;
  }

  mylist.add(null);
  mylist.add(Color(0XFF0B8FAC));
  return mylist;

}




List Address_Validation(a){
  var mylist=[];
  if(a.isEmpty){
    mylist.add(null);
    mylist.add(Colors.grey);
    return mylist;
  }

  if(a.length<8) {
    mylist.add('Must have Eight characters');
    mylist.add(Colors.red);
    return mylist;
  }
  if(a.length>50){
    mylist.add('Address length should not exceed 50');
    mylist.add(Colors.red);
    return mylist;
  }
  mylist.add(null);
  mylist.add(Color(0XFF0B8FAC));
  return mylist;


}




List CNIC_Validate(a)  {
  var mylist=[];
  if(a.isEmpty){
    mylist.add(null);
    mylist.add(Colors.grey);
    return mylist;
  }

  if(a.length<13 || a.length>13){
    mylist.add('Enter 13 digit CNIC');
    mylist.add(Colors.white);
    return mylist;
  }
  mylist.add(null);
  mylist.add(Color(0XFF0B8FAC));
 return mylist;
}


List License_Validate(a)  {
  var mylist=[];
  if(a.isEmpty){
    mylist.add(null);
    mylist.add(Colors.grey);
    return mylist;
  }

  if(a.length<8 || a.length>8){
    mylist.add('Enter 8 digit Liscense number');
    mylist.add(Colors.white);
    return mylist;
  }
  mylist.add(null);
  mylist.add(Color(0XFF0B8FAC));
  return mylist;
}



List phone_Validate(a)  {
  var mylist=[];
  if(a.isEmpty){
    mylist.add(null);
    mylist.add(Colors.grey);
    return mylist;
  }
  if(a.length<10 || a.length>10){
    mylist.add('Enter 10 digit number');
    mylist.add(Colors.white);
    return mylist;
  }
  mylist.add(null);
  mylist.add(Color(0XFF0B8FAC));
  return mylist;
}





 Generate_OTP(){
  var ABC=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q',
    'R','S','T','U','V','W','X','Y','Z'
  ],abc=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p',
  'q','r','s','t','u','v','w','x','y','z'
  ];
  Random a=new Random();
  var random_number=a.nextInt(999999);
  var capital_alphabet=ABC[a.nextInt(ABC.length-1)];
  var capital_alphabet1=ABC[a.nextInt(ABC.length-1)];
  var small_alphabet=abc[a.nextInt(ABC.length-1)];
  return '${capital_alphabet1+small_alphabet+random_number.toString()+capital_alphabet}';
}


Future<bool> sendMail(String name, String OTP, String receiverEmail, String message) async {
  var sent;
  var serviceId = 'service_1mr2zzj';
  var templateId = 'template_lqd9rjw';
  var userId = 'TaINpsabwZn_q2clL';

  try {
    var response = await http.post(
      Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
      headers: {
        'origin': 'http:localhost',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'service_id': serviceId,
        'user_id': userId,
        'template_id': templateId,
        'template_params': {
          'name': name,
          'receiver_email': receiverEmail,
          'OTP': OTP,
          'message': message,
        },
      }),
    );

    if (response.statusCode == 200) {
      sent = true;
    } else {
      sent = false;
    }
  } catch (e) {
    sent = false;
  }

  return sent ?? false;
}





void Customize_Easyloading(){
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor =   myPrimaryColor
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    // ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = true;

}

Future<bool> onClick(context)async{
  return (await showDialog(context: context, builder:(context)=>AlertDialog(
    title: Text('Are you sure?'),
    content:  Text('Do you want to exit this page'),
    actions: [
      ElevatedButton(
        onPressed: () => Navigator.of(context).pop(true),
        child: Text('Yes'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700),
      ),
      ElevatedButton(
        onPressed: () => Navigator.of(context).pop(false),
        child:  Text('No'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700),
      ),
    ],
  ))) ?? false;
}





String getUniqueProductID() {
  var uuid = Uuid();
  var random = Random();
  String uniqueID = uuid.v4();
  int randomInt = random.nextInt(100000);
  return "PRODUCT-$uniqueID-$randomInt";
}


String getUniqueorderID() {
  var uuid = Uuid();
  var random = Random();
  String uniqueID = uuid.v4();
  int randomInt = random.nextInt(100000);
  return "ORDER-$uniqueID-$randomInt";
}

String getUnique_ComplainID() {
  var uuid = Uuid();
  var random = Random();
  String uniqueID = uuid.v4();
  int randomInt = random.nextInt(100000);
  return "Complain-$uniqueID-$randomInt";
}


class show_progress_indicator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Center(child: Container(
        color: Colors.white,
        child: SpinKitFoldingCube(
          size: 50.0,
          duration: Duration(milliseconds: 700),
          itemBuilder: ((context, index) {
            var Mycolors=[ myPrimaryColor,Colors.white];
            var Mycol=Mycolors[index%Mycolors.length];
            return DecoratedBox(decoration: BoxDecoration(
                color: Mycol,
                border: Border.all(color: Colors.green,)

            ));
          }),
        ),
      ),

      );

  }

}