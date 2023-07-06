



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpharma/shared_pref_route.dart';
import 'package:kpharma/sharedpref_validations.dart';
import 'package:kpharma/selection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class Patient_home extends StatefulWidget{
  @override
  State<Patient_home> createState() => _Patient_homeState();
}

class _Patient_homeState extends State<Patient_home> {
  var user_cnic;
  @override
  void initState() {
    Get_user();
    super.initState();
  }
  Get_user() async {
    SharedPreferences pref =await SharedPreferences.getInstance();
    user_cnic=await pref.getString('cnic');
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
  return  SafeArea(
    child: Scaffold(
backgroundColor: Colors.white,
        body: ListView(
          children: [
           Stack(children: [
             Container(height: size.height*0.2,width: size.width,color: myPrimaryColor,),
             Positioned(
               left: 10,
               top: -24,
               child: Container(
                   height: 130,
                   clipBehavior:  Clip.antiAlias,
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                   ),
                   child: Image.asset('images/my.jpg',fit: BoxFit.fill)),
             ),

           Positioned(
             right: 0,
               top: 0,
               child: IconButton(onPressed: (){}, icon: Icon(Icons.notifications,size: 35,color: Colors.white,))),

           Positioned(
               left: size.width*0.22,
               top: 8,
               child: StreamBuilder(
                 stream: FirebaseFirestore.instance.collection('patients').doc(user_cnic).snapshots(),
                 builder: (context,snap){
                   if (!snap.hasData && snap.hasError ) {
                     return show_progress_indicator();
                   }

                   return Text(snap.data!.data()!['name'],style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500),);

                 },
               )),
             Positioned(
                 left: size.width*0.22,
                 top: 27,
                 child: Text('Lahore , Pakistan',style: TextStyle(fontSize: 16,color: Colors.white),)),

          Positioned(
            left: 0,
            right: 0,
            top: size.height*0.1,
            child: Container(

              padding: EdgeInsets.only(left: size.width*0.1,right: size.width*0.1),
              child: TextField(decoration: InputDecoration(
                  filled:true,
                  contentPadding: EdgeInsets.zero,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)
                  )
              ))), ),

             Positioned(
              top: size.height*0.18,
               left: 0,
               right: 0,
               child: Container(
                 height: 60,decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
               ),

               ),
             ),
           ],),

            Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Buttons(icon: Icons.email,text: 'Ambulance',),
              Buttons(icon: Icons.directions,text: 'Check Up',),
              Buttons(icon: Icons.verified,text: 'Oxygen',),
              Buttons(icon: Icons.coronavirus,text: 'Covid 19',),

            ],),
            Text(''),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Buttons(icon: Icons.ac_unit_outlined,text: 'Medicine',),
              Buttons(icon: Icons.person,text: 'Doctor',),
              Buttons(icon: Icons.no_drinks,text: 'Tests',),
              Buttons(icon: Icons.logout,text: 'Logout',),

            ],),
            Text('\n   Specialists',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
      Container(
      color: Colors.white,
      height: 500,
      width: size.width,
      padding: const EdgeInsets.all(8.0),
      child:  GridView.builder(

        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 5,
          childAspectRatio:size.width / 690,

        ),
        itemCount: 6,
        itemBuilder: (context, index) {

          return   Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                border: Border.all(width: 3,color: Colors.black12)
            ),
            child: InkWell(
              onTap: () {

              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 165,
                    child: Image.asset(
                      'images/my.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 90,
                        height: 22,
                        decoration:BoxDecoration(
                            color:myPrimaryColor,
                            borderRadius: BorderRadius.circular(15)),
                          child: Center(child: Text('Dentist',style: TextStyle(color: Colors.white),))),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Jawad',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Hello this is jawad aslam'),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ' \R.s 4843',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: myPrimaryColor,
                            ),
                          ),


                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,

                        children: [
                          ElevatedButton(

                            onPressed: () {

                            },

                            child: Text('Appoint'),
                          ),
                        ],
                      )
                    ],
                  ),

                ],
              ),
            ),

          );
        },
      ),

    ),


          ],
        ),


        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,

          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.sms,),label: 'Messages'),
            BottomNavigationBarItem(icon: Icon(Icons.report,),label: 'Support'),

          ],
        ),

    ),
  );
  }
}



class Buttons extends StatelessWidget{
  var icon,text;
  Buttons({required this.icon,required this.text});
  @override
  Widget build(BuildContext context) {
  return InkWell(
    onTap: (){
      print(text);
      if(text=='Logout'){
        Clear_Preferences();
        Navigator.pushReplacement(context, Myroute(Selection()));
      }
    },
    child: Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
          // boxShadow: [BoxShadow(color:Colors.black12,spreadRadius: 2)]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Icon(icon,color: myPrimaryColor,),
        Text('$text',)
      ],),
    ),
  );
  }
}