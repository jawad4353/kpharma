



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class database{


  Login_doctor( {required password,required license}) async {
      var s=false,license_exist;
      await FirebaseFirestore.instance.collection("doctors").get().then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          if(result.data()['license']==license && result.data()['password']==password && result.data()['accountstatus']=='verified' ){
            EasyLoading.showSuccess('Success');
            s=true;
          }
          else if(result.data()['accountstatus']=='unverified'){
            s=false;
            EasyLoading.showInfo('Unverified Account . We are Verifying your Account .You will get Email within 3 days');
          }
          else{
            s=false;
            license_exist=result.data()['license']==license;
            if(license_exist==false){
              EasyLoading.showError('License not registered');
            }
            else{
              EasyLoading.showError('Incorrect Password');
            }
          }
        });
      });
      return await s;
    }



  Login_patient({required password,required cnic}) async {
    var s=false,cnic_exist;
    await FirebaseFirestore.instance.collection("patients").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        if(result.data()['cnic']==cnic && result.data()['password']==password  && result.data()['accountstatus']=='verified'){
          EasyLoading.showSuccess('Success');
          s=true;
        }
        else if(result.data()['accountstatus']=='unverified'){
          s=false;
          EasyLoading.showInfo('Unverified Account . We are Verifying your Account .You will get Email within 3 days');
        }
        else{
          s=false;
          cnic_exist=result.data()['cnic']==cnic;
          if(cnic_exist==false){
            EasyLoading.showInfo('No patient exists with this CNIC\n$cnic');
          }
          else{
            EasyLoading.showError('Incorrect Password');
          }
        }
      });
    });
    return await s;
  }



  Check_duplicacy_patient({required email,required cnic,required phone}) async {
    var s=false;
    await FirebaseFirestore.instance.collection("patients").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        if(result.data()['cnic']==cnic ){
          EasyLoading.showInfo('CNIC : $cnic is already registered ');
          s=true;
          return;
        }
        if(result.data()['email']==email ){
          EasyLoading.showInfo('Email : $email is already registered ');
          s=true;
          return;
        }
        if(result.data()['phone']==phone ){
          EasyLoading.showInfo('Phone : $phone is already registered ');
          s=true;
          return;
        }

      });
    });
    return s;
  }


  Check_duplicacy_doctor({required email,required cnic,required phone,required license}) async {
    var s=false;
    await FirebaseFirestore.instance.collection("doctors").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        if(result.data()['cnic']==cnic ){
          EasyLoading.showInfo('CNIC : $cnic is already registered ');
          s=true;
          return;
        }
        if(result.data()['email']==email ){
          EasyLoading.showInfo('Email : $email is already registered ');
          s=true;
          return;
        }
        if(result.data()['phone']==phone ){
          EasyLoading.showInfo('Phone : $phone is already registered ');
          s=true;
          return;
        }
        if(result.data()['license']==license){
          EasyLoading.showInfo('License : $license is already registered ');
          s=true;
          return;
        }

      });
    });
    return s;
  }

  Future<bool> Register_Patient(Data) async {
    try{
       var s=FirebaseFirestore.instance.collection('patients').doc(Data['cnic']);
       s.set({'email':Data['email'],'password':Data['password'],'name':Data['name'],
         'cnic':Data['cnic'],'phone':Data['phone'],
         'profileurl':Data['profile_photo'],
         'cnicurl':Data['cnic_photo'],'accountstatus':'unverified','date':'${DateTime.now()}',
         'countrycode':Data['countrycode'],
       });

      EasyLoading.showSuccess('We have recieved your request . We will review it and will let you know via Email within 3 days . ',duration: Duration(seconds: 4));
      return true;
    }
    catch(e){
      var s=e.toString().split(']');
      EasyLoading.showError('! Account has not been created.'
          '${s[1]}');
      return false;
    }
  }

  Future<bool> Register_doctor(Data) async {
    try{
      var s=FirebaseFirestore.instance.collection('doctors').doc(Data['cnic']);
      s.set({'email':Data['email'],'password':Data['password'],'name':Data['name'],
        'cnic':Data['cnic'],'phone':Data['phone'],
        'profileurl':Data['profile_photo'],
        'license':Data['license'],
        'licenseurl':Data['license_photo'],'accountstatus':'unverified','date':'${DateTime.now()}',
        'countrycode':Data['countrycode'],
      });

      EasyLoading.showSuccess('We have recieved your request . We will review it and will let you know via Email within 3 days . ',duration: Duration(seconds: 4));
      return true;
    }
    catch(e){
      var s=e.toString().split(']');
      EasyLoading.showError('! Account has not been created.'
          '${s[1]}');
      return false;
    }
  }





}